import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

var uuid = const Uuid().v4();
var _format = DateFormat.MMM();
Random random = Random();

enum transactionType { credit, debit }

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

// const LIGHT_COLORS = [
//   Color.fromARGB(100, 157, 92, 176),
//   Color.fromARGB(100, 92, 111, 176),
//   Color.fromARGB(100, 111, 176, 92),
//   Color.fromARGB(100, 176, 157, 92),
// ];

class Transaction {
  final String id;
  final String? description;
  final File? bill;
  final String group;
  final double amount;
  final DateTime createdAt;
  final Color color;
  final String? member;
  final transactionType type;

  Transaction.debit(
      {required this.group,
      required this.bill,
      required this.description,
      required this.amount})
      : id = uuid,
        member = null,
        type = transactionType.debit,
        createdAt = DateTime.now(),
        color = LIGHT_COLORS[random.nextInt(LIGHT_COLORS.length)];

  Transaction.credit(
      {required this.group, required this.amount, required this.member})
      : id = uuid,
        description = "N/A",
        bill = null,
        type = transactionType.credit,
        createdAt = DateTime.now(),
        color = LIGHT_COLORS[random.nextInt(LIGHT_COLORS.length)];

  String get formattedMonth {
    return _format.format(createdAt);
  }
}
