import 'dart:io';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

var _format = DateFormat("d MMM");

var uuid = const Uuid();

class Group {
  Group({
    required this.name,
    required this.description,
    required this.eventDate,
    required this.image,
    this.totalCollected,
    this.totalExpenses,
  })  : id = const Uuid().v4(),
        createdAt = DateTime.now();

  final String id;
  final String name;
  final String description;
  final DateTime eventDate;
  final DateTime createdAt;
  final File image;
  final double? totalCollected;
  final double? totalExpenses;

  Group.transactionalUpdate({
    required this.name,
    required this.description,
    required this.eventDate,
    required this.image,
    required this.id,
    required this.createdAt,
    required this.totalCollected,
    required this.totalExpenses,
  });

  String get formattedEventDate {
    return _format.format(eventDate);
  }

  @override
  String toString() {
    return 'Group{id: $id, name: $name, description: $description, '
        'eventDate: $eventDate, createdAt: $createdAt, image: $image, '
        'totalCollected: $totalCollected, totalExpenses: $totalExpenses}';
  }
  // You can add setters for other properties as needed
}
