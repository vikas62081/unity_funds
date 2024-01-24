import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/widgets/debit/expense_list.dart';

class ExpenseContainer extends ConsumerWidget {
  const ExpenseContainer({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: ExpenseList(onAddExpense: null, groupId: group.id)),
      ],
    );
  }
}
