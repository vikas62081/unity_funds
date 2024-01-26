import 'package:flutter/material.dart';
import 'package:unity_funds/modals/user.dart';
import 'package:unity_funds/screens/profile/personal_transactions.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});

  final User user;

  void _showAllTransactionsByUser(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PersonalTransactionScreen(
          label: user.name,
          userId: user.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _showAllTransactionsByUser(context),
      leading: CircleAvatar(
        backgroundImage:
            user.profilePic != null ? NetworkImage(user.profilePic!) : null,
        radius: 24,
        child: user.profilePic == null
            ? const Icon(
                Icons.person,
                size: 36,
              )
            : null,
      ),
      title: Text(
        user.name,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      subtitle: Text("Phone : ${user.phoneNumber}"),
      trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.black54,
            ),
            Text(
              user.address,
              style: Theme.of(context).textTheme.bodySmall,
            )
          ]),
    );
  }
}
