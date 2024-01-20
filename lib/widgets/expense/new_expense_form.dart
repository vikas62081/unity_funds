import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/expense.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/providers/expense_provider.dart';
import 'package:unity_funds/providers/group_provider.dart';
import 'package:unity_funds/utils/new_expense_validator.dart';
import 'package:unity_funds/widgets/form_helpers/image_input.dart';
import 'package:unity_funds/widgets/group/new_group_form.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class NewExpenseForm extends ConsumerStatefulWidget {
  const NewExpenseForm({super.key});

  @override
  ConsumerState<NewExpenseForm> createState() => _NewExpenseFormState();
}

class _NewExpenseFormState extends ConsumerState<NewExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _validator = NewExpenseValidator();
  late String description;
  late String amount;
  late Group group;
  File? billImage;
  late List<Group> groups;

  @override
  void initState() {
    groups = ref.read(groupProvider);
    super.initState();
  }

  void _submitExpense() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      Expense expense = Expense(
        bill: billImage,
        group: group.name,
        description: description,
        amount: double.parse(amount),
      );

      ref.watch(expenseProvider.notifier).addNewExpense(expense);
      showSnackbar(context, "Expense added successfully.");
      Navigator.of(context).pop();
    }
  }

  void _updateBillImage(File file) {
    billImage = file;
  }

  void _showAlertMessage() {
    if (groups.isNotEmpty) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog.adaptive(
        title: const Text("No groups found"),
        content: const Text("Try adding a new group to add an expense."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Close"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showAddGroupDialog();
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
    return;
  }

  void _showAddGroupDialog() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      builder: (ctx) {
        return Column(
          children: [
            NewGroupForm(
              onGroupCreated: () {
                setState(() {
                  groups = ref.read(groupProvider);
                });
              },
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: OutlinedButton(
                style: const ButtonStyle(
                  fixedSize:
                      MaterialStatePropertyAll(Size(double.maxFinite, 60)),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _showAlertMessage,
            child: DropdownButtonFormField<Group>(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              alignment: Alignment.center,
              onTap: _showAlertMessage,
              items: groups
                  .map((group) => DropdownMenuItem(
                        value: group,
                        child: Text(
                          group.name,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) => group = value!,
              validator: _validator.validateGroup,
              onSaved: (newValue) => group = newValue!,
              decoration: InputDecoration(
                hintText: "Select group",
                prefixIcon: Icon(
                  Icons.category,
                  color: Theme.of(context).colorScheme.primary,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: "Enter a description",
              prefixIcon: Icon(
                Icons.description,
                color: Theme.of(context).colorScheme.primary,
              ),
              border: const OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.sentences,
            validator: _validator.validateDescription,
            onSaved: (newValue) => description = newValue!,
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: "0.00",
              prefixIcon: Icon(
                Icons.currency_rupee,
                color: Theme.of(context).colorScheme.primary,
              ),
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: _validator.validateAmount,
            onSaved: (newValue) => amount = newValue!,
          ),
          const SizedBox(height: 16),
          ImageInput(
            onImageChanged: _updateBillImage,
            labelBeforeImage: "Bill not selected",
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.primaryContainer,
              ),
              fixedSize: const MaterialStatePropertyAll(
                Size(double.maxFinite, 60),
              ),
            ),
            onPressed: _submitExpense,
            child: const Text("Save"),
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: _showAddGroupDialog,
            child: const Text("Can't find your group? Try adding a new one."),
          ),
        ],
      ),
    );
  }
}
