import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/providers/group_provider.dart';
import 'package:unity_funds/widgets/group/group_tile.dart';

class GroupList extends ConsumerStatefulWidget {
  const GroupList({Key? key, required this.onAddGroup}) : super(key: key);

  final void Function() onAddGroup;

  @override
  ConsumerState<GroupList> createState() => _GroupListState();
}

class _GroupListState extends ConsumerState<GroupList> {
  late Future<List<Group>> groups;

  @override
  void initState() {
    super.initState();
    groups = ref.read(groupProvider.notifier).getGroups();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: groups,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (snapshot.hasError) {
          return _buildErrorState(snapshot.error as Object);
        }

        if ((snapshot.data as List).isEmpty) {
          return _buildEmptyState();
        }

        return _buildGroupListView(snapshot.data as List<Group>);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("No group found."),
          const SizedBox(height: 8),
          TextButton(
            onPressed: widget.onAddGroup,
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
        return GroupTile(group: groups[index]);
      },
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Error loading groups: $error"),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                // Retry or handle error as needed
              },
              child: const Text("Retry"),
            )
          ],
        ),
      ),
    );
  }
}
