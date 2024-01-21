import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/member.dart';
import 'package:unity_funds/providers/member_provider.dart';
import 'package:unity_funds/utils/new_member_validator.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class NewMemberForm extends ConsumerStatefulWidget {
  const NewMemberForm({super.key});

  @override
  ConsumerState<NewMemberForm> createState() => _NewMemberFormState();
}

class _NewMemberFormState extends ConsumerState<NewMemberForm> {
  final _validator = NewMemberValidator();
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String phoneNumber;
  late String wardNumber;
  late int familyMemberCount;

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      ref.read(memberProvider.notifier).addNewMember(Member(
          name: name,
          phoneNumber: phoneNumber,
          familyMemberCount: familyMemberCount,
          address: wardNumber));

      showSnackbar(context, "Member added successfully.");
      Navigator.of(context).pop();
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
