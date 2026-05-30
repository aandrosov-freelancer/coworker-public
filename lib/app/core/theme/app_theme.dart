import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../values/colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryGreen,
    scaffoldBackgroundColor: AppColors.white,
    fontFamily: GoogleFonts.inter().fontFamily,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: AppColors.headingDark,
        letterSpacing: -0.72,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        letterSpacing: -0.24,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.bodyText,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.bodyText,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.headingDark,
      ),
    ),
  );
}
