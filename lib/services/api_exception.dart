/// Kinds of errors the app itself detects (their text is translated in the app).
/// Errors from the backend use [ApiErrorKind.server] and carry the backend's message.
enum ApiErrorKind { server, network, timeout, sessionExpired }

/// An error from the backend or the network.
class ApiException implements Exception {
  final ApiErrorKind kind;
  final String message;
  final int? statusCode;
  final Map<String, String> fieldErrors;

  const ApiException(this.message,
      {this.kind = ApiErrorKind.server, this.statusCode, this.fieldErrors = const {}});

  /// The main message plus any per-field messages, one per line.
  String get fullMessage {
    if (fieldErrors.isEmpty) return message;
    return [message, ...fieldErrors.values].join('\n');
  }

  @override
  String toString() => fullMessage;
}
