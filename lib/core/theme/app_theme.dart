import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary brand purple matching design specs (#7B2FF7)
  static const Color primary = Color(0xFF7B2FF7);
  static const Color primaryDark = Color(0xFF5E16D9);
  static const Color primaryLight = Color(0xFF9D61FF);

  // Accent background shape color (pale yellow-green #E8FA97)
  static const Color accentShape = Color(0xFFE8FA97);
  static const Color accentShapeDark = Color(0xFFD6F569);

  // Text colors
  static const Color textPrimary = Color(0xFF1F1A24);
  static const Color textSecondary = Color(0xFF756F80);
  static const Color textMuted = Color(0xFFA09AA8);

  // Background colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFF9F8FC);
  static const Color inputBackground = Color(0xFFE8FA97);

  // UI state colors
  static const Color dotActive = Color(0xFF7B2FF7);
  static const Color dotInactive = Color(0xFFE2DCED);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.background,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.outfit(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          letterSpacing: -0.5,
        ),
        headlineLarge: GoogleFonts.outfit(
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
          letterSpacing: -0.4,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: AppColors.textSecondary,
          height: 1.45,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.textSecondary,
          height: 1.4,
        ),
        labelLarge: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: GoogleFonts.outfit(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
