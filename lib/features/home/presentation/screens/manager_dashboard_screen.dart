import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';
import 'package:lexa_pos/router/app_router.dart';

/// Manager-only placeholder — protected by role route guard.
class ManagerDashboardScreen extends StatelessWidget {
  const ManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        foregroundColor: AppColors.primary,
        elevation: 0,
        title: Text('Manager overview', style: AppTextStyles.heading),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.space32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard module coming in Module 4.',
              style: AppTextStyles.body.copyWith(color: AppColors.muted),
            ),
            const SizedBox(height: AppSpacing.space24),
            AppButton(
              label: 'Back to POS',
              variant: AppButtonVariant.secondary,
              onPressed: () => context.go(AppRoutes.home),
            ),
          ],
        ),
      ),
    );
  }
}
