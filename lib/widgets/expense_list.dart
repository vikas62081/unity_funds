import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/expense.dart';
import 'package:unity_funds/providers/expense_provider.dart';
import 'package:unity_funds/widgets/expense_tile.dart';

class ExpenseList extends ConsumerWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Expense> expenses = ref.watch(expenseProvider);
    if (expenses.isEmpty) {
      return const Center(
        child: Text("No expense found."),
      );
    }
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, int index) {
          final currentExpense = expenses[index];
          return ExpenseTile(expense: currentExpense);
        });
  }
}
