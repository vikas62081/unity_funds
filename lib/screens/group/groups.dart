import 'package:flutter/material.dart';
import 'package:unity_funds/screens/expense/new_expense.dart';
import 'package:unity_funds/screens/group/new_group.dart';
import 'package:unity_funds/screens/group/search.dart';
import 'package:unity_funds/widgets/group/group_list.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

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

  void _showAddGroupModal(
    BuildContext context,
  ) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewGroup()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Groups"), actions: [
          IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: GroupSearchDelegate()),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => _showAddGroupModal(context),
            icon: const Icon(Icons.group_add_outlined),
          )
        ]),
        body: GroupList(
          onAddGroup: () => _showAddGroupModal(context),
        ),
        floatingActionButton: buildFloatingActionButton(
            onPressed: () => _onFloatingButtonPress(context),
            label: "Add expense"));
  }
}
