import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/language_controller.dart';

/// A dropdown with every language the app has, each shown in its own script
/// (English, العربية, Français, Русский, አማርኛ ...).
class LanguagePicker extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const LanguagePicker({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return DropdownButtonFormField<String>(
      key: const Key('language-picker'),
      initialValue: value,
      decoration: InputDecoration(labelText: t.language, prefixIcon: const Icon(Icons.language)),
      items: LanguageController.supportedLocales
          .map((l) => DropdownMenuItem(
                value: l.languageCode,
                child: Text(LanguageController.nameOf(l.languageCode)),
              ))
          .toList(),
      onChanged: (code) {
        if (code != null) onChanged(code);
      },
    );
  }
}
