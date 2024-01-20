import 'package:flutter/material.dart';
import 'package:unity_funds/widgets/expense/new_expense_form.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

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
      appBar: AppBar(),
      body: const SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle("Add Expense"),
              SizedBox(height: 16),
              NewExpenseForm()
            ],
          )),
    );
  }
}
