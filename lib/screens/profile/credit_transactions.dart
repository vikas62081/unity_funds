import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/modals/user.dart';
import 'package:unity_funds/providers/transaction_provider.dart';
import 'package:unity_funds/widgets/credit/credit_list.dart';

class CreditTransactionScreen extends ConsumerWidget {
  const CreditTransactionScreen({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Transaction> expenses =
        ref.watch(transactionPrvoider.notifier).getTransByUsername(user.name);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Transactions"),
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded(child: CreditList(onAddExpense: null, expenses: expenses))
          ],
        ));
  }
}
