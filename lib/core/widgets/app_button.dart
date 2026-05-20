import 'package:flutter/material.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_radius.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/widgets/shimmer_box.dart';

/// Visual hierarchy variants for [AppButton].
enum AppButtonVariant {
  primary,
  secondary,
  tertiary,
  danger,
  icon,
}

/// Lexa POS button — five variants, 48px standard height, no spinners.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    this.label,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.semanticsLabel,
    this.isLoading = false,
    this.isExpanded = false,
  }) : assert(
          variant != AppButtonVariant.icon || icon != null,
          'Icon variant requires an icon.',
        ),
        assert(
          variant == AppButtonVariant.icon || label != null,
          'Non-icon variants require a label.',
        );

  final VoidCallback? onPressed;
  final String? label;
  final AppButtonVariant variant;
  final IconData? icon;
  final String? semanticsLabel;
  final bool isLoading;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    if (variant == AppButtonVariant.icon) {
      return _IconButtonContent(
        icon: icon!,
        semanticsLabel: semanticsLabel ?? label ?? 'Action',
        onPressed: isLoading ? null : onPressed,
        isLoading: isLoading,
      );
    }

    return _TextButtonContent(
      label: label!,
      variant: variant,
      icon: icon,
      onPressed: isLoading ? null : onPressed,
      isLoading: isLoading,
      isExpanded: isExpanded,
    );
  }
}

class _TextButtonContent extends StatelessWidget {
  const _TextButtonContent({
    required this.label,
    required this.variant,
    required this.onPressed,
    required this.isLoading,
    required this.isExpanded,
    this.icon,
  });

  final String label;
  final AppButtonVariant variant;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final style = _ButtonStyleResolver.resolve(variant);

    return SizedBox(
      width: isExpanded ? double.infinity : null,
      height: AppSpacing.space48,
      child: Semantics(
        button: true,
        label: label,
        enabled: onPressed != null && !isLoading,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(AppRadius.button),
            child: Ink(
              decoration: BoxDecoration(
                color: style.backgroundColor,
                borderRadius: BorderRadius.circular(AppRadius.button),
                border: style.border,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space20,
                ),
                child: Center(
                  child: isLoading
                      ? const ShimmerBox(
                          width: 80,
                          height: AppSpacing.space12,
                          borderRadius: AppRadius.chip,
                        )
                      : _LabelRow(
                          label: label,
                          icon: icon,
                          foregroundColor: style.foregroundColor,
                          showUnderline: style.showUnderline,
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LabelRow extends StatelessWidget {
  const _LabelRow({
    required this.label,
    required this.foregroundColor,
    required this.showUnderline,
    this.icon,
  });

  final String label;
  final Color foregroundColor;
  final bool showUnderline;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyles.label.copyWith(
      color: foregroundColor,
      decoration: showUnderline ? TextDecoration.underline : null,
      decorationColor: foregroundColor,
    );

    if (icon == null) {
      return Text(label, style: textStyle);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: foregroundColor),
        const SizedBox(width: AppSpacing.space8),
        Text(label, style: textStyle),
      ],
    );
  }
}

class _IconButtonContent extends StatelessWidget {
  const _IconButtonContent({
    required this.icon,
    required this.semanticsLabel,
    required this.onPressed,
    required this.isLoading,
  });

  final IconData icon;
  final String semanticsLabel;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticsLabel,
      enabled: onPressed != null && !isLoading,
      child: Material(
        color: AppColors.iconBackground,
        borderRadius: BorderRadius.circular(AppRadius.icon),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppRadius.icon),
          child: SizedBox(
            width: 40,
            height: 40,
            child: Center(
              child: isLoading
                  ? const ShimmerBox(
                      width: 20,
                      height: 20,
                      borderRadius: AppRadius.icon,
                    )
                  : Icon(
                      icon,
                      size: 20,
                      color: AppColors.iconForeground,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ResolvedButtonStyle {
  const _ResolvedButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    this.border,
    this.showUnderline = false,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final Border? border;
  final bool showUnderline;
}

class _ButtonStyleResolver {
  static _ResolvedButtonStyle resolve(AppButtonVariant variant) {
    return switch (variant) {
      AppButtonVariant.primary => const _ResolvedButtonStyle(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.onAccent,
        ),
      AppButtonVariant.secondary => const _ResolvedButtonStyle(
          backgroundColor: AppColors.card,
          foregroundColor: AppColors.accent,
          border: Border.fromBorderSide(
            BorderSide(color: AppColors.accent, width: 1),
          ),
        ),
      AppButtonVariant.tertiary => const _ResolvedButtonStyle(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.slate600,
          showUnderline: true,
        ),
      AppButtonVariant.danger => const _ResolvedButtonStyle(
          backgroundColor: AppColors.danger,
          foregroundColor: AppColors.onAccent,
        ),
      AppButtonVariant.icon => const _ResolvedButtonStyle(
          backgroundColor: AppColors.iconBackground,
          foregroundColor: AppColors.iconForeground,
        ),
    };
  }
}
