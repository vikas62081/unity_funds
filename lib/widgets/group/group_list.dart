import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/providers/group_provider.dart';
import 'package:unity_funds/widgets/group/group_tile.dart';

class GroupList extends ConsumerWidget {
  const GroupList({super.key, required this.onAddGroup});

  final void Function() onAddGroup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Group> groups = ref.watch(groupProvider);
    if (groups.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("No group found."),
            const SizedBox(height: 8),
            TextButton(
              onPressed: onAddGroup,
              child: const Text("Add group"),
            )
          ],
        ),
      );
    }
    return ListView.builder(
        itemCount: groups.length,
        itemBuilder: (ctx, int index) {
          final group = groups[index];
          return GroupTile(group: group);
        });
  }
}
