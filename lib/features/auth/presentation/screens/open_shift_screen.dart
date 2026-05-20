import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';
import 'package:lexa_pos/core/widgets/app_card.dart';
import 'package:lexa_pos/features/auth/presentation/providers/auth_providers.dart';
import 'package:lexa_pos/features/auth/presentation/widgets/role_badge.dart';

/// Prompts cashier to open a shift before POS access.
class OpenShiftScreen extends ConsumerWidget {
  const OpenShiftScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authNotifierProvider).valueOrNull;
    final isLoading = ref.watch(authNotifierProvider).isLoading;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: AppCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (session != null) RoleBadge(role: session.user.role),
                const SizedBox(height: AppSpacing.space16),
                Text('Open shift', style: AppTextStyles.title),
                const SizedBox(height: AppSpacing.space8),
                Text(
                  'Start your register shift before processing sales on this terminal.',
                  style: AppTextStyles.body.copyWith(color: AppColors.muted),
                ),
                const SizedBox(height: AppSpacing.space32),
                AppButton(
                  label: 'Open shift',
                  onPressed: isLoading
                      ? null
                      : () => ref.read(authNotifierProvider.notifier).openShift(),
                  isLoading: isLoading,
                  isExpanded: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
