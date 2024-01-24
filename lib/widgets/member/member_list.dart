import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/user.dart';
import 'package:unity_funds/providers/user_provider.dart';
import 'package:unity_funds/widgets/member/user_tile.dart';

class MemberList extends ConsumerStatefulWidget {
  const MemberList({Key? key, required this.onAddMember}) : super(key: key);
  final void Function() onAddMember;

  @override
  ConsumerState<MemberList> createState() => _MemberListState();
}

class _MemberListState extends ConsumerState<MemberList> {
  List<User>? users;
  bool isLoading = false;

  void _loadAllUsers() async {
    await ref.read(userProvider.notifier).getUsers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    isLoading = true;
    _loadAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    users = ref.watch(userProvider);

    if (isLoading || users == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    if (users!.isEmpty) {
      return _buildEmptyState();
    }
    return _buildUserListView(users!);
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("No user added yet."),
          const SizedBox(height: 8),
          TextButton(
            onPressed: widget.onAddMember,
            child: const Text("Add a user"),
          )
        ],
      ),
    );
  }

  Widget _buildUserListView(List<User> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return UserTile(user: user);
      },
    );
  }
}
