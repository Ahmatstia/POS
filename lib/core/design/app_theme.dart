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
        onPrimary: AppColors.onAccent,
        secondary: AppColors.accent,
        onSecondary: AppColors.onAccent,
        surface: AppColors.surface,
        onSurface: AppColors.primary,
        error: AppColors.danger,
        onError: AppColors.onAccent,
      ),
      textTheme: TextTheme(
        bodySmall: AppTextStyles.bodySmall,
        bodyMedium: AppTextStyles.body,
        bodyLarge: AppTextStyles.body,
        labelLarge: AppTextStyles.label,
        titleMedium: AppTextStyles.heading,
        titleLarge: AppTextStyles.title,
        headlineMedium: AppTextStyles.headline,
        displaySmall: AppTextStyles.display,
      ),
      dividerColor: AppColors.border,
      splashColor: AppColors.accent.withValues(alpha: 0.08),
      highlightColor: AppColors.accent.withValues(alpha: 0.04),
    );
  }
}
