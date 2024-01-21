import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/providers/transaction_provider.dart';
import 'package:unity_funds/screens/expense/new_expense.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  void _onFloatingButtonPress(
    BuildContext context,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          appBar: AppBar(),
          body: const NewExpense(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Transaction> expenses = ref.watch(transactionPrvoider);
    return Scaffold(
      body: const Center(
        child: Text("Work in progress"),
      ),
      //  ExpenseList(
      //     onAddExpense: () => _onFloatingButtonPress(context),
      //     expenses: expenses),

      floatingActionButton: buildFloatingActionButton(
          onPressed: () => _onFloatingButtonPress(context),
          label: "Add expense"),
    );
  }
}
