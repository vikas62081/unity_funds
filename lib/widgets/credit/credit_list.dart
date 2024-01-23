import 'package:flutter/material.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/widgets/credit/credit_tile.dart';

class CreditList extends StatelessWidget {
  const CreditList({
    Key? key,
    required this.onAddExpense,
    required this.expenses,
  }) : super(key: key);

  final void Function()? onAddExpense;
  final List<Transaction> expenses;

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("No credit found."),
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
        return CreditTile(expense: expense);
      },
    );
  }
}
