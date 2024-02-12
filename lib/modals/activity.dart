import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var _format = DateFormat("d MMM yyyy").add_jm();

enum ActivityType {
  newUser,
  newGroup,
  debitTransaction,
  creditTransaction,
  userProfileUpdate,
}

const messages = {
  ActivityType.newUser: [" has added "],
  ActivityType.newGroup: [" created a new group "],
  ActivityType.creditTransaction: [" contributed to "],
  ActivityType.debitTransaction: [" has spent in ", " for "]
};

class Activity {
  final String? id;
  final ActivityType type;
  final List<String>? message;
  final double amount;
  final String createdBy;
  final DateTime createdAt;
  final String? groupName;
  final String? newUser;
  final String? contributorName;
  final String? expense;

  Activity(
      {required this.id,
      required this.type,
      required this.message,
      required this.amount,
      required this.createdBy,
      required this.createdAt,
      this.groupName,
      this.newUser,
      this.contributorName,
      this.expense});

  Activity.group({required this.groupName, required this.createdBy})
      : type = ActivityType.newGroup,
        createdAt = DateTime.now(),
        id = null,
        newUser = null,
        amount = 0,
        contributorName = null,
        message = null,
        expense = null;

  Activity.user({required this.createdBy, required this.newUser})
      : type = ActivityType.newUser,
        createdAt = DateTime.now(),
        id = null,
        amount = 0,
        groupName = null,
        message = null,
        contributorName = null,
        expense = null;

  Activity.credit(
      {required this.createdBy,
      required this.groupName,
      required this.amount,
      required this.contributorName})
      : type = ActivityType.creditTransaction,
        createdAt = DateTime.now(),
        id = null,
        message = null,
        newUser = null,
        expense = null;
  // message: "Vikas contributed to Holi",
  Activity.debit(
      {required this.createdBy,
      required this.groupName,
      required this.amount,
      required this.expense})
      : type = ActivityType.debitTransaction,
        createdAt = DateTime.now(),
        id = null,
        newUser = null,
        message = null,
        contributorName = null;
  // "Owner added $expense in $group Group for $amount rupees"

  factory Activity.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final type = ActivityType.values.firstWhere(
      (e) => e.toString() == 'ActivityType.' + data['type'],
      orElse: () => ActivityType.newUser,
    );
    return Activity(
      id: doc.id,
      type: type,
      message: getMessageList(type),
      amount: data['amount'] != null ? data['amount'].toDouble() : 0,
      groupName: data['groupName'],
      newUser: data['newUser'],
      expense: data['expense'],
      contributorName: data['contributorName'],
      createdBy: data['createdBy'] ?? '',
      createdAt: DateTime.tryParse(data['createdAt']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'type': type.toString().split('.').last,
      'amount': amount,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      "newUser": newUser,
      "groupName": groupName,
      "contributorName": contributorName,
      "expense": expense
    };
  }

  String get createdDate {
    return _format.format(createdAt);
  }

  static List<String> getMessageList(ActivityType type) {
    return messages[type] ?? [];
  }
}
