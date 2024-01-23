import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/providers/group_provider.dart';

class TransactionNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier(List<Group> groups)
      : super([
          Transaction.debit(
              amount: 10000,
              group: groups[0].name,
              bill: groups[0].image,
              description: "Tent"),
          Transaction.debit(
              amount: 1200,
              group: groups[0].name,
              bill: groups[0].image,
              description: "Pandit fee"),
          Transaction.debit(
              amount: 1800,
              group: groups[0].name,
              bill: groups[0].image,
              description: "Crackers"),
          Transaction.debit(
              amount: 8000,
              group: groups[1].name,
              bill: groups[1].image,
              description: "DJ"),
        ]);

  void addNewTransaction(Transaction transaction) {
    state = [...state, transaction];
  }

  List<Transaction> getTransByCategoryName(String categoryName) {
    return state.where((element) => element.group == categoryName).toList();
  }

  List<Transaction> getTransByType(TransactionType type) {
    return state.where((element) => element.type == type).toList();
  }

  List<Transaction> getTransByCatNameAndType(
      String name, TransactionType type) {
    return getTransByCategoryName(name)
        .where((element) => element.type == type)
        .toList();
  }

  List<Transaction> getTransByUsername(String username) {
    return state.where((Transaction e) => e.userName == username).toList();
  }
}

final transactionPrvoider =
    StateNotifierProvider<TransactionNotifier, List<Transaction>>(
  (ref) => TransactionNotifier(ref.read(groupProvider)),
);
