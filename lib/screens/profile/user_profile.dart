import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/user.dart';
import 'package:unity_funds/providers/user_provider.dart';
import 'package:unity_funds/screens/profile/personal_transactions.dart';
import 'package:unity_funds/screens/profile/edit_profile.dart';
import 'package:unity_funds/services/auth.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  User? user;

  void _getActiveUserData() async {
    final activeUser = await ref.read(userProvider.notifier).getActiveUser();
    setState(() {
      user = activeUser;
    });
  }

  @override
  void initState() {
    _getActiveUserData();
    super.initState();
  }

  Future<void> _updateUser(User newUser) async {
    await ref.read(userProvider.notifier).updateUserById(user!.id, newUser,
        hasUserNameChanged: user!.name != newUser.name);
    _getActiveUserData();
    if (context.mounted) {
      showSnackbar(context, "Profile updated successfully");
    }
  }

  void _showEditProfileScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => EditProfileScreen(
          user: user!,
          onUpdateUser: _updateUser,
        ),
      ),
    );
  }

  void _showAllTransactionsByUser(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PersonalTransactionScreen(
          label: "Your",
          userId: user!.id,
        ),
      ),
    );
  }

  void _logout() async {
    buildLoadingDialog(context);
    await AuthService().logOut();
    if (context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: user == null
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildProfileAvatar(
                      onImageChanged: (image) {},
                      localImageFile: null,
                      imageUrl: user!.profilePic),
                  const SizedBox(height: 8),
                  Text(
                    user!.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    user!.phoneNumber,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () => _showEditProfileScreen(context),
                    child: const Text("Edit Profile"),
                  ),
                  const SizedBox(height: 24),
                  buildListTile(
                    context: context,
                    leadingIcon: Icons.favorite,
                    trailingIcon: Icons.edit,
                    title: 'Default Group',
                    subtitle: user!.defaultGroupName != null
                        ? user!.defaultGroupName!
                        : "No default group",
                    onTap: () => _showEditProfileScreen(context),
                  ),
                  buildListTile(
                    context: context,
                    leadingIcon: Icons.monetization_on,
                    trailingIcon: Icons.arrow_forward_ios,
                    title: 'Loans',
                    subtitle: 'View and Manage Your Loans',
                    onTap: () {},
                  ),
                  buildListTile(
                    context: context,
                    leadingIcon: Icons.group_add,
                    trailingIcon: Icons.arrow_forward_ios,
                    title: 'Contributions',
                    subtitle: 'View Your Contributions',
                    onTap: () => _showAllTransactionsByUser(context),
                  ),
                  buildListTile(
                    context: context,
                    leadingIcon: Icons.exit_to_app_sharp,
                    trailingIcon: Icons.logout,
                    title: 'Log Out',
                    subtitle: 'Logout',
                    onTap: _logout,
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
