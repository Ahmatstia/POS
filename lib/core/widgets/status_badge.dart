import 'package:flutter/material.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_radius.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';

/// Semantic status chip — always pairs color with visible label text.
enum StatusBadgeType {
  active,
  inactive,
  warning,
  danger,
}

/// Compact status indicator for stock, orders, and connectivity.
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    required this.type,
    this.showDot = true,
  });

  final String label;
  final StatusBadgeType type;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    final colors = _resolveColors(type);
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space12),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: colors.foreground,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSpacing.space8),
          ],
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              color: colors.foreground,
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeColors {
  const _BadgeColors({
    required this.background,
    required this.foreground,
  });

  final Color background;
  final Color foreground;
}

_BadgeColors _resolveColors(StatusBadgeType type) {
  return switch (type) {
    StatusBadgeType.active => const _BadgeColors(
        background: AppColors.successMuted,
        foreground: AppColors.success,
      ),
    StatusBadgeType.inactive => const _BadgeColors(
        background: AppColors.inactiveMuted,
        foreground: AppColors.muted,
      ),
    StatusBadgeType.warning => const _BadgeColors(
        background: AppColors.warningMuted,
        foreground: AppColors.warning,
      ),
    StatusBadgeType.danger => const _BadgeColors(
        background: AppColors.dangerMuted,
        foreground: AppColors.danger,
      ),
  };
}
