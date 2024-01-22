import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/user.dart';
import 'package:unity_funds/providers/user_provider.dart';
import 'package:unity_funds/widgets/member/user_tile.dart';

class UserSearchResult extends ConsumerWidget {
  const UserSearchResult({super.key, this.query});

  final String? query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<User> users =
        ref.watch(userProvider.notifier).filterUserByNameOrPhone(query!);

    if (users.isEmpty) {
      return _buildEmptyState();
    }
    return _buildGroupListView(users);
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

  Widget _buildGroupListView(List<User> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return UserTile(user: user);
      },
    );
  }
}
