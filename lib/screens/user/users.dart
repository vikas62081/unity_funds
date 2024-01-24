import 'package:flutter/material.dart';
import 'package:unity_funds/screens/expense/new_expense.dart';
import 'package:unity_funds/screens/user/search.dart';
import 'package:unity_funds/widgets/member/container.dart';
import 'package:unity_funds/widgets/member/member_list.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class MemberScreen extends StatelessWidget {
  const MemberScreen({super.key});
  void _onFloatingButtonPress(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          appBar: AppBar(),
          body: const NewExpense(),
        ),
      ),
    );
  }

  void _showAddUserScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const MemberContainer(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("People"), actions: [
        IconButton(
          onPressed: () =>
              showSearch(context: context, delegate: UserSearchDelegate()),
          icon: const Icon(Icons.search),
        ),
        IconButton(
            onPressed: () => _showAddUserScreen(context),
            icon: const Icon(Icons.person_add_alt_1_outlined))
      ]),
      body: MemberList(onAddMember: () => _showAddUserScreen(context)),
      floatingActionButton: buildFloatingActionButton(
          onPressed: () => _onFloatingButtonPress(context),
          label: "Add expense"),
    );
  }
}
