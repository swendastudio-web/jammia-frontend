import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jamia_mobile/main.dart';
import 'package:jamia_mobile/services/app_services.dart';
import 'package:jamia_mobile/services/settings_storage.dart';

/// Short journey in Arabic against the real backend: choose Arabic on first start,
/// sign up, create a room. Checks the right-to-left layout and that the account keeps "ar".
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> look(WidgetTester tester, [int seconds = 2]) async {
    await Future<void>.delayed(Duration(seconds: seconds));
    await tester.pumpAndSettle();
  }

  Future<void> closeKeyboard(WidgetTester tester) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
  }

  testWidgets('Arabic: choose language, sign up, create a room', (tester) async {
    final stamp = DateTime.now().millisecondsSinceEpoch;
    // Pretend this is the first start on the phone: forget any saved language.
    await const SettingsStorageReset().run();
    final services = AppServices.create();
    await services.session.clear();
    await tester.pumpWidget(JamiaApp(services: services));
    await tester.pumpAndSettle();

    await look(tester);
    await tester.tap(find.byKey(const Key('language-ar')));
    await tester.pumpAndSettle();
    await look(tester);
    await tester.tap(find.byKey(const Key('language-continue')));
    await tester.pumpAndSettle();

    expect(find.text('تسجيل الدخول'), findsOneWidget);
    expect(Directionality.of(tester.element(find.text('تسجيل الدخول'))), TextDirection.rtl);
    await look(tester);

    await tester.tap(find.text('ليس لديك حساب؟ أنشئ حساباً'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('register-first-name')), 'سالم');
    await tester.enterText(find.byKey(const Key('register-last-name')), 'تجربة');
    await tester.enterText(find.byKey(const Key('register-email')), 'arabic$stamp@flow.jamia.test');
    await tester.enterText(find.byKey(const Key('register-password')), 'Secret1234');
    await closeKeyboard(tester);
    await look(tester);
    await tester.tap(find.widgetWithText(FilledButton, 'إنشاء حساب'));
    await tester.pumpAndSettle();
    await look(tester);

    expect(find.text('غرفي'), findsOneWidget); // "My rooms"
    expect(services.session.user!.preferredLanguage, 'ar'); // saved in the account

    await tester.tap(find.text('غرفة جديدة'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('room-name')), 'جمعية العائلة');
    await tester.enterText(find.byKey(const Key('room-amount')), '500');
    await tester.enterText(find.byKey(const Key('room-currency')), 'omr');
    await tester.enterText(find.byKey(const Key('room-max-members')), '4');
    await closeKeyboard(tester);
    await look(tester);
    final create = find.widgetWithText(FilledButton, 'إنشاء الغرفة');
    await tester.ensureVisible(create);
    await tester.tap(create);
    await tester.pumpAndSettle();
    await look(tester, 3);

    expect(find.text('دعوة أشخاص'), findsOneWidget); // "Invite people"
    await tester.tap(find.text('دعوة أشخاص'));
    await tester.pumpAndSettle();
    await look(tester, 3);
  });
}

/// Deletes the saved language so the app behaves like a first start.
class SettingsStorageReset {
  const SettingsStorageReset();

  Future<void> run() async {
    final storage = SettingsStorage();
    await storage.writeLanguage('');
  }
}
