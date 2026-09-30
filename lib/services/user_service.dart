import '../models/auth_tokens.dart';
import '../models/subscription_plan.dart';
import '../models/user.dart';
import 'api_client.dart';
import 'auth_session.dart';

/// The signed-in user's profile, and the subscription plans.
class UserService {
  final ApiClient _api;
  final AuthSession _session;

  UserService(this._api, this._session);

  Future<User> updateProfile({
    required String firstName,
    required String lastName,
    required String? phoneNumber,
    String? preferredLanguage,
  }) async {
    final json = await _api.put('/api/users/me', body: {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber ?? '',
      if (preferredLanguage != null) 'preferredLanguage': preferredLanguage,
    });
    final user = User.fromJson(json as Map<String, dynamic>);
    _session.setUser(user);
    return user;
  }

  /// All other devices are signed out; this device gets new tokens.
  Future<void> changePassword(String currentPassword, String newPassword) async {
    final json = await _api.put('/api/users/me/password',
        body: {'currentPassword': currentPassword, 'newPassword': newPassword});
    await _session.saveTokens(AuthTokens.fromJson(json as Map<String, dynamic>));
  }

  Future<List<SubscriptionPlan>> getPlans() async {
    final json = await _api.get('/api/subscription-plans') as List<dynamic>;
    return json.map((p) => SubscriptionPlan.fromJson(p as Map<String, dynamic>)).toList();
  }
}
