import 'package:flutter/material.dart';
import 'package:unity_funds/utils/new_people_validator.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class NewPeopleForm extends StatefulWidget {
  const NewPeopleForm({super.key});

  @override
  State<NewPeopleForm> createState() => _NewPeopleFormState();
}

class _NewPeopleFormState extends State<NewPeopleForm> {
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
        const SectionTitle("Add new memeber"),
        const SizedBox(height: 16),
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTextField(
                  context: context,
                  hintText: "Enter Name",
                  icon: Icons.person_outline,
                  validator: _validator.validateName,
                  onSaved: (value) => name = value!),
              const SizedBox(height: 16),
              buildTextField(
                  context: context,
                  hintText: "Enter phone number",
                  icon: Icons.phone_outlined,
                  validator: _validator.validatePhoneNumber,
                  onSaved: (value) => phoneNumber = value!,
                  keyboardType: TextInputType.phone,
                  prefixText: "+91 "),
              const SizedBox(height: 16),
              buildTextField(
                  context: context,
                  hintText: "Enter ward number",
                  icon: Icons.location_on_outlined,
                  validator: _validator.validateAddress,
                  onSaved: (value) => wardNumber = value!),
              const SizedBox(height: 16),
              buildTextField(
                  context: context,
                  hintText: "Enter family member's count",
                  icon: Icons.person_add_alt_1_outlined,
                  validator: _validator.validateFamilyCounts,
                  onSaved: (value) => familyMemberCount = int.parse(value!)),
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
