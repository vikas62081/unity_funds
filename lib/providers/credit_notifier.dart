import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/providers/transaction_provider.dart';

class CreditNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier transactionNotifier = TransactionNotifier();
  CreditNotifier() : super([]);

  Future<void> getCreditTransByGroupId(String groupId) async {
    state =
        await transactionNotifier.getTransByGroupIdAndType(groupId, "credit");
  }

  Future<void> addCreditTransaction(Transaction newTransaction) async {
    String id = await transactionNotifier.addTransaction(newTransaction);
    newTransaction.setId(id);
    state = [...state, newTransaction];
  }
}

final creditTransactionPrvoider =
    StateNotifierProvider<CreditNotifier, List<Transaction>>(
  (ref) => CreditNotifier(),
);
