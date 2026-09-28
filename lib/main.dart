import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const JamiaApp());
}

/// The root of the JAMIA app: sets the theme and the first screen.
class JamiaApp extends StatelessWidget {
  const JamiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JAMIA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.grayscale,
      home: const HomeScreen(),
    );
  }
}
