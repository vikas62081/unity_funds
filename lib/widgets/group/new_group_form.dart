import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/providers/group_provider.dart';
import 'package:unity_funds/utils/new_group_validator.dart';
import 'package:unity_funds/widgets/form_helpers/date_picker.dart';
import 'package:unity_funds/widgets/form_helpers/image_input.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class NewGroupForm extends ConsumerStatefulWidget {
  const NewGroupForm({super.key, this.onGroupCreated});

  final void Function()? onGroupCreated;

  @override
  ConsumerState<NewGroupForm> createState() => _NewGroupFormState();
}

class _NewGroupFormState extends ConsumerState<NewGroupForm> {
  final _formKey = GlobalKey<FormState>();
  final _validator = NewGroupValidator();
  String? name;
  String? description;
  DateTime? eventDate;
  String? image;
  bool isDefaultGroup = true;

  void _submitGroup(BuildContext context) {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      if (eventDate == null || image == null) {
        _showErrorDialog(context);
        return;
      }

      _formKey.currentState!.save();

      Group group = Group(
        name: name!,
        description: description!,
        eventDate: eventDate!,
        image: image!,
      );

      ref.read(groupProvider.notifier).addGroup(group);
      showSnackbar(context, "Group added successfully.");

      if (widget.onGroupCreated != null) widget.onGroupCreated!();
      Navigator.of(context).pop();
    }
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog.adaptive(
        title: const Text("Error"),
        content: const Text(
          "Event Date and Image cannot be empty, please provide valid input.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Ok"),
          )
        ],
      ),
    );
  }

  void _updateGroupImage(File file) {
    image = dirname(file.path);
  }

  void _onEventDateChange(DateTime newDate) {
    eventDate = newDate;
  }

  void _onCheckboxChange(bool? newValue) {
    setState(() {
      isDefaultGroup = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SectionTitle("Add a new group"),
        const SizedBox(height: 16),
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTextField(
                context: context,
                hintText: "Enter function name",
                icon: Icons.festival_sharp,
                validator: _validator.validateFunctionName,
                onSaved: (newValue) => name = newValue!,
              ),
              const SizedBox(height: 16),
              buildTextField(
                context: context,
                hintText: "Enter description",
                icon: Icons.description_outlined,
                validator: _validator.validateDescription,
                onSaved: (newValue) => description = newValue!,
              ),
              const SizedBox(height: 16),
              DatePicker(onEventDateChanged: _onEventDateChange),
              const SizedBox(height: 16),
              ImageInput(
                  onImageChanged: _updateGroupImage,
                  labelBeforeImage: "No image"),
              const SizedBox(height: 16),
              _buildCheckbox(),
              const SizedBox(height: 16),
              buildSaveButton(
                  context: context, onPressed: () => _submitGroup(context))
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildCheckbox() {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      value: isDefaultGroup,
      onChanged: _onCheckboxChange,
      subtitle: const Text(
        "Set default group for easy expense and contributions when adding new entries.",
      ),
    );
  }
}
