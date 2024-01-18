import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/expense.dart';
import 'package:unity_funds/providers/expense_provider.dart';
import 'package:unity_funds/utils/form_validation.dart';
import 'package:unity_funds/widgets/form/image_input.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

final groups = [
  "Sarswati Puja",
  "Chath Puja",
  "Vishwakarma Puja",
];

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
  late String group;
  File? billImage;

  void _submitExpense() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      Expense expense;
      if (billImage == null) {
        expense = Expense.withoutBill(
            group: group,
            description: description,
            amount: double.parse(amount));
      } else {
        expense = Expense(
            bill: billImage,
            group: group,
            description: description,
            amount: double.parse(amount));
      }
      ref.watch(expenseProvider.notifier).addNewExpense(expense);
      showSnakebar(context, "Expense add successfully.");
      Navigator.of(context).pop();
    }
  }

  void _updateBillImage(File file) {
    billImage = file;
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
              DropdownButtonFormField(
                items: groups
                    .map(
                        (cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (value) {},
                validator: _validator.validateGroup,
                onSaved: (newValue) => group = newValue!,
                decoration: const InputDecoration(
                    hintText: "Select group",
                    prefixIcon: Icon(
                      Icons.category,
                    ),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "Enter a description",
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder()),
                textCapitalization: TextCapitalization.sentences,
                validator: _validator.validateDescription,
                onSaved: (newValue) => description = newValue!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "0.00",
                    prefixIcon: Icon(Icons.currency_rupee),
                    border: OutlineInputBorder()),
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
                  ))
            ],
          )),
    );
  }
}
