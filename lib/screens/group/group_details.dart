import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/providers/group_provider.dart';
import 'package:unity_funds/widgets/group/details_card.dart';
import 'package:unity_funds/widgets/group/group_tab_bar.dart';

class GroupDetails extends StatelessWidget {
  const GroupDetails({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(group.name),
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) => const [PopupMenuItem(child: Text('Edit'))],
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GroupDetailsCard(groupId: group.id),
            ),
            const SizedBox(height: 8),
            GroupTabBar(group: group),
          ],
        ),
      ),
    );
  }
}
