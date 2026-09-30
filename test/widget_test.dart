import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:jamia_mobile/main.dart';
import 'package:jamia_mobile/models/auth_tokens.dart';
import 'package:jamia_mobile/services/api_client.dart';
import 'package:jamia_mobile/services/app_services.dart';

import 'fakes.dart';

/// Builds the app with a fake backend ([handler]) and in-memory token storage.
AppServices fakeServices(Future<http.Response> Function(http.Request) handler,
    {FakeTokenStorage? storage, FakeSettingsStorage? settings}) {
  return AppServices.create(
    storage: storage ?? FakeTokenStorage(),
    settings: settings ?? FakeSettingsStorage('en'),
    apiFactory: (session) => ApiClient(session: session, httpClient: MockClient(handler), baseUrl: 'http://test'),
  );
}

void main() {
  testWidgets('starts on the login screen when nobody is signed in', (tester) async {
    await tester.pumpWidget(JamiaApp(services: fakeServices((_) async => http.Response('', 404))));
    await tester.pumpAndSettle();

    expect(find.text('Log in'), findsOneWidget);
    expect(find.text("Don't have an account? Sign up"), findsOneWidget);
  });

  testWidgets('login form checks the fields before sending', (tester) async {
    var requests = 0;
    await tester.pumpWidget(JamiaApp(services: fakeServices((_) async {
      requests++;
      return http.Response('', 404);
    })));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Log in'));
    await tester.pump();

    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
    expect(requests, 0);
  });

  testWidgets('wrong password shows the backend message', (tester) async {
    await tester.pumpWidget(JamiaApp(services: fakeServices((_) async =>
        http.Response(jsonEncode({'status': 401, 'detail': 'Invalid email or password'}), 401))));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('login-email')), 'salim@test.com');
    await tester.enterText(find.byKey(const Key('login-password')), 'wrong-pass');
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();

    expect(find.text('Invalid email or password'), findsOneWidget);
  });

  testWidgets('successful login opens "My rooms" with the user\'s rooms', (tester) async {
    await tester.pumpWidget(JamiaApp(services: fakeServices((request) async {
      switch (request.url.path) {
        case '/api/auth/login':
          return http.Response(jsonEncode(tokensJson), 200);
        case '/api/users/me':
          return http.Response(jsonEncode(userJson), 200);
        case '/api/rooms':
          return http.Response(jsonEncode([
            {'id': 14, 'name': 'Family Jamia', 'contributionAmount': 1000, 'currency': 'OMR',
             'frequency': 'MONTHLY', 'maxMembers': 3, 'status': 'OPEN', 'createdByMe': true},
          ]), 200);
      }
      return http.Response('', 404);
    })));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('login-email')), 'salim@test.com');
    await tester.enterText(find.byKey(const Key('login-password')), 'MyPass123');
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();

    expect(find.text('My rooms'), findsOneWidget);
    expect(find.text('Family Jamia'), findsOneWidget);
    expect(find.text('1,000.00 OMR · Monthly · up to 3 members'), findsOneWidget);
  });

  testWidgets('a saved session opens "My rooms" directly at start', (tester) async {
    final storage = FakeTokenStorage();
    await storage.write(const AuthTokens(accessToken: 'access-1', refreshToken: 'refresh-1'));
    await tester.pumpWidget(JamiaApp(services: fakeServices((request) async {
      if (request.url.path == '/api/users/me') return http.Response(jsonEncode(userJson), 200);
      if (request.url.path == '/api/rooms') return http.Response('[]', 200);
      return http.Response('', 404);
    }, storage: storage)));
    await tester.pumpAndSettle();

    expect(find.text('My rooms'), findsOneWidget);
    expect(find.text('No rooms yet'), findsOneWidget);
  });

  testWidgets('first start on a phone asks for the language; Arabic switches to right-to-left', (tester) async {
    final settings = FakeSettingsStorage(); // nothing chosen yet
    await tester.pumpWidget(JamiaApp(services: fakeServices((_) async => http.Response('', 404), settings: settings)));
    await tester.pumpAndSettle();

    // All five languages are offered, each in its own script.
    for (final name in ['English', 'العربية', 'Français', 'Русский', 'አማርኛ']) {
      expect(find.text(name), findsOneWidget);
    }

    await tester.tap(find.byKey(const Key('language-ar')));
    await tester.pumpAndSettle();
    expect(find.text('اختر لغتك'), findsOneWidget); // the screen previews the chosen language
    await tester.tap(find.byKey(const Key('language-continue')));
    await tester.pumpAndSettle();

    expect(settings.language, 'ar');
    expect(find.text('تسجيل الدخول'), findsOneWidget); // "Log in" in Arabic
    final direction = Directionality.of(tester.element(find.text('تسجيل الدخول')));
    expect(direction, TextDirection.rtl);
  });

  testWidgets('the language chosen on the sign-up screen is sent to the backend', (tester) async {
    Map<String, dynamic>? sentBody;
    await tester.pumpWidget(JamiaApp(services: fakeServices((request) async {
      if (request.url.path == '/api/users') {
        sentBody = jsonDecode(request.body) as Map<String, dynamic>;
        return http.Response(jsonEncode(userJson), 201);
      }
      if (request.url.path == '/api/auth/login') return http.Response(jsonEncode(tokensJson), 200);
      if (request.url.path == '/api/users/me') {
        return http.Response(jsonEncode({...userJson, 'preferredLanguage': 'fr'}), 200);
      }
      if (request.url.path == '/api/rooms') return http.Response('[]', 200);
      return http.Response('', 404);
    })));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Don't have an account? Sign up"));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('language-picker')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Français').last);
    await tester.pumpAndSettle();
    expect(find.text('Prénom'), findsOneWidget); // the form switched to French at once

    await tester.enterText(find.byKey(const Key('register-first-name')), 'Salim');
    await tester.enterText(find.byKey(const Key('register-last-name')), 'Test');
    await tester.enterText(find.byKey(const Key('register-email')), 'salim@test.com');
    await tester.enterText(find.byKey(const Key('register-password')), 'MyPass123');
    await tester.tap(find.widgetWithText(FilledButton, 'Créer un compte'));
    await tester.pumpAndSettle();

    expect(sentBody!['preferredLanguage'], 'fr');
    expect(find.text('Mes cagnottes'), findsOneWidget); // "My rooms" in French
  });

  testWidgets('room screen shows the running round: turn, who receives now, next turn time', (tester) async {
    final storage = FakeTokenStorage();
    await storage.write(const AuthTokens(accessToken: 'access-1', refreshToken: 'refresh-1'));
    final member = {'firstName': 'Badr', 'lastName': 'Test', 'turnPosition': 2, 'hasProfilePhoto': false};
    await tester.pumpWidget(JamiaApp(services: fakeServices((request) async {
      switch (request.url.path) {
        case '/api/users/me':
          return http.Response(jsonEncode(userJson), 200);
        case '/api/rooms':
          return http.Response(jsonEncode([
            {'id': 20, 'name': 'Test room', 'contributionAmount': 10, 'currency': 'OMR',
             'frequency': 'FIVE_MINUTES', 'maxMembers': 3, 'status': 'ACTIVE', 'createdByMe': true},
          ]), 200);
        case '/api/rooms/20':
          return http.Response(jsonEncode({
            'id': 20, 'name': 'Test room', 'description': null, 'contributionAmount': 10, 'currency': 'OMR',
            'frequency': 'FIVE_MINUTES', 'maxMembers': 3, 'status': 'ACTIVE', 'creatorUserId': 45,
            'createdAt': '2026-09-30T14:00:00', 'completedRounds': 1,
            'members': [
              {'userId': 45, 'firstName': 'Salim', 'lastName': 'Al-Mughairi', 'turnPosition': 1, 'hasProfilePhoto': false},
              {'userId': 7, ...member},
            ],
            'currentRound': {
              'roundNumber': 2, 'status': 'ACTIVE', 'turnOrderMethod': 'RANDOM',
              'startedAt': '2026-09-30T14:00:00', 'endsAt': '2026-09-30T14:10:00', 'completedAt': null,
              'turnCount': 2, 'currentTurn': 2, 'currentRecipientUserId': 7,
              'currentTurnEndsAt': '2026-09-30T14:10:00', 'paymentsTotal': 2, 'paymentsReceived': 1,
            },
          }), 200);
      }
      return http.Response('', 404);
    }, storage: storage)));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Test room'));
    await tester.pumpAndSettle();

    expect(find.text('Round 2'), findsOneWidget);
    expect(find.text('Turn 2 of 2'), findsOneWidget);
    expect(find.text('Badr Test receives now'), findsOneWidget);
    expect(find.text('Next turn at 14:10'), findsOneWidget);
    expect(find.text('Payments'), findsOneWidget);
    expect(find.text('Rounds history'), findsWidgets);
    // During a round the admin cannot change the size or remove members.
    expect(find.text('Change number of members'), findsNothing);

    // Leave the screen so its 15-second refresh timer is cancelled before the test ends.
    await tester.pageBack();
    await tester.pumpAndSettle();
  });

  testWidgets('"You owe" banner shows the total and opens the list with "I paid"', (tester) async {
    final storage = FakeTokenStorage();
    await storage.write(const AuthTokens(accessToken: 'access-1', refreshToken: 'refresh-1'));
    final owed = [
      for (final id in [1, 2])
        {'contributionId': id, 'roomId': 9, 'roomName': 'Old room', 'currency': 'OMR', 'roundNumber': 1,
         'cycleNumber': id + 1, 'dueAt': '2026-09-30T10:00:00', 'recipientName': 'Badr Test', 'amount': 10,
         'late': true, 'stillMember': false},
    ];
    await tester.pumpWidget(JamiaApp(services: fakeServices((request) async {
      switch (request.url.path) {
        case '/api/users/me':
          return http.Response(jsonEncode(userJson), 200);
        case '/api/rooms':
          return http.Response('[]', 200); // removed from the room: no rooms, but still owes
        case '/api/users/me/owed-payments':
          return http.Response(jsonEncode(owed), 200);
      }
      return http.Response('', 404);
    }, storage: storage)));
    await tester.pumpAndSettle();

    expect(find.text('You owe 20.00 OMR (2 payments)'), findsOneWidget);
    await tester.tap(find.byKey(const Key('owed-banner')));
    await tester.pumpAndSettle();

    expect(find.text('What you owe'), findsOneWidget);
    expect(find.text('To Badr Test'), findsNWidgets(2));
    expect(find.text('You are no longer in this room, but you still owe this payment.'), findsNWidgets(2));
    expect(find.text('I paid'), findsNWidgets(2));
  });
}
