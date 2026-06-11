import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get displayLarge => GoogleFonts.notoSans(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryText,
      );

  static TextStyle get headlineLarge => GoogleFonts.notoSans(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryText,
      );

  static TextStyle get headlineMedium => GoogleFonts.notoSans(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryText,
      );

  static TextStyle get titleLarge => GoogleFonts.notoSans(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryText,
      );

  static TextStyle get titleMedium => GoogleFonts.notoSans(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryText,
      );

  static TextStyle get bodyLarge => GoogleFonts.notoSans(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: AppColors.primaryText,
      );

  static TextStyle get bodyMedium => GoogleFonts.notoSans(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: AppColors.primaryText,
      );

  static TextStyle get bodySmall => GoogleFonts.notoSans(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: AppColors.primaryText,
      );

  static TextStyle get caption => GoogleFonts.notoSans(
        fontSize: 11.0,
        fontWeight: FontWeight.w500,
        color: AppColors.secondaryText,
      );

  static TextStyle get button => GoogleFonts.notoSans(
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
        color: AppColors.surface,
      );
}
