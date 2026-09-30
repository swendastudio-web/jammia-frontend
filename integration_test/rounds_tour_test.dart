import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:integration_test/integration_test.dart';
import 'package:jamia_mobile/config/api_config.dart';
import 'package:jamia_mobile/main.dart';
import 'package:jamia_mobile/services/app_services.dart';

/// 5-minute test room through the real screens, against a DEV backend (…spring-boot:run -Dspring-boot.run.profiles=dev):
/// create with "Every 5 minutes (test)" -> friend joins -> start (no date) -> round card -> payments "Now" -> history.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> look(WidgetTester tester, [int seconds = 2]) async {
    await Future<void>.delayed(Duration(seconds: seconds));
    await tester.pumpAndSettle();
  }

  Future<void> tapText(WidgetTester tester, String text) async {
    final finder = find.text(text).last;
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<dynamic> backend(String method, String path, {Object? body, String? token}) async {
    final request = http.Request(method, Uri.parse('${ApiConfig.baseUrl}$path'))
      ..headers['Content-Type'] = 'application/json';
    if (token != null) request.headers['Authorization'] = 'Bearer $token';
    if (body != null) request.body = jsonEncode(body);
    final response = await http.Response.fromStream(await request.send());
    expect(response.statusCode, lessThan(300), reason: '$method $path -> ${response.body}');
    return response.body.isEmpty ? null : jsonDecode(response.body);
  }

  testWidgets('5-minute test room: start a round and watch who receives now', (tester) async {
    final stamp = DateTime.now().millisecondsSinceEpoch;
    final services = AppServices.create();
    await services.session.clear();
    await services.language.setLanguage('en');
    await tester.pumpWidget(JamiaApp(services: services));
    await tester.pumpAndSettle();

    // Sign up
    await tester.tap(find.text("Don't have an account? Sign up"));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('register-first-name')), 'Salim');
    await tester.enterText(find.byKey(const Key('register-last-name')), 'Admin');
    await tester.enterText(find.byKey(const Key('register-email')), 'admin$stamp@flow.jamia.test');
    await tester.enterText(find.byKey(const Key('register-password')), 'Secret1234');
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Create account'));
    await tester.pumpAndSettle();

    // New room with the 5-minute test period
    await tester.tap(find.text('New room'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('room-name')), '5-minute test');
    await tester.enterText(find.byKey(const Key('room-amount')), '10');
    await tester.enterText(find.byKey(const Key('room-currency')), 'omr');
    await tester.enterText(find.byKey(const Key('room-max-members')), '3');
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Monthly'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Every 5 minutes (test)').last);
    await tester.pumpAndSettle();
    await look(tester);
    final create = find.widgetWithText(FilledButton, 'Create room');
    await tester.ensureVisible(create);
    await tester.tap(create);
    await tester.pumpAndSettle();

    // A friend joins through the admin's link (outside the app), the admin accepts in the app
    final roomId = (await services.rooms.getMyRooms()).single.id;
    final link = (await services.invitations.getMyInviteLink(roomId)).token;
    await backend('POST', '/api/users', body: {
      'firstName': 'Ahmed', 'lastName': 'Friend', 'email': 'friend$stamp@flow.jamia.test', 'password': 'Secret1234'});
    final friend = (await backend('POST', '/api/auth/login',
        body: {'email': 'friend$stamp@flow.jamia.test', 'password': 'Secret1234'}))['accessToken'] as String;
    await backend('POST', '/api/invites/$link/join-requests', token: friend);
    await tester.fling(find.byType(ListView).first, const Offset(0, 500), 1500);
    await tester.pumpAndSettle();
    await look(tester);
    await tester.tap(find.widgetWithText(FilledButton, 'Accept'));
    await tester.pumpAndSettle();

    // Start: no date for a 5-minute room
    await tapText(tester, 'Start room');
    expect(find.byKey(const Key('five-minute-note')), findsOneWidget);
    await look(tester);
    await tester.tap(find.widgetWithText(FilledButton, 'Start room'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Start'));
    await tester.pumpAndSettle();
    await look(tester, 3);

    // The round card: round 1, turn 1 of 2, someone receives now, next turn time
    expect(find.byKey(const Key('round-card')), findsOneWidget);
    expect(find.text('Round 1'), findsOneWidget);
    expect(find.text('Turn 1 of 2'), findsOneWidget);
    expect(find.textContaining('receive'), findsWidgets);
    expect(find.textContaining('Next turn at'), findsOneWidget);
    await look(tester, 3);

    // Payments: the current turn is marked "Now"
    await tapText(tester, 'Payments');
    await look(tester, 3);
    expect(find.text('Now'), findsWidgets);
    await tester.pageBack();
    await tester.pumpAndSettle();

    // History shows round 1 running
    await tapText(tester, 'Rounds history');
    await look(tester, 3);
    expect(find.text('Round 1'), findsOneWidget);
    expect(find.text('Running'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    await services.session.clear();
  });
}
