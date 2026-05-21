import 'package:flutter/material.dart';

/// Defines the core color palette for the Lexa POS application.
/// Strictly adheres to the defined design system.
class AppColors {
  AppColors._();

  /// #0F172A (slate-900) — base text, primary actions
  static const Color primary = Color(0xFF0F172A);
  
  /// #F8FAFC (slate-50) — main background
  static const Color surface = Color(0xFFF8FAFC);
  
  /// #FFFFFF — card surfaces
  static const Color card = Color(0xFFFFFFFF);
  
  /// #6366F1 (indigo-500) — primary CTA, active states
  static const Color accent = Color(0xFF6366F1);
  
  /// #4F46E5 (indigo-600) — pressed state
  static const Color accentDark = Color(0xFF4F46E5);
  
  /// #10B981 (emerald-500) — success states
  static const Color success = Color(0xFF10B981);
  
  /// #F59E0B (amber-500) — warning states
  static const Color warning = Color(0xFFF59E0B);
  
  /// #EF4444 (red-500) — danger/error states
  static const Color danger = Color(0xFFEF4444);
  
  /// #E2E8F0 (slate-200) — 1px only, never thicker
  static const Color border = Color(0xFFE2E8F0);
  
  /// #64748B (slate-500) — muted text
  static const Color mutedText = Color(0xFF64748B);
  
  /// #94A3B8 (slate-400) — subtle text
  static const Color subtleText = Color(0xFF94A3B8);

  /// #818CF8 (indigo-400) — focus ring on input fields (2px)
  static const Color accentFocusRing = Color(0xFF818CF8);

  /// Helper for scrim backdrop Color(0x66000000)
  static const Color scrim = Color(0x66000000);
}
