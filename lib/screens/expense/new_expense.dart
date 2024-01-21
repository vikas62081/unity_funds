import 'package:flutter/material.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/widgets/debit/new_expense_form.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class NewExpense extends StatelessWidget {
  const NewExpense({super.key, this.group});

  final Group? group;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle("Add Expense"),
            const SizedBox(height: 16),
            AddExpenseForm(group: group)
          ],
        ));
  }
}
