import 'package:flutter/material.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';

/// Branded empty state with illustration placeholder and optional CTA.
class AppEmptyView extends StatelessWidget {
  const AppEmptyView({
    super.key,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
    this.icon = Icons.inbox_outlined,
  });

  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.iconBackground,
                borderRadius: BorderRadius.circular(AppSpacing.space16),
              ),
              child: Icon(icon, size: 40, color: AppColors.muted),
            ),
            const SizedBox(height: AppSpacing.space24),
            Text(title, style: AppTextStyles.title),
            const SizedBox(height: AppSpacing.space8),
            Text(
              description,
              style: AppTextStyles.body.copyWith(color: AppColors.muted),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.space24),
              AppButton(
                label: actionLabel!,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
