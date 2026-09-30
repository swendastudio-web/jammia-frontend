import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/app_services.dart';
import '../services/language_controller.dart';
import '../theme/app_theme.dart';

/// Shown the first time the app opens on a phone: pick the app language.
class LanguageScreen extends StatefulWidget {
  final AppServices services;

  const LanguageScreen({super.key, required this.services});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  // Starts with the phone's language if JAMIA has it, otherwise English.
  late String _selected = widget.services.language.locale.languageCode;

  @override
  Widget build(BuildContext context) {
    // Show this screen in the language being selected, so the user sees the result at once.
    final t = lookupAppLocalizations(Locale(_selected));
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Text('JAMIA', textAlign: TextAlign.center, style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 24),
              Text(t.chooseLanguageTitle, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: LanguageController.supportedLocales.map((l) {
                    final code = l.languageCode;
                    final selected = code == _selected;
                    return Card(
                      color: selected ? AppTheme.lightGray : null,
                      child: ListTile(
                        key: Key('language-$code'),
                        title: Text(LanguageController.nameOf(code), style: const TextStyle(fontSize: 18)),
                        trailing: selected ? const Icon(Icons.check_circle) : const Icon(Icons.circle_outlined),
                        onTap: () => setState(() => _selected = code),
                      ),
                    );
                  }).toList(),
                ),
              ),
              FilledButton(
                key: const Key('language-continue'),
                onPressed: () => widget.services.language.setLanguage(_selected),
                child: Text(t.continueButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
