import 'package:jamia_mobile/models/auth_tokens.dart';
import 'package:jamia_mobile/services/settings_storage.dart';
import 'package:jamia_mobile/services/token_storage.dart';

/// Keeps tokens in memory instead of the phone's secure storage (not available in tests).
class FakeTokenStorage extends TokenStorage {
  AuthTokens? saved;

  FakeTokenStorage([this.saved]);

  @override
  Future<AuthTokens?> read() async => saved;

  @override
  Future<void> write(AuthTokens tokens) async => saved = tokens;

  @override
  Future<void> clear() async => saved = null;
}

/// Keeps the chosen language in memory instead of the phone's storage.
class FakeSettingsStorage extends SettingsStorage {
  String? language;

  FakeSettingsStorage([this.language]);

  @override
  Future<String?> readLanguage() async => language;

  @override
  Future<void> writeLanguage(String code) async => language = code;
}

const userJson = {
  'id': 45,
  'firstName': 'Salim',
  'lastName': 'Al-Mughairi',
  'email': 'salim@test.com',
  'phoneNumber': null,
  'subscriptionPlan': 'FREE',
  'role': 'USER',
  'preferredLanguage': 'en',
  'hasProfilePhoto': false,
  'createdAt': '2026-09-29T22:44:06',
};

const tokensJson = {'accessToken': 'access-1', 'refreshToken': 'refresh-1', 'tokenType': 'Bearer', 'expiresIn': 3600};

