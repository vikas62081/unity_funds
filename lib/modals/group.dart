import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

var _format = DateFormat("d MMM");
var uuid = const Uuid();
final now = DateTime.now();

class Group {
  Group({
    required this.name,
    required this.description,
    required this.eventDate,
    required this.image,
  })  : id = const Uuid().v4(),
        totalCollected = 0,
        totalExpenses = 0,
        createdAt = now,
        updatedAt = now;

  late String id;
  final String name;
  final String description;
  final DateTime eventDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  late String image;
  final double totalCollected;
  final double totalExpenses;

  Group.transactionalUpdate({
    required this.name,
    required this.description,
    required this.eventDate,
    required this.id,
    required this.createdAt,
    required this.totalCollected,
    required this.totalExpenses,
    required this.image,
  }) : updatedAt = DateTime.now();

  setId(String id) {
    this.id = id;
  }

  setImage(String url) {
    image = url;
  }

  String get formattedEventDate {
    return _format.format(eventDate);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'eventDate': eventDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'image': image,
      "totalCollected": totalCollected,
      'totalExpenses': totalExpenses,
    };
  }

  factory Group.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Group.transactionalUpdate(
      id: doc.id,
      name: data['name'],
      description: data['description'],
      eventDate: (data['eventDate'] as Timestamp).toDate(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      image: data['image'],
      totalCollected: data['totalCollected'],
      totalExpenses: data['totalExpenses'],
    );
  }

  @override
  String toString() {
    return 'Group{id: $id, name: $name, description: $description, '
        'eventDate: $eventDate, createdAt: $createdAt, image: $image, '
        'totalCollected: $totalCollected, totalExpenses: $totalExpenses}';
  }
  // You can add setters for other properties as needed
}
