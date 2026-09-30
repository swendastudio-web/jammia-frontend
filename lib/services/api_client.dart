import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/auth_tokens.dart';
import 'api_exception.dart';
import 'auth_session.dart';

/// Sends requests to the JAMIA backend.
/// - adds the login token,
/// - turns backend errors into ApiException with a readable message,
/// - if the access token has expired (401), quietly gets a new one with the refresh token and retries once.
class ApiClient {
  final AuthSession session;
  final http.Client _http;
  final String _baseUrl;

  ApiClient({required this.session, http.Client? httpClient, String? baseUrl})
      : _http = httpClient ?? http.Client(),
        _baseUrl = baseUrl ?? ApiConfig.baseUrl;

  Future<dynamic> get(String path, {bool auth = true}) => _send('GET', path, auth: auth);

  Future<dynamic> post(String path, {Object? body, bool auth = true}) =>
      _send('POST', path, body: body, auth: auth);

  Future<dynamic> put(String path, {Object? body, bool auth = true}) =>
      _send('PUT', path, body: body, auth: auth);

  Future<dynamic> delete(String path, {bool auth = true}) => _send('DELETE', path, auth: auth);

  Future<dynamic> _send(String method, String path, {Object? body, required bool auth}) async {
    var response = await _request(method, path, body, auth);

    if (response.statusCode == 401 && auth && session.tokens != null) {
      final refreshed = await _refreshTokens();
      if (!refreshed) {
        await session.clear();
        throw const ApiException('Your session has expired. Please log in again.',
            kind: ApiErrorKind.sessionExpired, statusCode: 401);
      }
      response = await _request(method, path, body, auth);
    }

    return _handle(response);
  }

  Future<http.Response> _request(String method, String path, Object? body, bool auth) async {
    final request = http.Request(method, Uri.parse('$_baseUrl$path'));
    request.headers['Content-Type'] = 'application/json';
    final token = session.tokens?.accessToken;
    if (auth && token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    if (body != null) {
      request.body = jsonEncode(body);
    }

    try {
      final streamed = await _http.send(request).timeout(const Duration(seconds: 15));
      return http.Response.fromStream(streamed);
    } on SocketException {
      throw const ApiException('Cannot reach the JAMIA server.', kind: ApiErrorKind.network);
    } on TimeoutException {
      throw const ApiException('The JAMIA server took too long to answer.', kind: ApiErrorKind.timeout);
    } on http.ClientException {
      throw const ApiException('Cannot reach the JAMIA server.', kind: ApiErrorKind.network);
    }
  }

  // Uses the refresh token to get a new pair. Returns false if that is not possible.
  Future<bool> _refreshTokens() async {
    final refreshToken = session.tokens?.refreshToken;
    if (refreshToken == null) return false;
    final response = await _request('POST', '/api/auth/refresh', {'refreshToken': refreshToken}, false);
    if (response.statusCode != 200) return false;
    await session.saveTokens(AuthTokens.fromJson(jsonDecode(response.body) as Map<String, dynamic>));
    return true;
  }

  dynamic _handle(http.Response response) {
    final hasBody = response.body.isNotEmpty;
    final decoded = hasBody ? _tryDecode(response.body) : null;

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded;
    }

    // The backend sends errors as ProblemDetail: {"detail": "...", "errors": {"field": "..."}}
    // (Backend messages are English for now; the app translates its own messages.)
    var message = '';
    var fieldErrors = <String, String>{};
    if (decoded is Map<String, dynamic>) {
      if (decoded['detail'] is String) message = decoded['detail'] as String;
      if (decoded['errors'] is Map) {
        fieldErrors = (decoded['errors'] as Map).map((k, v) => MapEntry(k.toString(), v.toString()));
      }
    }
    throw ApiException(message, statusCode: response.statusCode, fieldErrors: fieldErrors);
  }

  static dynamic _tryDecode(String body) {
    try {
      return jsonDecode(body);
    } on FormatException {
      return null;
    }
  }
}
