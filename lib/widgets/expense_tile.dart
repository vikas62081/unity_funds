import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unity_funds/modals/expense.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        color: expense.color,
        alignment: Alignment.center,
        width: 50,
        height: 50,
        child: Text(expense.formattedDate),
      ),
      title: Text(expense.description),
      subtitle: Text(expense.formattedCategory),
      trailing: Text('₹${NumberFormat().format(expense.amount)}'),
    );
  }
}
