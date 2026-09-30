import 'api_client.dart';
import 'auth_service.dart';
import 'auth_session.dart';
import 'contribution_service.dart';
import 'invitation_service.dart';
import 'language_controller.dart';
import 'room_service.dart';
import 'settings_storage.dart';
import 'token_storage.dart';
import 'user_service.dart';

/// All services in one place, created once when the app starts and passed to the screens.
class AppServices {
  final AuthSession session;
  final LanguageController language;
  final ApiClient api;
  final AuthService auth;
  final UserService users;
  final RoomService rooms;
  final InvitationService invitations;
  final ContributionService contributions;

  AppServices._(this.session, this.language, this.api)
      : auth = AuthService(api, session),
        users = UserService(api, session),
        rooms = RoomService(api),
        invitations = InvitationService(api),
        contributions = ContributionService(api);

  factory AppServices.create({
    TokenStorage? storage,
    SettingsStorage? settings,
    ApiClient Function(AuthSession)? apiFactory,
  }) {
    final session = AuthSession(storage ?? TokenStorage());
    final language = LanguageController(settings ?? SettingsStorage());
    final api = apiFactory != null ? apiFactory(session) : ApiClient(session: session);
    return AppServices._(session, language, api);
  }
}
