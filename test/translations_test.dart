import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards the "add one file = new language" promise:
/// every translation file must have exactly the same texts and placeholders as English.
void main() {
  final dir = Directory('lib/l10n');
  final english = _read(File('${dir.path}/app_en.arb'));
  final englishKeys = english.keys.where((k) => !k.startsWith('@')).toSet();

  final others = dir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.arb') && !f.path.endsWith('app_en.arb'))
      .toList();

  test('there are translation files besides English', () {
    expect(others, isNotEmpty);
  });

  for (final file in others) {
    final name = file.uri.pathSegments.last;
    test('$name has every English text, and no extra ones', () {
      final keys = _read(file).keys.where((k) => !k.startsWith('@')).toSet();
      expect(englishKeys.difference(keys), isEmpty, reason: 'missing in $name');
      expect(keys.difference(englishKeys), isEmpty, reason: 'unknown keys in $name');
    });

    test('$name keeps every {placeholder} of English', () {
      final translation = _read(file);
      for (final key in englishKeys) {
        final wanted = _placeholders(english[key] as String);
        final found = _placeholders(translation[key] as String);
        expect(found, wanted, reason: '"$key" in $name');
      }
    });
  }
}

Map<String, dynamic> _read(File f) => jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;

Set<String> _placeholders(String text) => RegExp(r'\{(\w+)\}').allMatches(text).map((m) => m.group(1)!).toSet();
