import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/providers/group_provider.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  // Add TextEditingController for each profile detail
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late Group group;
  late List<Group> groups;
  @override
  void initState() {
    groups = ref.read(groupProvider);
    super.initState();
  }

  void _submitProfile(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
              onPressed: () => _submitProfile(context),
              icon: const Icon(Icons.done))
        ],
      ),
      body: ListView(
        children: [
          buildProfileAvatar(),
          const SizedBox(height: 16),
          buildTextField(
            context: context,
            hintText: "Full Name",
            icon: Icons.person,
            // validator: _validator.validateFunctionName,
            // onSaved: (newValue) => name = newValue!,
          ),
          const SizedBox(height: 16),
          buildTextField(
            context: context,
            hintText: "Email",
            icon: Icons.person,
            // validator: _validator.validateFunctionName,
            // onSaved: (newValue) => name = newValue!,
          ),
          const SizedBox(height: 16),
          // Text fields for updating profile details
          buildTextField(
            context: context,
            hintText: "Phone",
            icon: Icons.person,
            // validator: _validator.validateFunctionName,
            // onSaved: (newValue) => name = newValue!,
          ),

          const SizedBox(height: 16),
          buildSearchableDropdown(
              context: context,
              icon: Icons.festival_sharp,
              hintText: "Select group",
              enabled: true,
              initialSelection: '',
              reduceWidth: 32,
              items: groups
                  .map((group) =>
                      DropdownMenuEntry(label: group.name, value: group.name))
                  .toList()),
        ],
      ),
    );
  }
}
