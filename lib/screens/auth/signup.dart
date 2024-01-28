import 'package:flutter/material.dart';
import 'package:unity_funds/modals/user.dart';
import 'package:unity_funds/services/auth.dart';
import 'package:unity_funds/utils/new_member_validator.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key, required this.onLogin});

  final void Function() onLogin;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _validator = NewMemberValidator();

  String? name;
  String? email;
  String? phoneNumber;
  String? password;
  String? confirmPassword;

  void _signUp() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      buildLoadingDialog(context);

      _formKey.currentState!.save();
      await AuthService().createAccount(
          User.createNewAccount(
              name: name!, phoneNumber: phoneNumber!, email: email!),
          password!);
      if (context.mounted) Navigator.of(context).pop();
      // Perform sign-up authentication here
      // You can use Firebase Authentication or any other authentication method
      // Example:
      // AuthService().createAccount(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .onPrimaryContainer
                      .withOpacity(.7),
                  radius: 50,
                  child: const Icon(
                    size: 75,
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                buildTextField(
                  context: context,
                  hintText: "Name",
                  icon: Icons.person,
                  onSaved: (value) => name = value,
                  validator: _validator.validateName,
                ),
                const SizedBox(height: 20),
                buildTextField(
                  context: context,
                  hintText: "Email",
                  textCapitalization: TextCapitalization.none,
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => email = value,
                  validator: _validator.validateEmail,
                ),
                const SizedBox(height: 20),
                buildTextField(
                  context: context,
                  hintText: "Phone Number",
                  icon: Icons.phone,
                  onSaved: (value) => phoneNumber = value,
                  validator: _validator.validatePhoneNumber,
                ),
                const SizedBox(height: 20),
                buildTextField(
                  context: context,
                  hintText: "Password",
                  icon: Icons.lock,
                  obscureText: true,
                  onChanged: (value) => password = value,
                  onSaved: (value) => password = value,
                  validator: _validator.validatePassword,
                ),
                const SizedBox(height: 20),
                buildTextField(
                  context: context,
                  hintText: "Confirm Password",
                  icon: Icons.lock,
                  obscureText: true,
                  onSaved: (value) => confirmPassword = value,
                  validator: (value) => _validator.validateConfirmPassword(
                    value,
                    password,
                  ),
                ),
                const SizedBox(height: 20),
                buildSaveButton(
                  context: context,
                  onPressed: _signUp,
                  label: "Sign Up",
                ),
                TextButton(
                  onPressed: widget.onLogin,
                  child: const Text("Already have an account? Log In"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
