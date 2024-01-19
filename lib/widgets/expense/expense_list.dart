import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/expense.dart';
import 'package:unity_funds/providers/expense_provider.dart';
import 'package:unity_funds/widgets/expense/expense_tile.dart';

class ExpenseList extends ConsumerWidget {
  const ExpenseList({super.key, required this.onAddExpense});

  final void Function() onAddExpense;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Expense> expenses = ref.watch(expenseProvider);
    if (expenses.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("No expense found."),
            const SizedBox(height: 8),
            TextButton(
              onPressed: onAddExpense,
              child: const Text("Add expense"),
            )
          ],
        ),
      );
    }
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, int index) {
          final expense = expenses[index];
          return ExpenseTile(expense: expense);
        });
  }
}
