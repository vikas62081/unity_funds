import 'package:uuid/uuid.dart';

var uuid = const Uuid().v4();

class Member {
  final String id;
  final String name;
  final String phoneNumber;
  final int familyMemberCount;
  final String address;

  Member(
      {required this.name,
      required this.phoneNumber,
      required this.familyMemberCount,
      required this.address})
      : id = uuid;
}
