import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/providers/transaction_provider.dart';
import 'package:unity_funds/services/storage.dart';

class DebitNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier transactionNotifier = TransactionNotifier();
  StorageService storageHelper = StorageService();
  DebitNotifier() : super([]);

  Future<void> getDebitTransByGroupId(String groupId) async {
    state =
        await transactionNotifier.getTransByGroupIdAndType(groupId, "debit");
  }

  Future<void> addDebitTransaction(
      Transaction newTransaction, File? image) async {
    final id = await transactionNotifier.addTransaction(newTransaction);

    if (image != null) {
      String imageUrl = await storageHelper.uploadImageAndGetURL(id, image);
      await transactionNotifier.updateTransactionBillUrl(id, imageUrl);
      newTransaction.setBill(imageUrl);
    }

    newTransaction.setId(id);
    state = [...state, newTransaction];
  }
}

final debitTransactionPrvoider =
    StateNotifierProvider<DebitNotifier, List<Transaction>>(
  (ref) => DebitNotifier(),
);
