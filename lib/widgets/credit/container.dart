import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/providers/transaction_provider.dart';
import 'package:unity_funds/widgets/credit/contribution_form.dart';
import 'package:unity_funds/widgets/credit/credit_list.dart';

class ContributionContainer extends ConsumerWidget {
  const ContributionContainer({super.key, required this.group});

  final Group group;

  void _showContributionModal(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        showDragHandle: true,
        useSafeArea: true,
        context: context,
        builder: (ctx) => SizedBox(
            height: MediaQuery.of(context).size.height - 300,
            child: AddContributionForm()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Transaction> expenses = ref
        .watch(transactionPrvoider.notifier)
        .getTransByCatNameAndType(group.name, transactionType.credit);

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(120))),
          label: const Row(children: [Icon(Icons.add), Text("Add Credit")]),
          onPressed: () => _showContributionModal(context),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: CreditList(onAddExpense: null, expenses: expenses))
          ],
        ));
  }
}
