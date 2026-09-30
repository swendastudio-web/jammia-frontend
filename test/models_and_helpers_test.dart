import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jamia_mobile/l10n/app_localizations.dart';
import 'package:jamia_mobile/models/contribution.dart';
import 'package:jamia_mobile/models/invitation.dart';
import 'package:jamia_mobile/models/room.dart';
import 'package:jamia_mobile/services/invitation_service.dart';
import 'package:jamia_mobile/utils/format.dart';
import 'package:jamia_mobile/utils/validators.dart';

void main() {
  setUpAll(() => initializeDateFormatting());

  test('Room.fromJson reads the backend response, including members', () {
    final room = Room.fromJson({
      'id': 14, 'name': 'Family Jamia', 'description': null, 'contributionAmount': 1000,
      'currency': 'OMR', 'frequency': 'MONTHLY', 'maxMembers': 3, 'status': 'OPEN',
      'creatorUserId': 45, 'createdAt': '2026-09-29T22:55:38', 'currentRound': null, 'completedRounds': 2,
      'members': [
        {'userId': 45, 'firstName': 'Salim', 'lastName': 'Al-Mughairi', 'turnPosition': null, 'hasProfilePhoto': false},
      ],
    });
    expect(room.name, 'Family Jamia');
    expect(room.isOpen, isTrue);
    expect(room.members.single.fullName, 'Salim Al-Mughairi');
    expect(room.currentRound, isNull);
    expect(room.completedRounds, 2);
  });

  test('Room.fromJson reads the running round (who receives now, when the turn moves on)', () {
    final room = Room.fromJson({
      'id': 20, 'name': 'Test', 'description': null, 'contributionAmount': 10, 'currency': 'OMR',
      'frequency': 'FIVE_MINUTES', 'maxMembers': 3, 'status': 'ACTIVE', 'creatorUserId': 1,
      'createdAt': '2026-09-30T14:00:00', 'members': [], 'completedRounds': 0,
      'currentRound': {
        'roundNumber': 1, 'status': 'ACTIVE', 'turnOrderMethod': 'RANDOM',
        'startedAt': '2026-09-30T14:00:00', 'endsAt': '2026-09-30T14:15:00', 'completedAt': null,
        'turnCount': 3, 'currentTurn': 2, 'currentRecipientUserId': 7,
        'currentTurnEndsAt': '2026-09-30T14:10:00', 'paymentsTotal': 6, 'paymentsReceived': 1,
      },
    });
    expect(room.isFiveMinuteTest, isTrue);
    expect(room.currentRound!.isRunning, isTrue);
    expect(room.currentRound!.currentTurn, 2);
    expect(room.currentRound!.currentRecipientUserId, 7);
    expect(room.currentRound!.currentTurnEndsAt, DateTime(2026, 9, 30, 14, 10));
  });

  test('Contribution.fromJson reads dates, people and amounts', () {
    final c = Contribution.fromJson({
      'id': 1, 'roundNumber': 1, 'cycleNumber': 2, 'dueAt': '2026-11-30T00:00:00',
      'turnEndsAt': '2026-12-30T00:00:00', 'amount': 1000.5, 'status': 'PENDING', 'late': true,
      'paidAt': null, 'confirmedAt': null,
      'payer': {'userId': 1, 'firstName': 'A', 'lastName': 'B', 'turnPosition': 1, 'hasProfilePhoto': false},
      'recipient': {'userId': 2, 'firstName': 'C', 'lastName': 'D', 'turnPosition': 2, 'hasProfilePhoto': false},
    });
    expect(c.dueAt, DateTime(2026, 11, 30));
    expect(c.late, isTrue);
    expect(c.recipient.fullName, 'C D');
    expect(c.amount, 1000.5);
  });

  test('JoinRequest.fromJson combines requester and referrer names', () {
    final r = JoinRequest.fromJson({
      'id': 7, 'requesterUserId': 3, 'requesterFirstName': 'Sara', 'requesterLastName': 'Ahmed',
      'referredByUserId': 2, 'referredByFirstName': 'Badr', 'referredByLastName': 'Test',
      'status': 'PENDING', 'createdAt': '2026-09-29T21:40:00', 'decidedAt': null,
    });
    expect(r.requesterName, 'Sara Ahmed');
    expect(r.referredByName, 'Badr Test');
  });

  test('extractToken accepts a full link or just the token', () {
    expect(InvitationService.extractToken('https://jamia.app/invite/AbC123'), 'AbC123');
    expect(InvitationService.extractToken('  AbC123  '), 'AbC123');
    expect(InvitationService.extractToken('Join me: https://jamia.app/invite/AbC123 thanks'), 'AbC123');
  });

  test('formatMoney and formatDate follow the language', () {
    expect(formatMoney(1000.5, 'OMR', 'en'), '1,000.50 OMR');
    expect(formatMoney(1234567, 'AED', 'en'), '1,234,567.00 AED');
    expect(formatMoney(1234.5, 'EUR', 'fr'), contains('234,50 EUR'));
    expect(formatDate(DateTime(2026, 10, 31), 'en'), 'Oct 31, 2026');
    expect(formatDate(DateTime(2026, 10, 31), 'fr'), '31 oct. 2026');
    expect(formatDate(DateTime(2026, 10, 31), 'ar'), contains('أكتوبر'));
  });

  test('validators match the backend rules and speak the user\'s language', () {
    final en = lookupAppLocalizations(const Locale('en'));
    final ar = lookupAppLocalizations(const Locale('ar'));
    expect(emailField(en, 'ali@mail.com'), isNull);
    expect(emailField(en, 'not-an-email'), 'Enter a valid email address');
    expect(emailField(ar, 'not-an-email'), 'أدخل بريداً إلكترونياً صحيحاً');
    expect(passwordField(en, 'short'), isNotNull);
    expect(passwordField(en, 'long-enough'), isNull);
    expect(phoneField(en, ''), isNull);
    expect(phoneField(en, '+96891234567'), isNull);
    expect(phoneField(en, '0501234567'), isNotNull);
  });
}
