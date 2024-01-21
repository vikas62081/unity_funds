import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class User {
  final String id;
  final String name;
  final String phoneNumber;
  final int familyMemberCount;
  final String address;
  final String? defaultGroup;

  User(
      {required this.name,
      required this.phoneNumber,
      required this.familyMemberCount,
      required this.address})
      : id = uuid.v4(),
        defaultGroup = null;
}
