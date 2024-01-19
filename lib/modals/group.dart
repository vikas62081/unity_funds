import 'dart:io';
import 'package:uuid/uuid.dart';

var uuid = const Uuid().v4();

class Group {
  Group(
      {required this.name,
      required this.description,
      required this.isDefault,
      required this.eventDate,
      required this.files})
      : id = uuid,
        createdAt = DateTime.now();

  final String id;
  final String name;
  final String description;
  final bool isDefault;
  final DateTime eventDate;
  final DateTime createdAt;
  final List<File>? files;
}
