import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/providers/transaction_provider.dart';
import 'package:unity_funds/widgets/debit/expense_tile.dart';

class ExpenseList extends ConsumerStatefulWidget {
  const ExpenseList(
      {Key? key, required this.onAddExpense, required this.groupId})
      : super(key: key);

  final void Function()? onAddExpense;
  final String groupId;

  @override
  ConsumerState<ExpenseList> createState() {
    return _ExpenseListState();
  }
}

class _ExpenseListState extends ConsumerState<ExpenseList> {
  bool isLoading = true;
  List<Transaction>? transactions;

  void _loadTransactions() {
    ref
        .read(debitTransactionPrvoider.notifier)
        .getDebitTransByGroupId(widget.groupId);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _loadTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    transactions = ref.watch(debitTransactionPrvoider); //

    if (isLoading || transactions == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    if (transactions!.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("No expense found."),
            const SizedBox(height: 8),
            if (widget.onAddExpense != null)
              TextButton(
                onPressed: widget.onAddExpense,
                child: const Text("Add expense"),
              ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: transactions!.length,
      itemBuilder: (context, index) {
        final expense = transactions![index];
        return ExpenseTile(expense: expense);
      },
    );
  }
}
