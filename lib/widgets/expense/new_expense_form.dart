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
          amount: double.parse(amount));

      ref.watch(expenseProvider.notifier).addNewExpense(expense);
      showSnakebar(context, "Expense add successfully.");
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
              title: const Text("Error"),
              content: const Text(
                  "No group found, try adding a new group to add a expense."),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Close")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showAddGroupDialog();
                    },
                    child: const Text("Add"))
              ],
            ));
    return;
  }

  _showAddGroupDialog() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        useSafeArea: true,
        showDragHandle: true,
        builder: (ctx) {
          return Column(children: [
            Text(
              "Add a group",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            NewGroupForm(
              onGroupCreated: () {
                setState(() {
                  groups = ref.read(groupProvider);
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: OutlinedButton(
                  style: const ButtonStyle(
                    fixedSize:
                        MaterialStatePropertyAll(Size(double.maxFinite, 60)),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    "cancel",
                  )),
            )
          ]);
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
              GestureDetector(
                onTap: _showAlertMessage,
                child: DropdownButtonFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  alignment: Alignment.center,
                  onTap: _showAlertMessage,
                  items: groups
                      .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Expanded(
                            child: Text(
                              cat.name,
                              style: TextStyle(overflow: TextOverflow.ellipsis),
                            ),
                          )))
                      .toList(),
                  onChanged: (value) {},
                  validator: _validator.validateGroup,
                  onSaved: (newValue) => group = newValue!,
                  decoration: InputDecoration(
                      hintText: "Select group",
                      prefixIcon: Icon(Icons.category,
                          color: Theme.of(context).colorScheme.primary),
                      border: const OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    hintText: "Enter a description",
                    prefixIcon: Icon(Icons.description,
                        color: Theme.of(context).colorScheme.primary),
                    border: const OutlineInputBorder()),
                textCapitalization: TextCapitalization.sentences,
                validator: _validator.validateDescription,
                onSaved: (newValue) => description = newValue!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    hintText: "0.00",
                    prefixIcon: Icon(Icons.currency_rupee,
                        color: Theme.of(context).colorScheme.primary),
                    border: const OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: _validator.validateAmount,
                onSaved: (newValue) => amount = newValue!,
              ),
              const SizedBox(height: 16),
              ImageInput(onBillImageChanged: _updateBillImage),
              const SizedBox(height: 20),
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
                  )),
              const SizedBox(height: 4),
              TextButton(
                  onPressed: _showAddGroupDialog,
                  child:
                      const Text("Can't find your group, try adding new one."))
            ],
          )),
    );
  }
}
