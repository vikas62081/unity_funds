class NewGroupValidator {
  String? validateFunctionName(String? value) {
    if (value == null || value.isEmpty) {
      return "Function name cannot be empty";
    }
    if (value.trim().length < 3) {
      return "Functiona name must be at least 3 characters";
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
    final amount = double.tryParse(value!);
    if (amount == null) {
      return "Event date cannot be empty";
    }
    return null;
  }
}
