import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF0B0B0B);
  static const Color primary = Color(0xFF7F5AF0);
  static const Color accent = Color(0xFF00E5FF);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFAAAAAA);

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: background,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: accent,
      surface: background,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textPrimary, fontFamily: 'Poppins'),
      bodyMedium: TextStyle(color: textSecondary, fontFamily: 'Poppins'),
    ),
    iconTheme: const IconThemeData(color: textPrimary),
  );

  static BoxDecoration glassDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Colors.white.withOpacity(0.1)),
    boxShadow: [
      BoxShadow(
        color: primary.withOpacity(0.2),
        blurRadius: 20,
        spreadRadius: 2,
      )
    ],
  );
}
