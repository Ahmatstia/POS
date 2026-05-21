import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_radius.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/features/pos/presentation/providers/payment_provider.dart';

/// Payment method selector — Cash / Card / Transfer (required for checkout).
class PaymentMethodSelector extends ConsumerWidget {
  const PaymentMethodSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(paymentMethodProvider);

    return Row(
      children: [
        _MethodButton(
          label: 'Cash',
          icon: Icons.money,
          isActive: selected == PaymentMethod.cash,
          onTap: () => ref.read(paymentMethodProvider.notifier).state =
              PaymentMethod.cash,
        ),
        const SizedBox(width: AppSpacing.s8),
        _MethodButton(
          label: 'Card',
          icon: Icons.credit_card,
          isActive: selected == PaymentMethod.card,
          onTap: () => ref.read(paymentMethodProvider.notifier).state =
              PaymentMethod.card,
        ),
        const SizedBox(width: AppSpacing.s8),
        _MethodButton(
          label: 'Transfer',
          icon: Icons.account_balance,
          isActive: selected == PaymentMethod.transfer,
          onTap: () => ref.read(paymentMethodProvider.notifier).state =
              PaymentMethod.transfer,
        ),
      ],
    );
  }
}

class _MethodButton extends StatelessWidget {
  const _MethodButton({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s12,
            vertical: AppSpacing.s12,
          ),
          decoration: BoxDecoration(
            color: isActive ? AppColors.accent : AppColors.surface,
            border: Border.all(
              color: isActive ? AppColors.accent : AppColors.border,
            ),
            borderRadius: BorderRadius.circular(AppRadius.input),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isActive ? Colors.white : AppColors.primary,
                size: 20,
              ),
              const SizedBox(height: AppSpacing.s4),
              Text(
                label,
                style: AppTextStyles.body12.copyWith(
                  color: isActive ? Colors.white : AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum PaymentMethod {
  cash,
  card,
  transfer;

  String get displayName {
    switch (this) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.card:
        return 'Card';
      case PaymentMethod.transfer:
        return 'Transfer';
    }
  }
}
