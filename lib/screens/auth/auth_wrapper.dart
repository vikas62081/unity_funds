import 'package:flutter/material.dart';
import 'package:unity_funds/screens/auth/login.dart';
import 'package:unity_funds/screens/auth/signup.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLogin = true;

  void _toggleAuthScreens() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLogin) return LoginForm(onCreateAccount: _toggleAuthScreens);
    return SignUpForm(onLogin: _toggleAuthScreens);
  }
}
