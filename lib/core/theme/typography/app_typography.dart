import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';

abstract class AppTypography {
  static TextStyle _base({
    required double fontSize,
    required FontWeight fontWeight,
    double height = 1,
    double letterSpacing = 0,
    Color? color,
  }) {
    return GoogleFonts.almarai(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  static TextStyle get bold36 =>
      _base(fontSize: 36, fontWeight: FontWeight.w700);

  static TextStyle get bold28 =>
      _base(fontSize: 28, fontWeight: FontWeight.w700);

  static TextStyle get extraBold24 =>
      _base(fontSize: 24, fontWeight: FontWeight.w800);

  static TextStyle get semiBold22 =>
      _base(fontSize: 22, fontWeight: FontWeight.w600);

  static TextStyle get semiBold20 =>
      _base(fontSize: 20, fontWeight: FontWeight.w600);

  static TextStyle get semiBold18 =>
      _base(fontSize: 18, fontWeight: FontWeight.w600);

  static TextStyle get semiBold16 =>
      _base(fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle get semiBold14 =>
      _base(fontSize: 14, fontWeight: FontWeight.w600);

  static TextStyle get regular14 => _base(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryLight,
  );

  static TextStyle get regular16 => _base(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );

  static TextStyle get regular12 =>
      _base(fontSize: 12, fontWeight: FontWeight.w400);
      static TextStyle get regular15 =>
      _base(fontSize: 14, fontWeight: FontWeight.w400);

  static TextStyle get bold16 => _base(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static TextStyle get medium12 => _base(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle get medium14 => _base(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  static TextStyle get medium16 => _base(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  static TextStyle get regular13 =>
      _base(fontSize: 12, fontWeight: FontWeight.w500);
}
