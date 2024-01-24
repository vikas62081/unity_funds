import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final String? bill;
  final String? groupId;
  final String groupName;
  final double amount;
  final Color color;
  final String? contributorName;
  final String? contributorUserId;
  final TransactionType type;
  final DateTime createdAt;
  final DateTime updatedAt;

  Transaction(
      {required this.id,
      required this.description,
      required this.bill,
      required this.groupId,
      required this.groupName,
      required this.amount,
      required this.color,
      required this.contributorName,
      required this.contributorUserId,
      required this.type,
      required this.createdAt,
      required this.updatedAt});

  Transaction.debit(
      {required this.groupId,
      required this.groupName,
      required this.bill,
      required this.description,
      required this.amount})
      : id = uuid.v4(),
        contributorName = null,
        contributorUserId = null,
        type = TransactionType.debit,
        createdAt = now,
        updatedAt = now,
        color = LIGHT_COLORS[random.nextInt(LIGHT_COLORS.length)];

  Transaction.credit(
      {required this.groupId,
      required this.groupName,
      required this.amount,
      required this.contributorName,
      required this.contributorUserId})
      : id = uuid.v4(),
        description = null,
        bill = null,
        type = TransactionType.credit,
        createdAt = now,
        updatedAt = now,
        color = LIGHT_COLORS[random.nextInt(LIGHT_COLORS.length)];

  Map<String, dynamic> toFirestore() {
    return {
      'description': description,
      'bill': bill,
      'groupId': groupId,
      'groupName': groupName,
      'amount': amount,
      'color': color.value,
      'contributorName': contributorName,
      'contributorUserId': contributorUserId,
      'type': type == TransactionType.debit ? 'debit' : 'credit',
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  static Transaction fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Transaction(
      id: doc.id,
      description: data['description'],
      bill: data['bill'],
      groupId: data['groupId'],
      groupName: data['groupName'],
      amount: data['amount'],
      color: Color(data['color']),
      contributorName: data['contributorName'],
      contributorUserId: data['contributorUserId'],
      type: data['type'] == 'debit'
          ? TransactionType.debit
          : TransactionType.credit,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  String get formattedMonth {
    return _format.format(createdAt);
  }

  String get formattedCreatedDate {
    return _formatDate.format(createdAt);
  }
}
