import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/expense.dart';
import 'package:unity_funds/providers/expense_provider.dart';
import 'package:unity_funds/widgets/expense/expense_list.dart';
import 'package:unity_funds/screens/expense/new_expense.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  void _onFloatingButtonPress(
    BuildContext context,
  ) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewExpense()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Expense> expenses = ref.watch(expenseProvider);
    return Scaffold(
      body: ExpenseList(
          onAddExpense: () => _onFloatingButtonPress(context),
          expenses: expenses),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => _onFloatingButtonPress(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
