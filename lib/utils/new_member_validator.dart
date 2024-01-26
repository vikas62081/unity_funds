class NewMemberValidator {
  String? validateTextField(String title, String? value) {
    if (value == null || value.isEmpty) {
      return "$title cannot be empty";
    }
    if (value.trim().length < 3) {
      return "$title must be at least 3 characters";
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return "Name cannot be empty";
    }
    if (value.trim().length < 3) {
      return "Name must be at least 3 characters";
    }
    if (value.trim().length > 25) {
      return "Name cannot be more than 25 characters";
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number cannot be empty";
    }
    final numbers = double.tryParse(value);
    if (numbers == null) {
      return "Invalid phone number";
    }
    if (value.trim().length != 10) {
      return "Phone number must be 10 digits";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }
    if (value.trim().length < 6) {
      return "Password must be more than 6 characters";
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return "Confirm password cannot be empty";
    }
    if (value != password) {
      return "Confirm password did not match";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }
    if (value.length < 3 || !value.contains('@')) {
      return "Invalide email address";
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return "Ward number cannot be empty";
    }
    return null;
  }

  String? validateFamilyCounts(String? value) {
    if (value == null || value.isEmpty) {
      return "Member's count cannot be empty";
    }
    final numbers = double.tryParse(value);
    if (numbers == null) {
      return "Invalid family member's count";
    }
    return null;
  }
}
