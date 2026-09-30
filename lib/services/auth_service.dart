import '../models/auth_tokens.dart';
import '../models/user.dart';
import 'api_client.dart';
import 'auth_session.dart';

/// Sign up, log in, log out, and restore the session when the app starts.
class AuthService {
  final ApiClient _api;
  final AuthSession _session;

  AuthService(this._api, this._session);

  Future<void> login(String email, String password) async {
    final json = await _api.post('/api/auth/login',
        body: {'email': email, 'password': password}, auth: false);
    await _session.saveTokens(AuthTokens.fromJson(json as Map<String, dynamic>));
    await _loadCurrentUser();
  }

  /// Creates the account, then logs in straight away.
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String preferredLanguage,
  }) async {
    await _api.post('/api/users',
        body: {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
          'preferredLanguage': preferredLanguage,
        },
        auth: false);
    await login(email, password);
  }

  /// Signs this device out on the server (best effort) and forgets the tokens.
  Future<void> logout() async {
    final refreshToken = _session.tokens?.refreshToken;
    if (refreshToken != null) {
      try {
        await _api.post('/api/auth/logout', body: {'refreshToken': refreshToken}, auth: false);
      } catch (_) {
        // Even if the server can't be reached, the phone still forgets the tokens.
      }
    }
    await _session.clear();
  }

  /// At app start: if tokens were saved, check them by loading the user.
  /// Returns true if the user is signed in.
  Future<bool> restoreSession() async {
    final saved = await _session.loadSavedTokens();
    if (saved == null) return false;
    try {
      await _loadCurrentUser();
      return true;
    } catch (_) {
      await _session.clear();
      return false;
    }
  }

  Future<void> _loadCurrentUser() async {
    final json = await _api.get('/api/users/me');
    _session.setUser(User.fromJson(json as Map<String, dynamic>));
  }
}
