import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/modals/user.dart';
import 'package:unity_funds/providers/group_provider.dart';
import 'package:unity_funds/utils/new_member_validator.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen(
      {super.key, required this.user, required this.onUpdateUser});

  final User user;
  final void Function(User user) onUpdateUser;

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _validator = NewMemberValidator();
  final _formKey = GlobalKey<FormState>();
  late List<Group> groups;

  String? group;
  String? email;
  String? phoneNumber;
  File? image;
  late String name;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    groups = ref.read(groupProvider);
    name = widget.user.name;
    phoneNumber = widget.user.phoneNumber;
    email = widget.user.email;
    group = widget.user.defaultGroupName;
    image = widget.user.image;

    super.initState();
  }

  void _profilePictureChanged(File profilePic) {
    setState(() {
      image = profilePic;
    });
  }

  void _submitProfile(BuildContext context) {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      if (group == null) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog.adaptive(
                  title: const Text("Error"),
                  content: const Text("Please select default group"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Ok"))
                  ],
                ));
        return;
      }

      _formKey.currentState!.save();
      widget.onUpdateUser(User(
          name: name,
          phoneNumber: phoneNumber!,
          familyMemberCount: widget.user.familyMemberCount,
          address: widget.user.address,
          defaultGroupName: group,
          email: email,
          image: image));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildProfileAvatar(
                    isEditable: true,
                    onImageChanged: _profilePictureChanged,
                    image: image),
                const SizedBox(height: 16),
                buildTextField(
                    context: context,
                    hintText: "Full Name",
                    icon: Icons.person,
                    initialValue: name,
                    validator: _validator.validateName,
                    onSaved: (newValue) => name = newValue!),
                const SizedBox(height: 16),
                buildTextField(
                  context: context,
                  hintText: "Phone",
                  icon: Icons.phone,
                  initialValue: phoneNumber,
                  validator: _validator.validatePhoneNumber,
                  onSaved: (newValue) => phoneNumber = newValue!,
                ),
                const SizedBox(height: 16),
                // Text fields for updating profile details
                buildTextField(
                  context: context,
                  hintText: "Email",
                  icon: Icons.email,
                  initialValue: email,
                  validator: _validator.validateEmail,
                  onSaved: (newValue) => email = newValue!,
                ),

                const SizedBox(height: 16),
                buildSearchableDropdown(
                    context: context,
                    icon: Icons.festival_sharp,
                    hintText: "Select group",
                    enabled: true,
                    initialSelection: widget.user.defaultGroupName,
                    reduceWidth: 32,
                    onSelected: (String? value) => group = value!,
                    items: groups
                        .map((group) => DropdownMenuEntry(
                            label: group.name, value: group.name))
                        .toList()),
                const SizedBox(height: 16),
                buildSaveButton(
                    context: context, onPressed: () => _submitProfile(context))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
