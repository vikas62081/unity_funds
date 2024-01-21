import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/providers/transaction_provider.dart';
import 'package:unity_funds/utils/new_transaction_validator.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class AddContributionForm extends ConsumerStatefulWidget {
  const AddContributionForm({super.key});

  @override
  ConsumerState<AddContributionForm> createState() =>
      _AddContributionFormState();
}

class _AddContributionFormState extends ConsumerState<AddContributionForm> {
  final _validator = NewTransactionValidator();
  final _formKey = GlobalKey<FormState>();
  String member = "Member";
  String group = "Diwali";
  late double amount;

  void _saveForm(BuildContext context) {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      ref.read(transactionPrvoider.notifier).addNewTransaction(
          Transaction.credit(group: group, amount: amount, member: member));
      showSnackbar(context, "Contribution added successfully.");
      Navigator.of(context).pop();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SectionTitle("Add Contributions"),
        const SizedBox(height: 16),
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSearchableDropdown(
                context: context,
                icon: Icons.festival_sharp,
                hintText: "Select group",
              ),
              const SizedBox(height: 16),
              buildSearchableDropdown(
                  context: context,
                  icon: Icons.person_outline,
                  hintText: "Select a member"),
              const SizedBox(height: 16),
              buildTextField(
                  context: context,
                  hintText: "0.00",
                  icon: Icons.currency_rupee_outlined,
                  validator: _validator.validateAmount,
                  onSaved: (value) => amount = double.tryParse(value!)!,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              buildSaveButton(
                  context: context, onPressed: () => _saveForm(context)),
            ],
          ),
        ),
      ]),
    );
    ;
  }
}
