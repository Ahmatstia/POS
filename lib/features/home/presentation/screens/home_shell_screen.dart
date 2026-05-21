import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';
import 'package:lexa_pos/features/auth/domain/entities/user_role.dart';
import 'package:lexa_pos/features/auth/presentation/providers/auth_providers.dart';
import 'package:lexa_pos/features/pos/presentation/screens/pos_screen.dart';
import 'package:lexa_pos/router/app_router.dart';

/// Post-auth shell with navigation rail — POS module placeholder.
class HomeShellScreen extends ConsumerWidget {
  const HomeShellScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authNotifierProvider).valueOrNull;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Row(
        children: [
          _NavRail(
            role: session?.user.role,
            onLogout: () async {
              await ref.read(authNotifierProvider.notifier).logout();
            },
            onManager: session?.user.role.isManagerOrAbove == true
                ? () => context.go(AppRoutes.manager)
                : null,
          ),
          const Expanded(
            child: PosScreen(),
          ),
        ],
      ),
    );
  }
}

class _NavRail extends StatelessWidget {
  const _NavRail({
    required this.role,
    required this.onLogout,
    this.onManager,
  });

  final UserRole? role;
  final VoidCallback onLogout;
  final VoidCallback? onManager;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(right: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.s24),
          const Icon(Icons.point_of_sale, color: AppColors.accent, size: 28),
          const SizedBox(height: AppSpacing.s32),
          const _RailItem(icon: Icons.grid_view, label: 'POS', isActive: true),
          if (onManager != null)
            _RailItem(
              icon: Icons.insights_outlined,
              label: 'Manager',
              onTap: onManager,
            ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.s16),
            child: AppButton.tertiary(
              text: 'Out',
              onPressed: onLogout,
            ),
          ),
        ],
      ),
    );
  }
}

class _RailItem extends StatelessWidget {
  const _RailItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      selected: isActive,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.s12),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: isActive ? AppColors.accent : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isActive ? AppColors.accent : AppColors.mutedText,
              ),
              const SizedBox(height: AppSpacing.s4),
              Text(
                label,
                style: AppTextStyles.body12.copyWith(
                  color: isActive ? AppColors.accent : AppColors.mutedText,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
