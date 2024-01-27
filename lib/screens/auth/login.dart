import 'package:flutter/material.dart';
import 'package:unity_funds/services/auth.dart';
import 'package:unity_funds/utils/new_member_validator.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.onCreateAccount});

  final void Function() onCreateAccount;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _validator = NewMemberValidator();

  late String? phoneNumber;
  late String? password;

  void _login() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      buildLoadingDialog(context);
      _formKey.currentState!.save();
      await AuthService().login(phoneNumber!, password!);
      if (context.mounted) Navigator.of(context).pop();
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
                    hintText: "Email",
                    icon: Icons.phone,
                    onSaved: (value) => phoneNumber = value,
                    textCapitalization: TextCapitalization.none,
                    validator: _validator.validateEmail),
                const SizedBox(height: 20),
                buildTextField(
                    context: context,
                    hintText: "Password",
                    icon: Icons.security,
                    obscureText: true,
                    validator: _validator.validatePassword,
                    onSaved: (value) => password = value),
                const SizedBox(height: 20),
                buildSaveButton(
                    context: context, onPressed: _login, label: "Login"),
                const TextButton(
                    onPressed: null, child: Text("Forgot password")),
                TextButton(
                    onPressed: widget.onCreateAccount,
                    child: const Text("Don't have an account? Sign Up"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
