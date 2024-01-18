import 'package:flutter/material.dart';
import 'package:unity_funds/widgets/expense_list.dart';
import 'package:unity_funds/widgets/new_expense/new_expense.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  void _onFloatingButtonPress(
    BuildContext context,
  ) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewExpense()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ExpenseList(),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => _onFloatingButtonPress(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
