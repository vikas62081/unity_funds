import 'package:flutter/material.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/screens/group/group_details.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({super.key, required this.group});

  final Group group;

  void _showGroupDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GroupDetails(group: group),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _showGroupDetails(context),
      leading: CircleAvatar(backgroundImage: FileImage(group.image)),
      title: Text(group.name),
      subtitle: Text(group.description),
      isThreeLine: true,
      trailing: Text(group.formattedEventDate),
    );
  }
}
