import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unity_funds/screens/auth/auth_wrapper.dart';
import 'package:unity_funds/screens/expense_tracker.dart';

class AppContentWrapper extends StatelessWidget {
  const AppContentWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (snapshot.hasData) {
          return const ExpenseTrackerScreen(title: "Expense Tracker");
        }
        return const AuthWrapper();
      },
    );
  }
}
