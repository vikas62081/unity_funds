import 'package:flutter/material.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/widgets/group/details_card.dart';
import 'package:unity_funds/widgets/group/group_tab_bar.dart';

class GroupDetails extends StatelessWidget {
  const GroupDetails({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: GroupDetailsCard(),
            ),
            const SizedBox(height: 8),
            GroupTabBar(group: group),
          ],
        ),
      ),
    );
  }
}
