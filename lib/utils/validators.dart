// Form checks. They match the backend's rules, so most mistakes are caught before sending.
// Each one takes the translations (t) so the message is in the user's language.
import '../l10n/app_localizations.dart';

String? emailField(AppLocalizations t, String? value) {
  if (value == null || value.trim().isEmpty) return t.emailRequired;
  final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim());
  return ok ? null : t.emailInvalid;
}

String? passwordField(AppLocalizations t, String? value) {
  if (value == null || value.isEmpty) return t.passwordRequired;
  if (value.length < 8 || value.length > 72) return t.passwordLength;
  return null;
}

String? requiredText(String? value, String message) =>
    (value == null || value.trim().isEmpty) ? message : null;

/// Optional. International format: "+" then 8-15 digits, e.g. +96891234567
String? phoneField(AppLocalizations t, String? value) {
  if (value == null || value.trim().isEmpty) return null;
  final ok = RegExp(r'^\+[1-9][0-9]{7,14}$').hasMatch(value.trim());
  return ok ? null : t.phoneFormat;
}
