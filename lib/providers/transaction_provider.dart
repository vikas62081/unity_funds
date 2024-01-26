import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/providers/credit_notifier.dart';
import 'package:unity_funds/providers/debit_notifier.dart';

class TransactionNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier()
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

  Future<String> addTransaction(Transaction newTransaction) async {
    cloud_firestore.DocumentReference<Map<String, dynamic>> documentReference =
        await cloud_firestore.FirebaseFirestore.instance
            .collection('transactions')
            .add(newTransaction.toFirestore());
    return documentReference.id;
  }

  Future<List<Transaction>> getTransByGroupIdAndType(
      String groupId, String type) async {
    try {
      cloud_firestore.QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await cloud_firestore.FirebaseFirestore.instance
              .collection('transactions')
              .where('groupId', isEqualTo: groupId)
              .where('type', isEqualTo: type)
              .get();

      List<Transaction> transactions = querySnapshot.docs
          .map((doc) => Transaction.fromFirestore(doc))
          .toList();
      state = transactions;

      return transactions;
    } catch (error) {
      print('Error getting transactions: $error');
      return [];
    }
  }

  Future<List<Transaction>> getTransByUserId(String userId) async {
    try {
      cloud_firestore.QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await cloud_firestore.FirebaseFirestore.instance
              .collection('transactions')
              .where('contributorUserId', isEqualTo: userId)
              .where('type', isEqualTo: 'credit')
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

  Future<void> updateTransactionBillUrl(String transId, String url) async {
    await cloud_firestore.FirebaseFirestore.instance
        .collection('transactions')
        .doc(transId)
        .update({'bill': url});
  }

  List<Transaction> getTransByUsername(String username) {
    return state
        .where((Transaction e) => e.contributorName == username)
        .toList();
  }

  Future<void> updateTransContributorNameByContId(
      String userId, String updatedName) async {
    try {
      cloud_firestore.WriteBatch batch =
          cloud_firestore.FirebaseFirestore.instance.batch();

      // Assuming 'transactions' is the Firestore collection
      cloud_firestore.QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await cloud_firestore.FirebaseFirestore.instance
              .collection('transactions')
              .where('contributorUserId', isEqualTo: userId)
              .get();

      querySnapshot.docs.forEach((doc) {
        batch.update(doc.reference, {'contributorName': updatedName});
      });

      await batch.commit();
    } catch (error) {
      print('Error updating transactions: $error');
      // Handle error as needed
    }
  }

// Usage
}

final transactionPrvoider =
    StateNotifierProvider<TransactionNotifier, List<Transaction>>(
  (ref) => TransactionNotifier(),
);
