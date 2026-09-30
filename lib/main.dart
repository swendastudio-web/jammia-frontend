import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/app_localizations.dart';
import 'screens/language_screen.dart';
import 'screens/login_screen.dart';
import 'screens/rooms_screen.dart';
import 'services/app_services.dart';
import 'services/language_controller.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(JamiaApp(services: AppServices.create()));
}

/// The root of the JAMIA app.
/// First start on a phone: choose a language. Then "Log in" or "My rooms" depending on the session.
class JamiaApp extends StatefulWidget {
  final AppServices services;

  const JamiaApp({super.key, required this.services});

  @override
  State<JamiaApp> createState() => _JamiaAppState();
}

class _JamiaAppState extends State<JamiaApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  bool _starting = true;
  bool _wasLoggedIn = false;

  @override
  void initState() {
    super.initState();
    widget.services.session.addListener(_onSessionChanged);
    widget.services.language.addListener(_onLanguageChanged);
    _restore();
  }

  @override
  void dispose() {
    widget.services.session.removeListener(_onSessionChanged);
    widget.services.language.removeListener(_onLanguageChanged);
    super.dispose();
  }

  // At start: which language, and were we signed in last time?
  Future<void> _restore() async {
    await widget.services.language.load();
    await widget.services.auth.restoreSession();
    if (mounted) setState(() => _starting = false);
  }

  void _onSessionChanged() {
    final session = widget.services.session;
    final loggedIn = session.isLoggedIn;
    // Logged out (or session expired) from any screen: close all screens and show "Log in".
    if (_wasLoggedIn && !loggedIn) {
      _navigatorKey.currentState?.popUntil((route) => route.isFirst);
    }
    _wasLoggedIn = loggedIn;
    // The account remembers the language: use it on this phone too (e.g. after logging in on a new phone).
    final accountLanguage = session.user?.preferredLanguage;
    if (LanguageController.isSupported(accountLanguage)) {
      widget.services.language.setLanguage(accountLanguage!);
    }
    setState(() {});
  }

  void _onLanguageChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final services = widget.services;
    final Widget home;
    if (_starting) {
      home = const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else if (!services.language.hasChosen) {
      home = LanguageScreen(services: services);
    } else if (services.session.isLoggedIn) {
      home = RoomsScreen(services: services);
    } else {
      home = LoginScreen(services: services);
    }

    return MaterialApp(
      title: 'JAMIA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.grayscale,
      navigatorKey: _navigatorKey,
      // Languages: our own texts + Flutter's built-in texts (date picker, etc.).
      // Arabic automatically switches the layout to right-to-left.
      locale: services.language.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: home,
    );
  }
}
