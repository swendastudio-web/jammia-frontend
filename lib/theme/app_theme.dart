import 'package:flutter/material.dart';

/// Development theme: grayscale only (white, light gray, gray, dark gray, black).
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
      centerTitle: false,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: gray)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: black, width: 2)),
      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: darkGray)),
      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: black, width: 2)),
      errorStyle: TextStyle(color: darkGray),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: black,
        foregroundColor: white,
        minimumSize: const Size.fromHeight(48),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: black,
        side: const BorderSide(color: gray),
        minimumSize: const Size.fromHeight(48),
      ),
    ),
    cardTheme: const CardThemeData(
      color: white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: lightGray),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    dividerTheme: const DividerThemeData(color: lightGray),
    snackBarTheme: const SnackBarThemeData(backgroundColor: darkGray, contentTextStyle: TextStyle(color: white)),
  );
}
