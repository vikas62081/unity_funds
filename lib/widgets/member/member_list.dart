import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/member.dart';
import 'package:unity_funds/providers/member_provider.dart';

class MemberList extends ConsumerWidget {
  const MemberList({Key? key, required this.onAddMember}) : super(key: key);
  final void Function() onAddMember;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Member> members = ref.watch(memberProvider);

    if (members.isEmpty) {
      return _buildEmptyState();
    }

    return _buildGroupListView(members);
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("No member added yet."),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onAddMember,
            child: const Text("Add member"),
          )
        ],
      ),
    );
  }

  Widget _buildGroupListView(List<Member> members) {
    return ListView.builder(
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
        return ListTile(
          leading: CircleAvatar(child: Icon(Icons.person)),
          title: Text(member.name),
          subtitle: Text("Phone : ${member.phoneNumber}"),
        );
      },
    );
  }
}
