import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/providers/group_provider.dart';
import 'package:unity_funds/widgets/group/group_tile.dart';

class GroupSearchResult extends ConsumerWidget {
  const GroupSearchResult({super.key, this.query});

  final String? query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Group> groups =
        ref.watch(groupProvider.notifier).filterListByName(query!);

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
          Text("No result found for $query"),
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
