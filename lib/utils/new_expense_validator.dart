import 'package:unity_funds/modals/group.dart';

class NewExpenseValidator {
  String? validateGroup(Group? value) {
    if (value == null) {
      return "Group name cannot be empty";
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return "Description cannot be empty";
    }
    if (value.trim().length < 3) {
      return "Description must be at least 3 characters";
    }
    return null;
  }

  String? validateAmount(String? value) {
    final amount = double.tryParse(value!);
    if (amount == null || amount <= 0) {
      return "Amount must be valid currency";
    }
    return null;
  }
}
