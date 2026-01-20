import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.green,
    primaryColor: const Color(0xFF2E7D32),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF2E7D32),
      secondary: Color(0xFF4CAF50),
      tertiary: Color(0xFF81C784),
    ),
    scaffoldBackgroundColor: Colors.grey[50],
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF2E7D32),
      elevation: 2,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    fontFamily: 'Inter',
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.green,
    primaryColor: const Color(0xFF1B5E20),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF1B5E20),
      secondary: Color(0xFF388E3C),
      tertiary: Color(0xFF66BB6A),
    ),
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1B5E20),
      elevation: 2,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    fontFamily: 'Inter',
  );
}
