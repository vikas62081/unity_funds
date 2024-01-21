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

enum TransactionType { credit, debit }

class Transaction {
  final String id;
  final String? description;
  final File? bill;
  final String group;
  final double amount;
  final DateTime createdAt;
  final Color color;
  final String? member;
  final TransactionType type;

  Transaction.debit(
      {required this.group,
      required this.bill,
      required this.description,
      required this.amount})
      : id = uuid.v4(),
        member = null,
        type = TransactionType.debit,
        createdAt = DateTime.now(),
        color = LIGHT_COLORS[random.nextInt(LIGHT_COLORS.length)];

  Transaction.credit(
      {required this.group, required this.amount, required this.member})
      : id = uuid.v4(),
        description = "N/A",
        bill = null,
        type = TransactionType.credit,
        createdAt = DateTime.now(),
        color = LIGHT_COLORS[random.nextInt(LIGHT_COLORS.length)];

  String get formattedMonth {
    return _format.format(createdAt);
  }

  String get formattedCreatedDate {
    return _formatDate.format(createdAt);
  }
}
