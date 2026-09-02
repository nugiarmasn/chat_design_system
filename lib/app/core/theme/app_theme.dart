import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  // Primary Colors (Dari Tim)
  static const Color primaryBlue = Color(0xFF007AFF);
  static const Color primaryBlueLight = Color(0xFFE5F1FF);
  static const Color primaryPurple = Color(0xFFA5A6F6);
  static const Color deepPurple = Color(0xFF673AB7); // <-- TAMBAHKAN INI

  // --- ALIAS UNTUK KOMPONEN DEV 1 AGAR TIDAK ERROR ---
  static const Color primary = primaryBlue;
  static const Color background = Color(0xFFF7F7F9);
  static const Color border = Color(0xFFEEEEEE);

  // Neutral / Background Colors
  static const Color backgroundLight = Color(0xFFF7F7F9);
  static const Color backgroundDark = Color(0xFF1E1E1E);
  static const Color surfaceWhite = Colors.white;
  static const Color divider = Color(0xFFEEEEEE);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textTertiary = Color(0xFFAAAAAA);

  // Status Colors
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFF9500);
  static const Color error = Color(0xFFFF3B30);
}

class AppTypography {
  AppTypography._();

  static final String? fontFamily = GoogleFonts.inter().fontFamily;

  static final TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static final TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static final TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static final TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static final TextStyle bodySecondary = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static final TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static final TextStyle timeLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textTertiary,
  );
}

// --- ALIAS STYLE UNTUK KOMPONEN DEV 1 ---
class AppTextStyles {
  static TextStyle body = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static TextStyle heading = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
}

class AppSpacing {
  AppSpacing._();
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

extension DynamicThemeContext on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get appBackground => isDark ? const Color(0xFF121212) : AppColors.backgroundLight;
  Color get appSurface => isDark ? const Color(0xFF1E1E1E) : AppColors.surfaceWhite;
  Color get appTextPrimary => isDark ? const Color(0xFFF5F5F5) : AppColors.textPrimary;
  Color get appTextSecondary => isDark ? const Color(0xFFAAAAAA) : AppColors.textSecondary;
  Color get appDivider => isDark ? const Color(0xFF333333) : AppColors.divider;
}

extension DynamicTextStyle on TextStyle {
  TextStyle adapt(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      if (color == AppColors.textPrimary) return copyWith(color: const Color(0xFFF5F5F5));
      if (color == AppColors.textSecondary) return copyWith(color: const Color(0xFFAAAAAA));
      if (color == AppColors.textTertiary) return copyWith(color: const Color(0xFF777777));
    }
    return this;
  }
}

// --- SETUP THEMEDATA UNTUK GETX ---
class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryBlue,
      surface: AppColors.surfaceWhite,
      onSurface: AppColors.textPrimary,
      onSurfaceVariant: AppColors.textSecondary,
      outline: AppColors.divider,
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
    dividerColor: AppColors.divider,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryBlue,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
      onSurfaceVariant: Color(0xFFAAAAAA),
      outline: Color(0xFF333333),
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    dividerColor: const Color(0xFF333333),
  );
}