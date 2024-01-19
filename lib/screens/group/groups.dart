import 'package:flutter/material.dart';
import 'package:unity_funds/screens/group/new_group.dart';
import 'package:unity_funds/widgets/group/group_list.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  void _onFloatingButtonPress(
    BuildContext context,
  ) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewGroup()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GroupList(
        onAddGroup: () => _onFloatingButtonPress(context),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => _onFloatingButtonPress(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
