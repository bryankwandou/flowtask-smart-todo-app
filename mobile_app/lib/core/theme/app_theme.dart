import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flowtask/core/theme/colors.dart';

enum ThemePalette { indigo, emerald, slate }

class AppTheme {
  static ThemeData getTheme(ThemePalette palette) {
    final colors = _getPaletteColors(palette);
    
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        onPrimary: Colors.white,
        secondary: colors.secondary,
        onSecondary: Colors.white,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        background: AppColors.background,
        onBackground: AppColors.textPrimary,
        error: AppColors.error,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.background,
      
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.outfit(fontSize: 56, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: -1.5),
        displayMedium: GoogleFonts.outfit(fontSize: 40, fontWeight: FontWeight.bold, color: AppColors.textPrimary, letterSpacing: -1.0),
        displaySmall: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary, letterSpacing: -0.5),
        headlineMedium: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        titleLarge: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        labelLarge: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        bodyLarge: GoogleFonts.outfit(fontSize: 16, color: AppColors.textPrimary, height: 1.5),
        bodyMedium: GoogleFonts.outfit(fontSize: 14, color: AppColors.textSecondary, height: 1.5),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.03),
        hintStyle: const TextStyle(color: AppColors.textMuted),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
      ),

      cardTheme: CardThemeData(
        color: Colors.white.withOpacity(0.02),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(color: Colors.white.withOpacity(0.08), width: 1),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold),
          elevation: 0,
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.background,
        elevation: 0,
        selectedItemColor: colors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  static _PaletteColors _getPaletteColors(ThemePalette palette) {
    switch (palette) {
      case ThemePalette.indigo:
        return const _PaletteColors(primary: Color(0xFF6366F1), secondary: Color(0xFF10B981));
      case ThemePalette.emerald:
        return const _PaletteColors(primary: Color(0xFF10B981), secondary: Color(0xFF6366F1));
      case ThemePalette.slate:
        return const _PaletteColors(primary: Color(0xFF94A3B8), secondary: Color(0xFF6366F1));
    }
  }
}

class _PaletteColors {
  final Color primary;
  final Color secondary;
  const _PaletteColors({required this.primary, required this.secondary});
}
