import 'package:flutter/material.dart';

/// Lexa POS color palette — strict design tokens, no Material defaults.
abstract final class AppColors {
  /// Base text and primary actions.
  static const Color primary = Color(0xFF0F172A);

  /// Main application background.
  static const Color surface = Color(0xFFF8FAFC);

  /// Elevated card surfaces.
  static const Color card = Color(0xFFFFFFFF);

  /// Primary CTA and active states.
  static const Color accent = Color(0xFF6366F1);

  /// Pressed state for accent controls.
  static const Color accentDark = Color(0xFF4F46E5);

  /// Focus ring for inputs and interactive fields.
  static const Color accentFocusRing = Color(0xFF818CF8);

  /// Positive status and success actions.
  static const Color success = Color(0xFF10B981);

  /// Warning and caution states.
  static const Color warning = Color(0xFFF59E0B);

  /// Destructive actions and errors.
  static const Color danger = Color(0xFFEF4444);

  /// Default 1px borders (level-1 elevation).
  static const Color border = Color(0xFFE2E8F0);

  /// Stronger borders for sheets and level-2 cards.
  static const Color borderStrong = Color(0xFFCBD5E1);

  /// Secondary body and label text.
  static const Color muted = Color(0xFF64748B);

  /// Tertiary and placeholder text.
  static const Color subtle = Color(0xFF94A3B8);

  /// Tertiary button and secondary emphasis text.
  static const Color slate600 = Color(0xFF475569);

  /// Icon-only button background.
  static const Color iconBackground = Color(0xFFF1F5F9);

  /// Icon-only button icon color.
  static const Color iconForeground = Color(0xFF334155);

  /// Text on accent and danger filled buttons.
  static const Color onAccent = Color(0xFFFFFFFF);

  /// Dialog and modal scrim overlay.
  static const Color scrim = Color(0x66000000);

  /// Level-2 sheet backdrop tint.
  static const Color sheetOverlay = Color(0x0A000000);

  /// Success badge background (~10% opacity).
  static const Color successMuted = Color(0x1A10B981);

  /// Warning badge background (~10% opacity).
  static const Color warningMuted = Color(0x1AF59E0B);

  /// Danger badge background (~10% opacity).
  static const Color dangerMuted = Color(0x1AEF4444);

  /// Inactive badge background (~10% opacity).
  static const Color inactiveMuted = Color(0x1A64748B);
}
