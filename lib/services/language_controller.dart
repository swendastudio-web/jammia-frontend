import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../l10n/app_localizations.dart';
import 'settings_storage.dart';

/// Remembers the app language and switches the whole app when it changes.
/// The list of languages comes from the translation files in lib/l10n:
/// add app_xx.arb and the new language appears everywhere automatically.
class LanguageController extends ChangeNotifier {
  final SettingsStorage _storage;
  Locale? _chosen;

  LanguageController(this._storage);

  /// English first, then every other language in the translation folder (new files appear automatically).
  static List<Locale> get supportedLocales => [
        const Locale('en'),
        ...AppLocalizations.supportedLocales.where((l) => l.languageCode != 'en'),
      ];

  static bool isSupported(String? code) => supportedLocales.any((l) => l.languageCode == code);

  /// The language's own name, e.g. "العربية" for "ar".
  static String nameOf(String code) => lookupAppLocalizations(Locale(code)).languageName;

  /// True once the user has picked a language on this phone.
  bool get hasChosen => _chosen != null;

  /// The chosen language, or the phone's language if supported, otherwise English.
  Locale get locale {
    if (_chosen != null) return _chosen!;
    final device = PlatformDispatcher.instance.locale.languageCode;
    return Locale(isSupported(device) ? device : 'en');
  }

  Future<void> load() async {
    final saved = await _storage.readLanguage();
    if (isSupported(saved)) _chosen = Locale(saved!);
  }

  Future<void> setLanguage(String code) async {
    if (!isSupported(code) || (_chosen?.languageCode == code)) return;
    _chosen = Locale(code);
    await _storage.writeLanguage(code);
    notifyListeners();
  }
}
