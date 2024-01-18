import 'package:flutter/material.dart';
import 'package:unity_funds/widgets/new_expense/new_expense_form.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add expense"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const SingleChildScrollView(child: NewExpenseForm()),
    );
  }
}
