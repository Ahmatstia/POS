import 'package:flutter/material.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';

/// Branded full-area error state with retry action and error code.
/// Never shows a raw exception message — always uses typed failure codes.
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
          padding: const EdgeInsets.all(AppSpacing.s32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: AppColors.danger,
              ),
              const SizedBox(height: AppSpacing.s16),
              Text(
                title,
                style: AppTextStyles.heading20,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.s8),
              Text(
                message,
                style: AppTextStyles.body14.copyWith(color: AppColors.mutedText),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.s8),
              Text(
                'Error $errorCode',
                style: AppTextStyles.body12.copyWith(color: AppColors.subtleText),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: AppSpacing.s24),
                SizedBox(
                  width: double.infinity,
                  child: AppButton.primary(
                    text: 'Try again',
                    onPressed: onRetry,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
