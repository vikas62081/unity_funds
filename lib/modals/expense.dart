import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

var uuid = const Uuid().v4();
var _format = DateFormat("d MMM");
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

class Expense {
  final String id;
  final String description;
  final File? bill;
  final String group;
  final double amount;
  final DateTime createdAt;
  final Color color;

  Expense(
      {required this.group,
      required this.bill,
      required this.description,
      required this.amount})
      : id = uuid,
        createdAt = DateTime.now(),
        color = LIGHT_COLORS[random.nextInt(LIGHT_COLORS.length)];

  // Expense.withoutBill(
  //     {required this.group, required this.description, required this.amount})
  //     : id = uuid,
  //       bill = null,
  //       createdAt = DateTime.now(),
  //       color = LIGHT_COLORS[random.nextInt(LIGHT_COLORS.length)];

  String get formattedDate {
    return _format.format(createdAt);
  }
}
