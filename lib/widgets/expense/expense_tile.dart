import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unity_funds/modals/expense.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense});

  final Expense expense;

  void _showBillingInformation(BuildContext context) {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (ctx) {
          return SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    "Billing receipt",
                    style: Theme.of(context).textTheme.labelLarge!,
                  ),
                  const SizedBox(height: 8),
                  if (expense.bill != null)
                    Image.file(
                      expense.bill!,
                      fit: BoxFit.scaleDown,
                    )
                  else
                    const Center(
                      child: Text("Not billing information uploaded."),
                    )
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _showBillingInformation(context),
      leading: Container(
        color: expense.color,
        alignment: Alignment.center,
        width: 50,
        height: 50,
        child: Text(expense.formattedDate),
      ),
      title: Text(expense.description),
      subtitle: Text(expense.group),
      trailing: Text('₹${NumberFormat().format(expense.amount)}'),
    );
  }
}
