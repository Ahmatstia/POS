import 'package:flutter/material.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';

enum AppButtonVariant { primary, secondary, tertiary, danger, iconOnly }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.isLoading = false,
  });

  const AppButton.primary({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  }) : variant = AppButtonVariant.primary;

  const AppButton.secondary({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.tertiary({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  }) : variant = AppButtonVariant.tertiary;

  const AppButton.danger({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  }) : variant = AppButtonVariant.danger;

  const AppButton.iconOnly({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isLoading = false,
  })  : text = '',
        variant = AppButtonVariant.iconOnly;

  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (variant == AppButtonVariant.iconOnly) {
      return SizedBox(
        width: AppSpacing.s40,
        height: AppSpacing.s40,
        child: Material(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.s8),
          child: InkWell(
            onTap: isLoading ? null : onPressed,
            borderRadius: BorderRadius.circular(AppSpacing.s8),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    )
                  : Icon(icon, color: AppColors.primary, size: 20),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: AppSpacing.s48,
      child: Material(
        color: _getBgColor(),
        shape: _getBorder(),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(_getTextColor()),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          Icon(icon, color: _getTextColor(), size: 18),
                          const SizedBox(width: AppSpacing.s8),
                        ],
                        Flexible(
                          child: Text(
                            text,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.label14.copyWith(
                              color: _getTextColor(),
                              decoration: variant == AppButtonVariant.tertiary
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getBgColor() {
    if (onPressed == null && variant != AppButtonVariant.tertiary) {
      return AppColors.border; // Disabled state
    }
    switch (variant) {
      case AppButtonVariant.primary:
        return AppColors.accent;
      case AppButtonVariant.secondary:
        return AppColors.card;
      case AppButtonVariant.tertiary:
        return Colors.transparent;
      case AppButtonVariant.danger:
        return AppColors.danger;
      case AppButtonVariant.iconOnly:
        return AppColors.surface;
    }
  }

  Color _getTextColor() {
    if (onPressed == null) return AppColors.subtleText;
    switch (variant) {
      case AppButtonVariant.primary:
      case AppButtonVariant.danger:
        return AppColors.card; // White
      case AppButtonVariant.secondary:
        return AppColors.accent;
      case AppButtonVariant.tertiary:
        return AppColors.mutedText;
      case AppButtonVariant.iconOnly:
        return AppColors.primary;
    }
  }

  RoundedRectangleBorder _getBorder() {
    if (variant == AppButtonVariant.secondary) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.accent, width: 1),
      );
    }
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    );
  }
}
