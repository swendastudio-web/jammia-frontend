import 'package:flutter/foundation.dart';

import '../models/auth_tokens.dart';
import '../models/user.dart';
import 'token_storage.dart';

/// Remembers who is signed in (tokens + user) and tells the app when that changes.
/// ChangeNotifier is built into Flutter: screens can listen and rebuild.
class AuthSession extends ChangeNotifier {
  final TokenStorage _storage;

  AuthTokens? _tokens;
  User? _user;

  AuthSession(this._storage);

  AuthTokens? get tokens => _tokens;
  User? get user => _user;
  bool get isLoggedIn => _tokens != null && _user != null;

  /// Reads tokens saved from an earlier app start (does not check them with the backend).
  Future<AuthTokens?> loadSavedTokens() async {
    _tokens = await _storage.read();
    return _tokens;
  }

  Future<void> saveTokens(AuthTokens tokens) async {
    _tokens = tokens;
    await _storage.write(tokens);
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  /// Forget everything (logout, or the session expired).
  Future<void> clear() async {
    _tokens = null;
    _user = null;
    await _storage.clear();
    notifyListeners();
  }
}
