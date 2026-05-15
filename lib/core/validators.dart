class Validators {
  // =========================
  // Required Field
  // =========================
  static String? required(
    String? value,
    String fieldName,
  ) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $fieldName';
    }

    return null;
  }

  // =========================
  // Email Validator
  // =========================
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }

    final email = value.trim();

    final emailRegex = RegExp(
      r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  // =========================
  // Password Validator
  // =========================
  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your password';
    }

    final password = value.trim();

    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }

    if (password.length > 64) {
      return 'Password is too long';
    }

    // Optional strong password check
    final strongPasswordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>]).+$',
    );

    if (!strongPasswordRegex.hasMatch(password)) {
      return 'Password must contain uppercase, number, and special character';
    }

    return null;
  }

  // =========================
  // Confirm Password
  // =========================
  static String? confirmPassword(
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.trim().isEmpty) {
      return 'Please confirm your password';
    }

    if (value.trim() != originalPassword.trim()) {
      return 'Passwords do not match';
    }

    return null;
  }

  // =========================
  // Numeric Validator
  // =========================
  static String? numeric(
    String? value,
    String fieldName,
  ) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $fieldName';
    }

    final parsed = double.tryParse(value.trim());

    if (parsed == null) {
      return '$fieldName must be a valid number';
    }

    if (parsed < 0) {
      return '$fieldName cannot be negative';
    }

    return null;
  }

  // =========================
  // Minimum Length
  // =========================
  static String? minLength(
    String? value,
    int min,
    String fieldName,
  ) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $fieldName';
    }

    if (value.trim().length < min) {
      return '$fieldName must be at least $min characters';
    }

    return null;
  }

  // =========================
  // Maximum Length
  // =========================
  static String? maxLength(
    String? value,
    int max,
    String fieldName,
  ) {
    if (value != null && value.trim().length > max) {
      return '$fieldName must be less than $max characters';
    }

    return null;
  }

  // =========================
  // Phone Number Validator
  // =========================
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter phone number';
    }

    final phone = value.trim();

    final regex = RegExp(r'^[0-9]{9,11}$');

    if (!regex.hasMatch(phone)) {
      return 'Invalid phone number';
    }

    return null;
  }

  // =========================
  // Budget Validator
  // =========================
  static String? budget(String? value) {
    final error = numeric(value, 'budget');

    if (error != null) {
      return error;
    }

    final amount = double.parse(value!.trim());

    if (amount < 100000) {
      return 'Budget too low';
    }

    return null;
  }

  // =========================
  // Username Validator
  // =========================
  static String? username(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter username';
    }

    final username = value.trim();

    if (username.length < 3) {
      return 'Username must be at least 3 characters';
    }

    if (username.length > 20) {
      return 'Username is too long';
    }

    final regex = RegExp(r'^[a-zA-Z0-9_]+$');

    if (!regex.hasMatch(username)) {
      return 'Username can only contain letters, numbers, and underscore';
    }

    return null;
  }

  // =========================
  // Description Validator
  // =========================
  static String? description(
    String? value, {
    int maxLength = 500,
  }) {
    if (value != null && value.trim().length > maxLength) {
      return 'Description must be less than $maxLength characters';
    }

    return null;
  }
}