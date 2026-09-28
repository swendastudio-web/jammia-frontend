import 'package:flutter/material.dart';

/// Development theme: grayscale only (white, black and grays).
/// The final JAMIA brand colors will replace this later.
class AppTheme {
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFEEEEEE);
  static const Color gray = Color(0xFF9E9E9E);
  static const Color darkGray = Color(0xFF424242);
  static const Color black = Color(0xFF000000);

  static final ThemeData grayscale = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: white,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: black,
      onPrimary: white,
      secondary: darkGray,
      onSecondary: white,
      error: black,
      onError: white,
      surface: white,
      onSurface: black,
      surfaceContainerHighest: lightGray,
      onSurfaceVariant: darkGray,
      outline: gray,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: white,
      foregroundColor: black,
      elevation: 0,
    ),
  );
}
