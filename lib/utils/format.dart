// Small helpers to show money, dates and backend codes in the user's language.
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';

/// 1000.5 + "OMR" -> "1,000.50 OMR" (separators follow the language)
String formatMoney(num amount, String currency, String locale) {
  return '${NumberFormat('#,##0.00', locale).format(amount)} $currency';
}

/// -> "31 Oct 2026" (month name in the user's language)
String formatDate(DateTime date, String locale) => DateFormat.yMMMd(locale).format(date);

/// -> "31 Oct 2026, 09:05"
String formatDateTime(DateTime date, String locale) => DateFormat.yMMMd(locale).add_Hm().format(date);

String frequencyLabel(AppLocalizations t, String frequency) => switch (frequency) {
      'FIVE_MINUTES' => t.frequencyFiveMinutes,
      'WEEKLY' => t.frequencyWeekly,
      'BIWEEKLY' => t.frequencyBiweekly,
      'MONTHLY' => t.frequencyMonthly,
      _ => frequency,
    };

String roomStatusLabel(AppLocalizations t, String status) => switch (status) {
      'OPEN' => t.statusOpen,
      'ACTIVE' => t.statusActive,
      _ => status,
    };

/// -> "14:05"
String formatTime(DateTime date, String locale) => DateFormat.Hm(locale).format(date);

String contributionStatusLabel(AppLocalizations t, String status) => switch (status) {
      'PENDING' => t.paymentNotPaid,
      'PAID' => t.paymentPaid,
      'CONFIRMED' => t.paymentReceived,
      _ => status,
    };
