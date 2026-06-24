class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).+$');

    if (!passwordRegex.hasMatch(value)) {
      return 'Password must contain at least one uppercase letter, one number, and one special character';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value,
      {required String password}) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value.trim() != password.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }
}
