import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Defines the typography scale and styles for the application.
/// Uses 'Inter' family.
/// Scale: 12 / 13 / 14 / 16 / 20 / 24 / 32px
/// Weights: 400 (body), 500 (label), 600 (heading), 700 (numeral/price only)
class AppTextStyles {
  AppTextStyles._();

  static const String _fontFamily = 'Inter';

  // 12px
  static const TextStyle body12 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
    decoration: TextDecoration.none,
  );
  
  static const TextStyle label12 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    decoration: TextDecoration.none,
  );

  // 13px
  static const TextStyle body13 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
    decoration: TextDecoration.none,
  );

  static const TextStyle label13 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    decoration: TextDecoration.none,
  );

  // 14px
  static const TextStyle body14 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
    decoration: TextDecoration.none,
  );

  static const TextStyle label14 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    decoration: TextDecoration.none,
  );

  // 16px
  static const TextStyle body16 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
    decoration: TextDecoration.none,
  );

  static const TextStyle label16 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    decoration: TextDecoration.none,
  );

  static const TextStyle heading16 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    decoration: TextDecoration.none,
  );

  // 20px
  static const TextStyle heading20 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    decoration: TextDecoration.none,
  );

  // 24px
  static const TextStyle heading24 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    decoration: TextDecoration.none,
  );

  // 32px
  static const TextStyle heading32 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    decoration: TextDecoration.none,
  );

  /// Always Inter 700, tabular-nums, letter-spacing: -0.5px
  /// For monetary values
  static TextStyle price(double fontSize, {Color color = AppColors.primary}) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      color: color,
      decoration: TextDecoration.none,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }
}
