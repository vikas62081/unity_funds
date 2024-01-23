import 'package:flutter/material.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/screens/group/group_details.dart';
import 'package:unity_funds/utils/colors.dart';
import 'package:unity_funds/widgets/group/details_card.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({Key? key, required this.group}) : super(key: key);

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
    final balance = group.totalCollected! - group.totalExpenses!;
    return ListTile(
      onTap: () => _showGroupDetails(context),
      leading: _buildCircleAvatar(),
      title: Text(
        group.name,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(group.description),
      trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              group.formattedEventDate,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 4),
            Text(
              getFormattedNumber(balance),
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: balance < 0 ? errorColor : successColor),
            )
          ]),
    );
  }

  Widget _buildCircleAvatar() {
    return CircleAvatar(
      backgroundImage: FileImage(group.image),
    );
  }
}
