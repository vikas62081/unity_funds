class NewGroupValidator {
  String? validateFunctionName(String? value) {
    if (value == null || value.isEmpty) {
      return "Function name cannot be empty";
    }
    if (value.trim().length < 3) {
      return "Function name must be at least 3 characters";
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

  String? validateDate(String? value) {
    final date = DateTime.tryParse(value!);
    if (date == null) {
      return "Invalid date format";
    }
    return null;
  }
}
