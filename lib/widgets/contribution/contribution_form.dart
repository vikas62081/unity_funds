import 'package:flutter/material.dart';
import 'package:unity_funds/utils/new_people_validator.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class AddContributionForm extends StatefulWidget {
  const AddContributionForm({super.key});

  @override
  State<AddContributionForm> createState() => _AddContributionFormState();
}

class _AddContributionFormState extends State<AddContributionForm> {
  final _validator = NewPeopleValidator();
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String phoneNumber;
  late String wardNumber;
  late int familyMemberCount;

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      // save the form state
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
                  hintText: "Select group"),
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
                  // validator: _validator.validateAmount,
                  // onSaved: (newValue) => amount = newValue!,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              buildSaveButton(context: context, onPressed: _saveForm),
            ],
          ),
        ),
      ]),
    );
    ;
  }
}
