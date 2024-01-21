import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unity_funds/modals/transaction.dart';

class CreditTile extends StatelessWidget {
  const CreditTile({super.key, required this.expense});

  final Transaction expense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: const CircleAvatar(
        radius: 32,
        child: Icon(
          Icons.person,
          size: 36,
        ),
      ),
      title: Text(expense.member!),
      subtitle: Text(expense.createdAt.toString()),
      trailing: Text('₹${NumberFormat().format(expense.amount)}'),
    );
  }
}
