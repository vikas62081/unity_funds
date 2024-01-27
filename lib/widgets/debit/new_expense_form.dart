import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/providers/debit_notifier.dart';
import 'package:unity_funds/providers/group_provider.dart';
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
  String? groupId;
  File? billImage;
  List<Group>? groups;
  bool isEnableGroupInput = true;

  Future<List<Group>> _loadGroups() async {
    List<Group> groupList;
    await ref.read(groupProvider.notifier).getGroups();
    groupList = await ref.read(groupProvider);
    setState(() {
      groups = groupList;
    });
    return groupList;
  }

  void _setGroupInitialState(String newGroupId) async {
    await _loadGroups();
    setState(() {
      groupId = newGroupId;
    });
  }

  Group _getGroupById(String id) {
    return groups!.firstWhere((element) => element.id == id);
  }

  @override
  void initState() {
    if (widget.group != null) {
      _setGroupInitialState(widget.group!.id);
      isEnableGroupInput = false;
      return;
    }
    _loadGroups();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submitExpense(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      buildLoadingDialog(context);
      _formKey.currentState!.save();
      final Group group = _getGroupById(groupId!);

      Transaction expense = Transaction.debit(
        bill: null,
        groupName: group.name,
        groupId: group.id,
        description: description,
        amount: double.parse(amount),
      );

      await ref
          .read(debitTransactionPrvoider.notifier)
          .addDebitTransaction(expense, billImage);
      await ref
          .read(groupProvider.notifier)
          .updateGroupTotalExpenses(group.id, double.parse(amount));
      if (context.mounted) {
        if (context.mounted) {
          showSnackbar(context, "Expense added successfully.");
          Navigator.of(context).pop(); // removing loader
          Navigator.of(context).pop(); // removing form
        }
      }
    }
  }

  void _updateBillImage(File file) {
    billImage = file;
  }

  void _showAlertMessage(BuildContext context) async {
    if (groups!.isNotEmpty) return;
    await showDialog(
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
              _showAddGroupDialog(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
    _loadGroups();
    return;
  }

  void _showAddGroupDialog(BuildContext context) async {
    await showModalBottomSheet(
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
    _loadGroups();
  }

  @override
  Widget build(BuildContext context) {
    if (groups == null || (widget.group != null && groupId == null)) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _showAlertMessage(context),
            child: DropdownButtonFormField<String>(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              alignment: Alignment.center,
              onTap: () => _showAlertMessage(context),
              value: groupId,
              items: groups!
                  .map((group) => DropdownMenuItem(
                        value: group.id,
                        child: Text(
                          group.name,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: isEnableGroupInput ? (value) => {} : null,
              // validator: _validator.validateGroup,
              onSaved: (newValue) => groupId = newValue!,
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
          buildSaveButton(
              context: context, onPressed: () => _submitExpense(context)),
          const SizedBox(height: 4),
          TextButton(
            onPressed: () => _showAddGroupDialog(context),
            child: const Text("Can't find your group? Try adding a new one."),
          ),
        ],
      ),
    );
  }
}
