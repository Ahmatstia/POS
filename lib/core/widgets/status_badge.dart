import 'package:flutter/material.dart';
import '../design/app_colors.dart';
import '../design/app_spacing.dart';
import '../design/app_text_styles.dart';

enum BadgeStatus { active, inactive, warning, danger }

/// A status badge with 6px border radius.
class StatusBadge extends StatelessWidget {
  final String text;
  final BadgeStatus status;

  const StatusBadge({
    super.key,
    required this.text,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s8,
        vertical: AppSpacing.s4,
      ),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(6.0), // Strict 6px
      ),
      child: Text(
        text.toUpperCase(),
        style: AppTextStyles.label12.copyWith(
          color: _getTextColor(),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (status) {
      case BadgeStatus.active:
        return AppColors.success.withOpacity(0.1);
      case BadgeStatus.inactive:
        return AppColors.mutedText.withOpacity(0.1);
      case BadgeStatus.warning:
        return AppColors.warning.withOpacity(0.1);
      case BadgeStatus.danger:
        return AppColors.danger.withOpacity(0.1);
    }
  }

  Color _getTextColor() {
    switch (status) {
      case BadgeStatus.active:
        return AppColors.success;
      case BadgeStatus.inactive:
        return AppColors.mutedText;
      case BadgeStatus.warning:
        return const Color(0xFFD97706); // amber-600
      case BadgeStatus.danger:
        return AppColors.danger;
    }
  }
}
