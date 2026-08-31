import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF0052CC);
  static const Color background = Color(0xFFF4F5F7);
  static const Color textPrimary = Color(0xFF172B4D);
  static const Color textSecondary = Color(0xFF6B778C);
  static const Color border = Color(0xFFDFE1E6);
  static const Color error = Color(0xFFFF5630);
}

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