import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/providers/transaction_provider.dart';
import 'package:unity_funds/services/activity.dart';

class CreditNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier transactionNotifier = TransactionNotifier();
  ActivityService activityService = ActivityService();
  CreditNotifier() : super([]);

  Future<void> getCreditTransByGroupId(String groupId) async {
    state =
        await transactionNotifier.getTransByGroupIdAndType(groupId, "credit");
  }

  Future<void> addCreditTransaction(Transaction newTransaction) async {
    String id = await transactionNotifier.addTransaction(newTransaction);
    newTransaction.setId(id);
    state = [...state, newTransaction];
    activityService.addCreditActivity(
        username: newTransaction.contributorName!,
        amount: newTransaction.amount,
        groupName: newTransaction.groupName);
  }
}

final creditTransactionPrvoider =
    StateNotifierProvider<CreditNotifier, List<Transaction>>(
  (ref) => CreditNotifier(),
);
