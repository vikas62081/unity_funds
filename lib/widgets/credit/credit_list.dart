import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/providers/credit_notifier.dart';
import 'package:unity_funds/providers/transaction_provider.dart';
import 'package:unity_funds/widgets/credit/credit_tile.dart';

class CreditList extends ConsumerStatefulWidget {
  const CreditList(
      {Key? key, required this.onAddExpense, required this.groupId})
      : super(key: key);

  final void Function()? onAddExpense;
  final String groupId;

  @override
  ConsumerState<CreditList> createState() => _CreditListState();
}

class _CreditListState extends ConsumerState<CreditList> {
  List<Transaction>? transactions;
  bool isLoading = true;

  void _loadTransactions() async {
    await ref
        .read(creditTransactionPrvoider.notifier)
        .getCreditTransByGroupId(widget.groupId);

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
    transactions = ref.watch(creditTransactionPrvoider);

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
            const Text("No credit found."),
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
        return CreditTile(
          expense: expense,
          isGroupAsTitle: false,
        );
      },
    );
  }
}
