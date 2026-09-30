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
      'turnOrderMethod': null, 'startDate': null, 'creatorUserId': 45, 'createdAt': '2026-09-29T22:55:38',
      'members': [
        {'userId': 45, 'firstName': 'Salim', 'lastName': 'Al-Mughairi', 'turnPosition': null, 'hasProfilePhoto': false},
      ],
    });
    expect(room.name, 'Family Jamia');
    expect(room.isOpen, isTrue);
    expect(room.members.single.fullName, 'Salim Al-Mughairi');
  });

  test('Contribution.fromJson reads dates, people and amounts', () {
    final c = Contribution.fromJson({
      'id': 1, 'cycleNumber': 2, 'dueDate': '2026-11-30', 'amount': 1000.5, 'status': 'PAID',
      'paidAt': null, 'confirmedAt': null,
      'payer': {'userId': 1, 'firstName': 'A', 'lastName': 'B', 'turnPosition': 1, 'hasProfilePhoto': false},
      'recipient': {'userId': 2, 'firstName': 'C', 'lastName': 'D', 'turnPosition': 2, 'hasProfilePhoto': false},
    });
    expect(c.dueDate, DateTime(2026, 11, 30));
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
