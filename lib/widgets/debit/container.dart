import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/providers/transaction_provider.dart';
import 'package:unity_funds/screens/expense/new_expense.dart';
import 'package:unity_funds/widgets/debit/expense_list.dart';

class ExpenseContainer extends ConsumerWidget {
  const ExpenseContainer({super.key, required this.group});

  final Group group;

  void _showContributionModal(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        showDragHandle: true,
        useSafeArea: true,
        context: context,
        builder: (ctx) => SingleChildScrollView(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height - 300,
                  child: const NewExpense()),
            ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Transaction> expenses = ref
        .watch(transactionPrvoider.notifier)
        .getTransByCatNameAndType(group.name, transactionType.debit);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(120))),
        label: const Row(children: [Icon(Icons.add), Text("Add Expense")]),
        onPressed: () => _showContributionModal(context),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const SizedBox(height: 8),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     FilledButton.tonalIcon(
          //         onPressed: () => _showContributionModal(context),
          //         icon: const Icon(Icons.add),
          //         label: const Text("Add")),
          //   ],
          // ),
          Expanded(child: ExpenseList(onAddExpense: null, expenses: expenses)),
        ],
      ),
    );
  }
}
