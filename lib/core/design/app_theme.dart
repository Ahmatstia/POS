import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';

/// Builds the Lexa POS [ThemeData] from design tokens.
abstract final class AppTheme {
  /// Locks the app to landscape tablet orientations.
  static Future<void> configureSystemUi() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.surface,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  /// Material theme using Lexa tokens — no default Material blue.
  static ThemeData get material {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.surface,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accent,
        onPrimary: AppColors.card, // White text on accent
        secondary: AppColors.accent,
        onSecondary: AppColors.card,
        surface: AppColors.surface,
        onSurface: AppColors.primary,
        error: AppColors.danger,
        onError: AppColors.card,
      ),
      textTheme: const TextTheme(
        bodySmall: AppTextStyles.body12,
        bodyMedium: AppTextStyles.body14,
        bodyLarge: AppTextStyles.body16,
        labelLarge: AppTextStyles.label14,
        titleMedium: AppTextStyles.heading16,
        titleLarge: AppTextStyles.heading20,
        headlineMedium: AppTextStyles.heading24,
        displaySmall: AppTextStyles.heading32,
      ),
      dividerColor: AppColors.border,
      splashColor: AppColors.accent.withValues(alpha: 0.08),
      highlightColor: AppColors.accent.withValues(alpha: 0.04),
    );
  }
}
