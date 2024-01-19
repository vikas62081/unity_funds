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

  void _submitExpense() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      if (eventDate == null || image == null) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog.adaptive(
                  title: const Text("Error"),
                  content: const Text(
                      "Event Date and Image can not be empty, please provide valid input."),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Ok"))
                  ],
                ));
        return;
      }

      _formKey.currentState!.save();

      Group group = Group(
          name: name!,
          description: description!,
          eventDate: eventDate!,
          isDefault: isDefaultGroup,
          image: image!);

      ref.watch(groupProvider.notifier).addNewGroup(group);
      showSnakebar(context, "Group add successfully.");
      if (widget.onGroupCreated != null) widget.onGroupCreated!();
      Navigator.of(context).pop();
    }
  }

  void _updateBillImage(File file) {
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  maxLength: 30,
                  decoration: InputDecoration(
                      hintText: "Enter function name",
                      prefixIcon: Icon(Icons.festival,
                          color: Theme.of(context).colorScheme.primary),
                      border: const OutlineInputBorder()),
                  textCapitalization: TextCapitalization.sentences,
                  validator: _validator.validateFunctionName,
                  onSaved: (newValue) => name = newValue!,
                  autovalidateMode: AutovalidateMode.onUserInteraction),
              const SizedBox(height: 4),
              TextFormField(
                  decoration: InputDecoration(
                      hintText: "Enter description",
                      prefixIcon: Icon(Icons.description,
                          color: Theme.of(context).colorScheme.primary),
                      border: const OutlineInputBorder()),
                  textCapitalization: TextCapitalization.sentences,
                  validator: _validator.validateDescription,
                  onSaved: (newValue) => description = newValue!,
                  autovalidateMode: AutovalidateMode.onUserInteraction),
              const SizedBox(height: 16),
              DatePicker(
                onEventDateChanged: _onEventDateChange,
              ),
              const SizedBox(height: 16),
              ImageInput(onBillImageChanged: _updateBillImage),
              const SizedBox(height: 16),
              CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: isDefaultGroup,
                  onChanged: _onCheckboxChange,
                  subtitle: const Text(
                      "Set default group for easy expense and contributions when adding new entries.")),
              const SizedBox(height: 16),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.primaryContainer),
                    fixedSize: const MaterialStatePropertyAll(
                        Size(double.maxFinite, 60)),
                  ),
                  onPressed: _submitExpense,
                  child: const Text(
                    "Save",
                  ))
            ],
          )),
    );
  }
}
