import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const CircleAvatar(
                    radius: 52,
                    child: Icon(Icons.person, size: 64),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Tooltip(
                    message: 'Change Photo',
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.photo_camera),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Vikas Kumar Vishwakarma",
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              "vikas62081@gmail.com",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Handle editing profile
              },
              child: const Text("Edit Profile"),
            ),
            const SizedBox(height: 24),
            buildListTile(
              context: context,
              leadingIcon: Icons.favorite,
              trailingIcon: Icons.edit,
              title: 'Default Group',
              subtitle: 'Group Name',
              onTap: () => null,
            ),
            buildListTile(
              context: context,
              leadingIcon: Icons.monetization_on,
              trailingIcon: Icons.arrow_forward,
              title: 'Loans',
              subtitle: 'View and Manage Your Loans',
              onTap: () => null,
            ),
            buildListTile(
              context: context,
              leadingIcon: Icons.group_add,
              trailingIcon: Icons.arrow_forward,
              title: 'Contributions',
              subtitle: 'View Your Contributions',
              onTap: () => null,
            ),
            buildListTile(
              context: context,
              leadingIcon: Icons.exit_to_app_sharp,
              trailingIcon: Icons.logout,
              title: 'Log Out',
              subtitle: 'Logout',
              onTap: () => null,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListTile({
    required BuildContext context,
    required IconData leadingIcon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required IconData trailingIcon,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        padding: const EdgeInsets.all(12),
        child: Icon(leadingIcon),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(trailingIcon),
    );
  }
}
