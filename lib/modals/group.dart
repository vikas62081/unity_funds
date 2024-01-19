import 'dart:io';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

var _format = DateFormat("d MMM");

var uuid = const Uuid().v4();

class Group {
  Group(
      {required this.name,
      required this.description,
      required this.isDefault,
      required this.eventDate,
      required this.image})
      : id = uuid,
        createdAt = DateTime.now();

  final String id;
  final String name;
  final String description;
  final bool isDefault;
  final DateTime eventDate;
  final DateTime createdAt;
  final File image;

  String get formattedEventDate {
    return _format.format(eventDate);
  }
}
