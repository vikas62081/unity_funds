import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:unity_funds/modals/activity.dart';
import 'package:unity_funds/utils/colors.dart';

class ActivityTile extends StatelessWidget {
  const ActivityTile({super.key, required this.activity});

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    if (ActivityType.newGroup == activity.type) {
      return groupActivityTile(context);
    }
    if (ActivityType.creditTransaction == activity.type) {
      return creditActivityTile(context);
    }
    if (ActivityType.debitTransaction == activity.type) {
      return debitActivityTile(context);
    }

    return ListTile(
      onTap: () {},
      leading: const Icon(
        Icons.info_outline,
        size: 24,
      ),
      // title: Text(
      //   activity.message,
      //   // style: Theme.of(context).textTheme.bodyMedium,
      // ),
      title: RichText(
        text: const TextSpan(
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: 'Vikas',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            TextSpan(
              text: ' created a new group ',
            ),
            TextSpan(
              text: 'Holi',
              style: TextStyle(
                // fontStyle: FontStyle.italic,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
      subtitle: Text(activity.createdDate),
    );
  }

  Widget debitActivityTile(context) {
    return ListTile(
      onTap: () {},
      leading: Icon(
        Icons.receipt_outlined,
        color: errorColor.withOpacity(0.7),
        size: 24,
      ),
      title: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: activity.createdBy,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            TextSpan(
              text: activity.message![0],
            ),
            TextSpan(
              text: activity.expense,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey,
              ),
            ),
            TextSpan(
              text: activity.message![1],
            ),
            TextSpan(
              text: activity.groupName,
              style: const TextStyle(
                  // fontStyle: FontStyle.italic,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      subtitle: Text(activity.createdDate),
      trailing: Text(
        '₹${NumberFormat().format(activity.amount)}',
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }

  Widget creditActivityTile(context) {
    return ListTile(
      onTap: () {},
      leading: Icon(
        Icons.attach_money_outlined,
        color: successColor.withOpacity(.7),
        size: 24,
      ),
      title: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: activity.contributorName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            TextSpan(
              text: activity.message![0],
            ),
            TextSpan(
              text: activity.groupName,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
      subtitle: Text(activity.createdDate),
      trailing: Text(
        '₹${NumberFormat().format(activity.amount)}',
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }

  Widget groupActivityTile(context) {
    return ListTile(
      onTap: () {},
      leading: const Icon(
        Icons.group_add_outlined,
        size: 24,
      ),
      title: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: activity.createdBy,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            TextSpan(
              text: activity.message![0],
            ),
            TextSpan(
              text: activity.groupName,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
      subtitle: Text(activity.createdDate),
    );
  }
}
