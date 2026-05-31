import '../l10n/app_localizations.dart';

class Validators {
  // =========================
  // Required Field
  // =========================
  static String? required(
    String? value,
    String fieldName,
    AppLocalizations l10n,
  ) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validationRequiredField(fieldName);
    }

    return null;
  }

  // =========================
  // Email Validator
  // =========================
  static String? email(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validationEmailRequired;
    }

    final email = value.trim();

    final emailRegex = RegExp(
      r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
    );

    if (!emailRegex.hasMatch(email)) {
      return l10n.validationEmailInvalid;
    }

    return null;
  }

  // =========================
  // Password Validator
  // =========================
  static String? password(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validationPasswordRequired;
    }

    final password = value.trim();

    if (password.length < 6) {
      return l10n.validationPasswordMinLength(6);
    }

    if (password.length > 64) {
      return l10n.validationPasswordTooLong;
    }

    // Optional strong password check
    final strongPasswordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>]).+$',
    );

    if (!strongPasswordRegex.hasMatch(password)) {
      return l10n.validationPasswordComplexity;
    }

    return null;
  }

  // =========================
  // Confirm Password
  // =========================
  static String? confirmPassword(
    String? value,
    String originalPassword,
    AppLocalizations l10n,
  ) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validationConfirmPasswordRequired;
    }

    if (value.trim() != originalPassword.trim()) {
      return l10n.validationPasswordsDoNotMatch;
    }

    return null;
  }

  // =========================
  // Numeric Validator
  // =========================
  static String? numeric(
    String? value,
    String fieldName,
    AppLocalizations l10n,
  ) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validationRequiredField(fieldName);
    }

    final parsed = double.tryParse(value.trim());

    if (parsed == null) {
      return l10n.validationNumberInvalid(fieldName);
    }

    if (parsed < 0) {
      return l10n.validationNumberNegative(fieldName);
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
    AppLocalizations l10n,
  ) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validationRequiredField(fieldName);
    }

    if (value.trim().length < min) {
      return l10n.validationMinLength(fieldName, min);
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
    AppLocalizations l10n,
  ) {
    if (value != null && value.trim().length > max) {
      return l10n.validationMaxLength(fieldName, max);
    }

    return null;
  }

  // =========================
  // Phone Number Validator
  // =========================
  static String? phone(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validationPhoneRequired;
    }

    final phone = value.trim();

    final regex = RegExp(r'^[0-9]{9,11}$');

    if (!regex.hasMatch(phone)) {
      return l10n.validationPhoneInvalid;
    }

    return null;
  }

  // =========================
  // Budget Validator
  // =========================
  static String? budget(String? value, AppLocalizations l10n) {
    final error = numeric(value, l10n.budget, l10n);

    if (error != null) {
      return error;
    }

    final amount = double.parse(value!.trim());

    if (amount < 100000) {
      return l10n.validationBudgetTooLow;
    }

    return null;
  }

  // =========================
  // Username Validator
  // =========================
  static String? username(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validationUsernameRequired;
    }

    final username = value.trim();

    if (username.length < 3) {
      return l10n.validationUsernameMinLength(3);
    }

    if (username.length > 20) {
      return l10n.validationUsernameTooLong;
    }

    final regex = RegExp(r'^[a-zA-Z0-9_]+$');

    if (!regex.hasMatch(username)) {
      return l10n.validationUsernameInvalid;
    }

    return null;
  }

  // =========================
  // Description Validator
  // =========================
  static String? description(
    String? value, {
    int maxLength = 500,
    required AppLocalizations l10n,
  }) {
    if (value != null && value.trim().length > maxLength) {
      return l10n.validationDescriptionMaxLength(maxLength);
    }

    return null;
  }
}
