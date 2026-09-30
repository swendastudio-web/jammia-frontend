import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:jamia_mobile/models/auth_tokens.dart';
import 'package:jamia_mobile/services/api_client.dart';
import 'package:jamia_mobile/services/api_exception.dart';
import 'package:jamia_mobile/services/auth_session.dart';

import 'fakes.dart';

void main() {
  late FakeTokenStorage storage;
  late AuthSession session;

  setUp(() async {
    storage = FakeTokenStorage();
    session = AuthSession(storage);
    await session.saveTokens(const AuthTokens(accessToken: 'old-access', refreshToken: 'refresh-1'));
  });

  test('sends the login token and returns the JSON body', () async {
    final client = MockClient((request) async {
      expect(request.headers['Authorization'], 'Bearer old-access');
      return http.Response(jsonEncode({'ok': true}), 200);
    });
    final api = ApiClient(session: session, httpClient: client, baseUrl: 'http://test');

    expect(await api.get('/api/anything'), {'ok': true});
  });

  test('turns a backend error into a readable ApiException with field messages', () async {
    final client = MockClient((_) async => http.Response(
        jsonEncode({'status': 400, 'detail': 'Invalid request data', 'errors': {'email': 'Email is required'}}),
        400));
    final api = ApiClient(session: session, httpClient: client, baseUrl: 'http://test');

    await expectLater(
      api.post('/api/users', body: {}, auth: false),
      throwsA(isA<ApiException>()
          .having((e) => e.statusCode, 'status', 400)
          .having((e) => e.fullMessage, 'message', 'Invalid request data\nEmail is required')),
    );
  });

  test('on 401 it refreshes the tokens quietly and retries once', () async {
    var calls = 0;
    final client = MockClient((request) async {
      calls++;
      if (request.url.path == '/api/auth/refresh') {
        return http.Response(jsonEncode({...tokensJson, 'accessToken': 'new-access', 'refreshToken': 'refresh-2'}), 200);
      }
      return request.headers['Authorization'] == 'Bearer new-access'
          ? http.Response(jsonEncode({'ok': true}), 200)
          : http.Response('', 401);
    });
    final api = ApiClient(session: session, httpClient: client, baseUrl: 'http://test');

    expect(await api.get('/api/rooms'), {'ok': true});
    expect(calls, 3); // first try (401) + refresh + retry
    expect(storage.saved!.accessToken, 'new-access');
    expect(storage.saved!.refreshToken, 'refresh-2');
  });

  test('if refreshing fails, the session is cleared and the user must log in again', () async {
    final client = MockClient((_) async => http.Response('', 401));
    final api = ApiClient(session: session, httpClient: client, baseUrl: 'http://test');

    await expectLater(api.get('/api/rooms'), throwsA(isA<ApiException>().having((e) => e.statusCode, 'status', 401)));
    expect(session.tokens, isNull);
    expect(storage.saved, isNull);
  });

  test('a network failure gives a friendly message', () async {
    final client = MockClient((_) async => throw http.ClientException('connection refused'));
    final api = ApiClient(session: session, httpClient: client, baseUrl: 'http://test');

    await expectLater(
      api.get('/api/rooms'),
      throwsA(isA<ApiException>().having((e) => e.message, 'message', contains('Cannot reach the JAMIA server'))),
    );
  });
}
