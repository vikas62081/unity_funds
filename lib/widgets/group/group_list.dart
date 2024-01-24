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
  List<Group>? groups;
  bool isLoading = false;

  void _loadAllGroups() async {
    await ref.read(groupProvider.notifier).getGroups();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _loadAllGroups();
  }

  @override
  Widget build(BuildContext context) {
    groups = ref.watch(groupProvider);

    if (isLoading || groups == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    if (groups!.isEmpty) {
      return _buildEmptyState();
    }
    return _buildGroupListView(groups!);
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
}
