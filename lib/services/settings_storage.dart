import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Keeps small app settings on the phone (for now: the chosen language).
/// Uses the same secure storage as the login tokens, so no extra library is needed.
class SettingsStorage {
  static const _languageKey = 'jamia_language';

  final FlutterSecureStorage _storage;

  SettingsStorage([FlutterSecureStorage? storage]) : _storage = storage ?? const FlutterSecureStorage();

  Future<String?> readLanguage() => _storage.read(key: _languageKey);

  Future<void> writeLanguage(String code) => _storage.write(key: _languageKey, value: code);
}
