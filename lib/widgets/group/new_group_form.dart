import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  File? image;
  bool isDefaultGroup = true;

  void _submitGroup() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      if (eventDate == null || image == null) {
        _showErrorDialog();
        return;
      }

      _formKey.currentState!.save();

      Group group = Group(
        name: name!,
        description: description!,
        eventDate: eventDate!,
        isDefault: isDefaultGroup,
        image: image!,
      );

      ref.watch(groupProvider.notifier).addNewGroup(group);
      showSnackbar(context, "Group added successfully.");

      if (widget.onGroupCreated != null) widget.onGroupCreated!();
      Navigator.of(context).pop();
    }
  }

  void _showErrorDialog() {
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
    image = file;
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
              _buildNameField(),
              const SizedBox(height: 4),
              _buildDescriptionField(),
              const SizedBox(height: 16),
              DatePicker(onEventDateChanged: _onEventDateChange),
              const SizedBox(height: 16),
              ImageInput(
                  onImageChanged: _updateGroupImage,
                  labelBeforeImage: "No image"),
              const SizedBox(height: 16),
              _buildCheckbox(),
              const SizedBox(height: 16),
              _buildSaveButton(),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      maxLength: 30,
      decoration: InputDecoration(
        hintText: "Enter function name",
        prefixIcon: Icon(
          Icons.festival,
          color: Theme.of(context).colorScheme.primary,
        ),
        border: const OutlineInputBorder(),
      ),
      textCapitalization: TextCapitalization.sentences,
      validator: _validator.validateFunctionName,
      onSaved: (newValue) => name = newValue!,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Enter description",
        prefixIcon: Icon(
          Icons.description,
          color: Theme.of(context).colorScheme.primary,
        ),
        border: const OutlineInputBorder(),
      ),
      textCapitalization: TextCapitalization.sentences,
      validator: _validator.validateDescription,
      onSaved: (newValue) => description = newValue!,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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

  Widget _buildSaveButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Theme.of(context).colorScheme.primaryContainer,
        ),
        fixedSize: MaterialStateProperty.all(
          const Size(double.maxFinite, 60),
        ),
      ),
      onPressed: _submitGroup,
      child: const Text("Save"),
    );
  }
}
