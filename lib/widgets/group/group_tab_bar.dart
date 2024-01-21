import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/providers/group_provider.dart';
import 'package:unity_funds/providers/transaction_provider.dart';
import 'package:unity_funds/screens/expense/new_expense.dart';
import 'package:unity_funds/widgets/credit/container.dart';
import 'package:unity_funds/widgets/credit/contribution_form.dart';
import 'package:unity_funds/widgets/debit/container.dart';
import 'package:unity_funds/widgets/group/tab.dart';

class GroupTabBar extends ConsumerStatefulWidget {
  const GroupTabBar({super.key, required this.group});

  final Group group;

  @override
  ConsumerState<GroupTabBar> createState() => _GroupTabBarState();
}

class _GroupTabBarState extends ConsumerState<GroupTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabBarController;
  List<Transaction> expenses = [];

  @override
  void initState() {
    super.initState();
    _tabBarController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabBarController.dispose();
    super.dispose();
  }

  void _assignExpenseState(int value) {
    setState(() {
      expenses = ref
          .watch(transactionPrvoider.notifier)
          .getTransByCatNameAndType(widget.group.name,
              value == 0 ? TransactionType.credit : TransactionType.debit);
    });
  }

  void _showAddModal(BuildContext context) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        showDragHandle: true,
        useSafeArea: true,
        context: context,
        builder: (ctx) => SingleChildScrollView(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height - 300,
                  child: _tabBarController.index == 0
                      ? AddContributionForm(
                          group: widget.group,
                        )
                      : NewExpense(
                          group: ref
                              .read(groupProvider.notifier)
                              .getGroupById(widget.group.id),
                          key: UniqueKey(),
                        )),
            ));

    _assignExpenseState(_tabBarController.index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTabBar(),
        _buildTabBarView(),
      ],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      tabAlignment: TabAlignment.fill,
      controller: _tabBarController,
      onTap: _assignExpenseState,
      tabs: const [
        GroupTab(icon: Icons.group_add, label: "Contributors"),
        GroupTab(icon: Icons.group_add, label: "Expenditures"),
      ],
    );
  }

  Widget _buildTabBarView() {
    return SizedBox(
        height: MediaQuery.of(context).size.height - 360,
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton.extended(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(120))),
              label: Row(children: [
                const Icon(Icons.add_circle_outline),
                const SizedBox(width: 8),
                Text(_tabBarController.index == 0 ? "INCOME" : "EXPENSE")
              ]),
              onPressed: () => _showAddModal(context)),
          body: TabBarView(controller: _tabBarController, children: [
            ContributionContainer(group: widget.group),
            ExpenseContainer(expenses: expenses),
          ]),
        ));
  }
}
