import 'package:flutter/material.dart';
import 'package:unity_funds/modals/expense.dart';
import 'package:unity_funds/widgets/expense/expense_tile.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    Key? key,
    required this.onAddExpense,
    required this.expenses,
  }) : super(key: key);

  final void Function()? onAddExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("No expenses found."),
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
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        return ExpenseTile(expense: expense);
      },
    );
  }
}
