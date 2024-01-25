import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/providers/transaction_provider.dart';

class DebitNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier transactionNotifier = TransactionNotifier();
  DebitNotifier() : super([]);

  Future<void> getDebitTransByGroupId(String groupId) async {
    state =
        await transactionNotifier.getTransByGroupIdAndType(groupId, "debit");
  }

  Future<void> addDebitTransaction(Transaction newTransaction) async {
    final id = await transactionNotifier.addTransaction(newTransaction);
    newTransaction.setId(id);
    state = [...state, newTransaction];
  }
}

final debitTransactionPrvoider =
    StateNotifierProvider<DebitNotifier, List<Transaction>>(
  (ref) => DebitNotifier(),
);
