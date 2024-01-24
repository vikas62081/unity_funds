import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unity_funds/modals/transaction.dart';

class CreditTile extends StatelessWidget {
  const CreditTile(
      {super.key, required this.expense, required this.isGroupAsTitle});

  final Transaction expense;
  final bool isGroupAsTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: const CircleAvatar(
        radius: 24,
        child: Icon(
          Icons.person,
          size: 36,
        ),
      ),
      title: Text(
        isGroupAsTitle ? expense.groupName : expense.contributorName!,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      subtitle: Text(expense.formattedCreatedDate),
      trailing: Text(
        '₹${NumberFormat().format(expense.amount)}',
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
