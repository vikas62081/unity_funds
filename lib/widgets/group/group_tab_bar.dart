import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/providers/group_provider.dart';
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
  Group? group;
  bool isLoading = true;
  DateTime date = DateTime.now();

  void _loadCurrentGroup() async {
    group = ref
        .read(groupProvider.notifier)
        .getGroupByIdFromProvider(widget.group.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCurrentGroup();
    _tabBarController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabBarController.dispose();
    super.dispose();
  }

  void _assignExpenseState(int value) {
    setState(() {
      date = DateTime.now();
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
                          group: group,
                        )
                      : NewExpense(
                          group: group,
                          key: UniqueKey(),
                        )),
            ));

    _assignExpenseState(_tabBarController.index);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    return Column(
      children: [
        _buildTabBar(),
        Expanded(child: _buildTabBarView()),
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
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(120),
          ),
        ),
        label: Row(
          children: [
            const Icon(Icons.add_circle_outline),
            const SizedBox(width: 8),
            Text(_tabBarController.index == 0 ? "INCOME" : "EXPENSE")
          ],
        ),
        onPressed: () => _showAddModal(context),
      ),
      body: TabBarView(controller: _tabBarController, children: [
        ContributionContainer(group: group!),
        ExpenseContainer(group: group!),
      ]),
    );
  }
}
