import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/providers/group_provider.dart';
import 'package:unity_funds/widgets/group/group_tile.dart';

class GroupList extends ConsumerWidget {
  const GroupList({Key? key, required this.onAddGroup}) : super(key: key);

  final void Function() onAddGroup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Group> groups = ref.watch(groupProvider);

    if (groups.isEmpty) {
      return _buildEmptyState();
    }

    return _buildGroupListView(groups);
  }

  Widget _buildEmptyState() {
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

  Widget _buildGroupListView(List<Group> groups) {
    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return GroupTile(group: group);
      },
    );
  }
}
