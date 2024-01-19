import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:unity_funds/modals/expense.dart';

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  ExpenseNotifier() : super([]);

  void addNewExpense(Expense expense) {
    state = [...state, expense];
  }
}

final expenseProvider = StateNotifierProvider<ExpenseNotifier, List<Expense>>(
  (ref) => ExpenseNotifier(),
);
