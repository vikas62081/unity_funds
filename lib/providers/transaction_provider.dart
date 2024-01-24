import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';

import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/providers/group_provider.dart';

class TransactionNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier(List<Group> groups)
      : super([
          // Transaction.debit(
          //     amount: 10000,
          //     group: groups[0].name,
          //     bill: groups[0].image,
          //     description: "Tent"),
          // Transaction.debit(
          //     amount: 1200,
          //     group: groups[0].name,
          //     bill: groups[0].image,
          //     description: "Pandit fee"),
          // Transaction.debit(
          //     amount: 1800,
          //     group: groups[0].name,
          //     bill: groups[0].image,
          //     description: "Crackers"),
          // Transaction.debit(
          //     amount: 8000,
          //     group: groups[1].name,
          //     bill: groups[1].image,
          //     description: "DJ"),
        ]);

  Future<void> addTransaction(Transaction newTransaction) async {
    await cloud_firestore.FirebaseFirestore.instance
        .collection('transactions')
        .add(newTransaction.toFirestore());

    state = [...state, newTransaction];
  }

  Future<List<Transaction>> getTransByGroupIdAndType(
      String groupId, TransactionType type) async {
    try {
      // Assuming your Firestore collection is named 'transactions'
      cloud_firestore.QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await cloud_firestore.FirebaseFirestore.instance
              .collection('transactions')
              .where('groupId', isEqualTo: groupId)
              .where('type',
                  isEqualTo: type == TransactionType.debit ? 'debit' : 'credit')
              .get();

      List<Transaction> transactions = querySnapshot.docs
          .map((doc) => Transaction.fromFirestore(doc))
          .toList();

      return transactions;
    } catch (error) {
      // Handle error as needed
      print('Error getting transactions: $error');
      return [];
    }
  }

  List<Transaction> getTransByGroupId(String categoryId) {
    return state.where((element) => element.groupId == categoryId).toList();
  }

  List<Transaction> getTransByType(TransactionType type) {
    return state.where((element) => element.type == type).toList();
  }

  // List<Transaction> getTransByCatIdAndType(String catId, TransactionType type) {
  //   return getTransByGroupId(catId)
  //       .where((element) => element.type == type)
  //       .toList();
  // }

  List<Transaction> getTransByUsername(String username) {
    return state
        .where((Transaction e) => e.contributorName == username)
        .toList();
  }
}

final transactionPrvoider =
    StateNotifierProvider<TransactionNotifier, List<Transaction>>(
  (ref) => TransactionNotifier(ref.read(groupProvider)),
);
