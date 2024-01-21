import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/providers/group_provider.dart';
import 'package:unity_funds/providers/transaction_provider.dart';
import 'package:unity_funds/utils/new_transaction_validator.dart';
import 'package:unity_funds/widgets/form_helpers/image_input.dart';
import 'package:unity_funds/widgets/group/new_group_form.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class AddExpenseForm extends ConsumerStatefulWidget {
  const AddExpenseForm({super.key, required this.group});
  final Group? group;

  @override
  ConsumerState<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends ConsumerState<AddExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _validator = NewTransactionValidator();
  late String description;
  late String amount;
  late Group group;
  File? billImage;
  late List<Group> groups;
  bool isEnableGroupInput = true;

  @override
  void initState() {
    groups = ref.read(groupProvider);
    if (widget.group != null) {
      group = widget.group!;
      isEnableGroupInput = false;
    }
    super.initState();
  }

  void _submitExpense() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      Transaction expense = Transaction.debit(
        bill: billImage,
        group: group.name,
        description: description,
        amount: double.parse(amount),
      );

      ref.read(transactionPrvoider.notifier).addNewTransaction(expense);
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
              value: isEnableGroupInput ? null : group,
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
              onChanged: isEnableGroupInput ? (value) => {} : null,
              validator: _validator.validateGroup,
              onSaved: (newValue) => group = newValue!,
              decoration: InputDecoration(
                hintText: "Select group",
                prefixIcon: Icon(
                  Icons.group_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          buildTextField(
            context: context,
            hintText: "Enter a description",
            icon: Icons.description_outlined,
            validator: _validator.validateDescription,
            onSaved: (newValue) => description = newValue!,
          ),
          const SizedBox(height: 16),
          buildTextField(
              context: context,
              hintText: "0.00",
              icon: Icons.currency_rupee_outlined,
              validator: _validator.validateAmount,
              onSaved: (newValue) => amount = newValue!,
              keyboardType: TextInputType.number),
          const SizedBox(height: 16),
          ImageInput(
            onImageChanged: _updateBillImage,
            labelBeforeImage: "Bill not selected",
          ),
          const SizedBox(height: 16),
          buildSaveButton(context: context, onPressed: _submitExpense),
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
