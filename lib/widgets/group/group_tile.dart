import 'package:flutter/material.dart';
import 'package:unity_funds/modals/group.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // onTap: () => _showBillingInformation(context),
      // leading: CircleAvatar(backgroundImage: FileImage(group)),
      title: Text(group.name),
      subtitle: Text(group.description),
      // trailing: Text('₹${NumberFormat().format(expense.amount)}'),
    );
  }
}
