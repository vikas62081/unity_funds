import 'dart:io';

import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class User {
  final String id;
  final String name;
  final String phoneNumber;
  final int familyMemberCount;
  final String address;
  final String? defaultGroupName;
  final String? email;
  final String? defaultGroupId;
  final File? image;

  User(
      {required this.name,
      required this.phoneNumber,
      required this.familyMemberCount,
      required this.address,
      this.email,
      this.defaultGroupId,
      this.defaultGroupName,
      this.image})
      : id = uuid.v4();
}
