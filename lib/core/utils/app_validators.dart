import 'package:easy_localization/easy_localization.dart';

import '../constants/app_strings.dart';

/// Centralized form validators.
///
/// All messages are localized via easy_localization translation keys, so they
/// can be reused directly inside widgets without inline validation logic.
class AppValidators {
  static final RegExp _emailRegex = RegExp(
    r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$',
  );

  /// Validates that [value] is a non-empty, well-formed email address.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.authLoginEmailRequired.tr();
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return AppStrings.authLoginEmailInvalid.tr();
    }
    return null;
  }

  /// Validates a password.
  ///
  /// Always checks that the field is non-empty. When [minLength] is greater
  /// than zero (default `6`), it also enforces a minimum length. Pass
  /// `minLength: 0` to skip the length check (e.g. for login flows where you
  /// only want to ensure the field is filled).
  static String? validatePassword(
    String? value, {
    int minLength = 6,
  }) {
    if (value == null || value.isEmpty) {
      return AppStrings.authLoginPasswordRequired.tr();
    }
    if (minLength > 0 && value.length < minLength) {
      return AppStrings.authLoginPasswordMinLength.tr();
    }
    return null;
  }

  /// Validates that [value] is non-empty.
  ///
  /// When [fieldName] is provided it will be interpolated into the generic
  /// `validation.field_required` translation; otherwise a neutral fallback is
  /// returned.
  static String? validateRequired(String? value, {String? fieldName}) {
    if (value != null && value.trim().isNotEmpty) return null;
    if (fieldName == null) return AppStrings.validationRequired.tr();
    return AppStrings.validationFieldRequired.tr(args: [fieldName]);
  }

  /// Validates that [value] is a non-empty name.
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.authSignupNameRequired.tr();
    }
    return null;
  }

  /// Validates that [value] matches the [originalPassword].
  static String? validateConfirmPassword(
      String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return AppStrings.authSignupConfirmPasswordRequired.tr();
    }
    if (value != originalPassword) {
      return AppStrings.authSignupPasswordsDoNotMatch.tr();
    }
    return null;
  }
}
