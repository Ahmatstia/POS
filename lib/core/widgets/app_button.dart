import 'package:flutter/material.dart';
import '../design/app_colors.dart';
import '../design/app_spacing.dart';
import '../design/app_text_styles.dart';

enum AppButtonVariant { primary, secondary, tertiary, danger, iconOnly }

/// A custom button component that adheres strictly to the design system.
/// Button Hierarchy:
/// Primary   : filled indigo-500, white text, 48px height
/// Secondary : white bg, 1px indigo border, indigo text
/// Tertiary  : transparent bg, no border, slate-600 text, underline on hover
/// Danger    : filled red-500, white text
/// Icon-only : 40x40, border-radius 8px, slate-100 bg, slate-700 icon
class AppButton extends StatefulWidget {
  final AppButtonVariant variant;
  final String? text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isLoading;

  const AppButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  })  : variant = AppButtonVariant.primary,
        icon = null;

  const AppButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  })  : variant = AppButtonVariant.secondary,
        icon = null;

  const AppButton.tertiary({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  })  : variant = AppButtonVariant.tertiary,
        icon = null;

  const AppButton.danger({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  })  : variant = AppButtonVariant.danger,
        icon = null;

  const AppButton.icon({
    super.key,
    required this.icon,
    this.onPressed,
    this.isLoading = false,
  })  : variant = AppButtonVariant.iconOnly,
        text = null;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    if (widget.variant == AppButtonVariant.iconOnly) {
      return _buildIconButton();
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: SizedBox(
        height: AppSpacing.s48,
        child: ElevatedButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          style: _getButtonStyle(),
          child: _buildChild(),
        ),
      ),
    );
  }

  Widget _buildIconButton() {
    return SizedBox(
      width: AppSpacing.s40,
      height: AppSpacing.s40,
      child: Material(
        color: const Color(0xFFF1F5F9), // slate-100
        borderRadius: BorderRadius.circular(AppSpacing.s8),
        child: InkWell(
          onTap: widget.isLoading ? null : widget.onPressed,
          borderRadius: BorderRadius.circular(AppSpacing.s8),
          child: Center(
            child: widget.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  )
                : Icon(
                    widget.icon,
                    color: const Color(0xFF334155), // slate-700
                    size: 20,
                  ),
          ),
        ),
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    final bool isDisabled = widget.onPressed == null || widget.isLoading;

    switch (widget.variant) {
      case AppButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.card,
          disabledBackgroundColor: AppColors.accent.withOpacity(0.5),
          disabledForegroundColor: AppColors.card.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // strict 10px
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
        );
      case AppButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.card,
          foregroundColor: AppColors.accent,
          disabledBackgroundColor: AppColors.card,
          disabledForegroundColor: AppColors.accent.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: isDisabled ? AppColors.accent.withOpacity(0.5) : AppColors.accent,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
        );
      case AppButtonVariant.tertiary:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.mutedText,
          disabledForegroundColor: AppColors.mutedText.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered) || _isHovered) {
              return Colors.transparent;
            }
            return null;
          }),
        );
      case AppButtonVariant.danger:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.danger,
          foregroundColor: AppColors.card,
          disabledBackgroundColor: AppColors.danger.withOpacity(0.5),
          disabledForegroundColor: AppColors.card.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
        );
      case AppButtonVariant.iconOnly:
        throw UnimplementedError(); // Handled separately
    }
  }

  Widget _buildChild() {
    if (widget.isLoading) {
      final color = widget.variant == AppButtonVariant.primary || widget.variant == AppButtonVariant.danger
          ? AppColors.card
          : AppColors.accent;
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      );
    }

    return Text(
      widget.text!,
      style: AppTextStyles.label14.copyWith(
        decoration: (widget.variant == AppButtonVariant.tertiary && _isHovered)
            ? TextDecoration.underline
            : TextDecoration.none,
      ),
    );
  }
}
