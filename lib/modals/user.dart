import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class User {
  late final String id;
  final String name;
  final String phoneNumber;
  final int familyMemberCount;
  final String address;
  final String? defaultGroupName;
  final String? email;
  final String? defaultGroupId;
  final String? profilePic;

  User(
      {required this.name,
      required this.phoneNumber,
      required this.familyMemberCount,
      required this.address,
      this.email,
      this.defaultGroupId,
      this.defaultGroupName,
      this.profilePic,
      required this.id});

  User.createMember({
    required this.name,
    required this.phoneNumber,
    required this.familyMemberCount,
    required this.address,
  })  : email = null,
        defaultGroupId = null,
        defaultGroupName = null,
        profilePic = null,
        id = uuid.v4();

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'familyMemberCount': familyMemberCount,
      'address': address,
      'email': email,
      'defaultGroupId': defaultGroupId,
      'defaultGroupName': defaultGroupName,
      'profilePic': profilePic,
    };
  }

  static User fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      name: data['name'],
      phoneNumber: data['phoneNumber'],
      familyMemberCount: data['familyMemberCount'],
      address: data['address'],
      email: data['email'],
      defaultGroupId: data['defaultGroupId'],
      defaultGroupName: data['defaultGroupName'],
      profilePic: data['profilePic'],
    );
  }
}
