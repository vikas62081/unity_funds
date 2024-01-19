import 'package:flutter/material.dart';
import 'package:unity_funds/widgets/expense/expense_list.dart';
import 'package:unity_funds/screens/expense/new_expense.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  void _onFloatingButtonPress(
    BuildContext context,
  ) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewExpense()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpenseList(onAddExpense: () => _onFloatingButtonPress(context)),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => _onFloatingButtonPress(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
