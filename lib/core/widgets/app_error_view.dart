import 'package:flutter/material.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';

/// Branded full-area error state with retry action and error code.
class AppErrorView extends StatelessWidget {
  const AppErrorView({
    super.key,
    required this.title,
    required this.message,
    required this.errorCode,
    this.onRetry,
  });

  final String title;
  final String message;
  final String errorCode;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
                color: AppColors.danger,
              ),
              const SizedBox(height: AppSpacing.space16),
              Text(title, style: AppTextStyles.title, textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.space8),
              Text(
                message,
                style: AppTextStyles.body.copyWith(color: AppColors.muted),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.space8),
              Text(
                'Error $errorCode',
                style: AppTextStyles.caption,
              ),
              if (onRetry != null) ...[
                const SizedBox(height: AppSpacing.space24),
                AppButton(
                  label: 'Try again',
                  onPressed: onRetry,
                  isExpanded: true,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
