import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:integration_test/integration_test.dart';
import 'package:jamia_mobile/config/api_config.dart';
import 'package:jamia_mobile/main.dart';
import 'package:jamia_mobile/services/app_services.dart';

/// Drives the real app on a simulator against the REAL backend (must be running on port 8095):
/// sign up -> create room -> invite -> a friend asks to join -> accept -> start -> payments -> profile -> log out.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final stamp = DateTime.now().millisecondsSinceEpoch;
  final creatorEmail = 'creator$stamp@flow.jamia.test';
  final friendEmail = 'friend$stamp@flow.jamia.test';
  const password = 'Secret1234';

  // Lets a person (or a screenshot) see the screen for a moment.
  Future<void> look(WidgetTester tester, [int seconds = 2]) async {
    await Future<void>.delayed(Duration(seconds: seconds));
    await tester.pumpAndSettle();
  }

  Future<void> closeKeyboard(WidgetTester tester) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
  }

  Future<void> tapButton(WidgetTester tester, Type type, String text) async {
    final finder = find.widgetWithText(type, text).last;
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  // For buttons with an icon (FilledButton.icon, OutlinedButton.icon): find them by their label.
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

  testWidgets('full JAMIA journey through the real screens', (tester) async {
    final services = AppServices.create();
    await services.session.clear(); // start logged out
    await tester.pumpWidget(JamiaApp(services: services));
    await tester.pumpAndSettle();

    // 0. First start on this phone: choose the language (English for this test)
    if (find.byKey(const Key('language-continue')).evaluate().isNotEmpty) {
      await look(tester);
      await tester.tap(find.byKey(const Key('language-en')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('language-continue')));
      await tester.pumpAndSettle();
    }

    // 1. Sign up
    expect(find.text('Log in'), findsOneWidget);
    await look(tester);
    await tester.tap(find.text("Don't have an account? Sign up"));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('register-first-name')), 'Salim');
    await tester.enterText(find.byKey(const Key('register-last-name')), 'Creator');
    await tester.enterText(find.byKey(const Key('register-email')), creatorEmail);
    await tester.enterText(find.byKey(const Key('register-password')), password);
    await closeKeyboard(tester);
    await look(tester);
    await tapButton(tester, FilledButton, 'Create account');
    await look(tester, 3);

    // 2. My rooms (empty) -> create a room
    expect(find.text('No rooms yet'), findsOneWidget);
    await tester.tap(find.text('New room'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('room-name')), 'Family Jamia');
    await tester.enterText(find.byKey(const Key('room-amount')), '1000');
    await tester.enterText(find.byKey(const Key('room-currency')), 'omr');
    await tester.enterText(find.byKey(const Key('room-max-members')), '3');
    await closeKeyboard(tester);
    await look(tester);
    await tapButton(tester, FilledButton, 'Create room');
    await look(tester, 3);

    // 3. Room details -> invite link sheet
    expect(find.text('Family Jamia'), findsWidgets);
    expect(find.text('Salim Creator (you)'), findsOneWidget);
    await tapText(tester, 'Invite people');
    await look(tester);
    expect(find.text('Your invite link'), findsOneWidget);
    await tapText(tester, 'Copy link');
    await look(tester);

    // 4. A friend (outside the app, through the backend) opens the link and asks to join
    final roomId = (await services.rooms.getMyRooms()).single.id;
    final token = (await services.invitations.getMyInviteLink(roomId)).token;
    await backend('POST', '/api/users',
        body: {'firstName': 'Ahmed', 'lastName': 'Friend', 'email': friendEmail, 'password': password});
    final friendToken = (await backend('POST', '/api/auth/login',
        body: {'email': friendEmail, 'password': password}))['accessToken'] as String;
    await backend('POST', '/api/invites/$token/join-requests', token: friendToken);

    // 5. Creator refreshes: sees who asks AND who referred them -> Accept
    await tester.fling(find.byType(ListView).first, const Offset(0, 500), 1500);
    await tester.pumpAndSettle();
    await look(tester);
    expect(find.text('Ahmed Friend'), findsOneWidget);
    expect(find.text('Referred by Salim Creator'), findsOneWidget);
    await look(tester, 3);
    await tapButton(tester, FilledButton, 'Accept');
    await look(tester, 3);
    expect(find.text('Members (2 of 3)'), findsOneWidget);

    // 6. Start the room (random order)
    await tapText(tester, 'Start room');
    await look(tester);
    await tapButton(tester, FilledButton, 'Start room');
    await look(tester);
    await tester.tap(find.widgetWithText(TextButton, 'Start'));
    await tester.pumpAndSettle();
    await look(tester, 3);
    expect(find.text('Active'), findsOneWidget);

    // 7. Payments: mark the action that belongs to the creator
    await tapText(tester, 'Payments');
    await look(tester, 3);
    expect(find.textContaining('Cycle 1'), findsOneWidget);
    if (find.text('I paid').evaluate().isNotEmpty) {
      await tester.tap(find.text('I paid').first);
      await tester.pumpAndSettle();
      await look(tester);
      expect(find.text('Paid'), findsWidgets);
    } else {
      await tester.tap(find.text('I received it').first);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, 'Yes, received'));
      await tester.pumpAndSettle();
      await look(tester);
      expect(find.text('Received'), findsWidgets);
    }
    await look(tester, 3);

    // 8. Back to My rooms -> Profile: add phone, save, log out
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    await look(tester);
    expect(find.text('Active'), findsOneWidget);
    await tester.tap(find.byTooltip('Profile'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextFormField, 'Phone (optional)'), '+96891234567');
    await closeKeyboard(tester);
    await tapButton(tester, FilledButton, 'Save');
    await look(tester);
    expect(find.text('Profile saved.'), findsOneWidget);
    await tapText(tester, 'Log out');
    await look(tester);
    expect(find.text('Log in'), findsOneWidget);
  });
}
