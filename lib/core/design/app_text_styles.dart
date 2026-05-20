import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lexa_pos/core/design/app_colors.dart';

/// Lexa POS typography — Inter only, fixed scale and weights.
abstract final class AppTextStyles {
  static const List<FontFeature> _tabularNums = [
    FontFeature.tabularFigures(),
  ];

  static TextStyle _inter({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
    double? letterSpacing,
    List<FontFeature>? fontFeatures,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.primary,
      letterSpacing: letterSpacing,
      fontFeatures: fontFeatures,
    );
  }

  /// 12px body — captions and helper text.
  static TextStyle get bodySmall => _inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );

  /// 13px compact labels.
  static TextStyle get caption => _inter(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.muted,
      );

  /// 14px default body copy.
  static TextStyle get body => _inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );

  /// 14px medium-weight labels.
  static TextStyle get label => _inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  /// 16px section headings.
  static TextStyle get heading => _inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );

  /// 20px screen titles.
  static TextStyle get title => _inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      );

  /// 24px prominent headings.
  static TextStyle get headline => _inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      );

  /// 32px hero numerals and dashboard KPIs.
  static TextStyle get display => _inter(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      );

  /// 16px monetary values — tabular nums, tight tracking.
  static TextStyle get price => _inter(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        fontFeatures: _tabularNums,
      );

  /// 24px large totals on receipts and checkout.
  static TextStyle get priceLarge => _inter(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        fontFeatures: _tabularNums,
      );

  /// 32px checkout total display.
  static TextStyle get priceDisplay => _inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        fontFeatures: _tabularNums,
      );
}
