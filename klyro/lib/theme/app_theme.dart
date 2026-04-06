import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFFFF8A00); // The vivid orange
  static const Color darkGreen = Color(0xFFD97200); // Darker shade of orange
  static const Color backgroundLight = Color(
    0xFFFFF9F2,
  ); // Very light greyish-orange background
  static const Color navBarDark = Color(
    0xFF232522,
  ); // Almost black for bottom nav
  static const Color textDark = Color(0xFF1F2937); // Dark gray for headers
  static const Color textSecondary = Color(
    0xFF6B7280,
  ); // Lighter gray for subtext
  static const Color cardBackground = Colors.white; // White for cards

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
        secondary: primaryGreen,
        surface: cardBackground,
        onPrimary:
            Colors.black, // Text on primary button is often dark in the design
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundLight,
        elevation: 0,
        iconTheme: IconThemeData(color: textDark),
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: textDark, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: textDark, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: textDark, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: textDark, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: textDark),
        bodyMedium: TextStyle(color: textSecondary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
