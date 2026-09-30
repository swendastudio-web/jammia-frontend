import '../l10n/app_localizations.dart';
import '../services/api_exception.dart';

/// The text to show for an error, in the user's language where the app knows the error.
/// Messages from the backend are shown as they come (English for now).
String errorText(AppLocalizations t, ApiException e) {
  switch (e.kind) {
    case ApiErrorKind.network:
      return t.errorNetwork;
    case ApiErrorKind.timeout:
      return t.errorTimeout;
    case ApiErrorKind.sessionExpired:
      return t.errorSessionExpired;
    case ApiErrorKind.server:
      if (e.message.isEmpty) return t.errorGeneric(e.statusCode ?? 0);
      return e.fullMessage;
  }
}
