import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/screens/expense_tracker.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 84, 82, 203)),
        useMaterial3: true,
        // textTheme: GoogleFonts.rubikTextTheme()
        // poppinsTextTheme()
        // sofiaSansSemiCondensedTextTheme(),
      ),
      home: const ExpenseTrackerScreen(title: "Expense Tracker"),
    );
  }
}
