import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/providers/transaction_provider.dart';
import 'package:unity_funds/widgets/debit/expense_tile.dart';

class ExpenseList extends ConsumerWidget {
  const ExpenseList(
      {Key? key, required this.onAddExpense, required this.groupId})
      : super(key: key);

  final void Function()? onAddExpense;
  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref
          .read(transactionPrvoider.notifier)
          .getTransByGroupIdAndType(groupId, TransactionType.debit),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("No expense found."),
                const SizedBox(height: 8),
                if (onAddExpense != null)
                  TextButton(
                    onPressed: onAddExpense,
                    child: const Text("Add expense"),
                  ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final expense = snapshot.data![index];
            return ExpenseTile(expense: expense);
          },
        );
      },
    );
  }
}
