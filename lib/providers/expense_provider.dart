import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:unity_funds/modals/expense.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/providers/group_provider.dart';

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  ExpenseNotifier(List<Group> groups)
      : super([
          Expense(
              amount: 10000,
              group: groups[0].name,
              bill: groups[0].image,
              description: "Tent"),
          Expense(
              amount: 1235,
              group: groups[0].name,
              bill: groups[0].image,
              description: "Pandit fee"),
          Expense(
              amount: 1430,
              group: groups[0].name,
              bill: groups[0].image,
              description: "Crackers"),
          Expense(
              amount: 8000,
              group: groups[1].name,
              bill: groups[1].image,
              description: "DJ"),
        ]);

  void addNewExpense(Expense expense) {
    state = [...state, expense];
  }
}

final expenseProvider = StateNotifierProvider<ExpenseNotifier, List<Expense>>(
  (ref) => ExpenseNotifier(ref.read(groupProvider)),
);
