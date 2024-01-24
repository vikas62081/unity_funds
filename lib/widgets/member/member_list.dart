import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/user.dart';
import 'package:unity_funds/providers/user_provider.dart';
import 'package:unity_funds/widgets/member/user_tile.dart';

class MemberList extends ConsumerWidget {
  const MemberList({Key? key, required this.onAddMember}) : super(key: key);
  final void Function() onAddMember;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: ref.read(userProvider.notifier).getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return _buildEmptyState();
          }

          return _buildUserListView(snapshot.data as List<User>);
        });
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("No user added yet."),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onAddMember,
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
