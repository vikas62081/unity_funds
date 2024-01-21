import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/widgets/credit/container.dart';
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
    _tabBarController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabBarController.dispose();
    super.dispose();
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
      tabs: const [
        GroupTab(icon: Icons.group_add, label: "Contributors"),
        GroupTab(icon: Icons.group_add, label: "Expenditures"),
      ],
    );
  }

  Widget _buildTabBarView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 360,
      child: TabBarView(controller: _tabBarController, children: [
        ContributionContainer(group: widget.group),
        ExpenseContainer(group: widget.group),
      ]),
    );
  }
}
