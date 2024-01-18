import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

var uuid = const Uuid().v4();
var formate = DateFormat("d MMM");
Random random = Random();
// ignore: constant_identifier_names
const LIGHT_COLORS = [
  Color.fromARGB(255, 204, 219, 160),
  Color.fromARGB(255, 204, 173, 219),
  Color.fromARGB(255, 219, 237, 233),
  Color.fromARGB(255, 219, 208, 160),
  Color.fromARGB(255, 240, 215, 170),
  Color.fromARGB(255, 186, 208, 208),
  Color.fromARGB(255, 219, 171, 189),
  Color.fromARGB(255, 223, 197, 163),
  Color.fromARGB(255, 208, 208, 142),
  Color.fromARGB(255, 193, 218, 198),
];

String formatCategory(ExpenseCategory category) {
  String catName = category.name;
  return catName[0].toUpperCase() + catName.substring(1);
}

enum ExpenseCategory { cinema, cash, food, shopping }

class Expense {
  final String id;
  final String description;
  final ExpenseCategory category;
  final String group;
  final double amount;
  final DateTime createdAt;
  final Color color;

  Expense(
      {required this.description, required this.category, required this.amount})
      : id = uuid,
        group = "N/A",
        createdAt = DateTime.now(),
        color = LIGHT_COLORS[random.nextInt(LIGHT_COLORS.length)];

  String get formattedDate {
    return formate.format(createdAt);
  }

  String get formattedCategory {
    return formatCategory(category);
  }
}
