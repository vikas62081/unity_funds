import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/expense.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/providers/expense_provider.dart';
import 'package:unity_funds/widgets/contribution/container.dart';
import 'package:unity_funds/widgets/expense/expense_list.dart';
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
  List<Expense> expenses = [];

  @override
  void initState() {
    super.initState();
    _tabBarController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabBarController.dispose();
    super.dispose();
  }

  void _onTabChange(int activeTabIndex) {
    if (activeTabIndex == 1) {
      setState(() {
        expenses = ref
            .read(expenseProvider.notifier)
            .getExpenseByCategoryName(widget.group.name);
      });
    }
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
      onTap: _onTabChange,
      tabs: const [
        GroupTab(icon: Icons.group_add, label: "Contributors"),
        GroupTab(icon: Icons.group_add, label: "Expenditures"),
      ],
    );
  }

  Widget _buildTabBarView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.50,
      child: TabBarView(controller: _tabBarController, children: [
        ContributionContainer(),
        _buildExpendituresTab(),
      ]),
    );
  }

  Widget _buildExpendituresTab() {
    return ExpenseList(
      onAddExpense: null,
      expenses: expenses,
    );
  }
}
