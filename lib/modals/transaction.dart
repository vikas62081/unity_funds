import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:unity_funds/utils/colors.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

var uuid = const Uuid();
var _format = DateFormat.MMM();
var _formatDate = DateFormat("dd MMM, yyyy");
Random random = Random();
DateTime now = DateTime.now();

enum TransactionType { credit, debit }

class Transaction {
  final String id;
  final String? description;
  final File? bill;
  final String? groupId;
  final String group;
  final double amount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Color color;
  final String? userName;
  final String? userId;
  final TransactionType type;

  Transaction.debit(
      {required this.group,
      required this.bill,
      required this.description,
      required this.amount})
      : id = uuid.v4(),
        userName = null,
        userId = null,
        groupId = null,
        type = TransactionType.debit,
        createdAt = now,
        updatedAt = now,
        color = LIGHT_COLORS[random.nextInt(LIGHT_COLORS.length)];

  Transaction.credit(
      {required this.group, required this.amount, required this.userName})
      : id = uuid.v4(),
        description = "N/A",
        bill = null,
        userId = null,
        groupId = null,
        type = TransactionType.credit,
        createdAt = now,
        updatedAt = now,
        color = LIGHT_COLORS[random.nextInt(LIGHT_COLORS.length)];

  String get formattedMonth {
    return _format.format(createdAt);
  }

  String get formattedCreatedDate {
    return _formatDate.format(createdAt);
  }
}
