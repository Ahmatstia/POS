import 'package:flutter/material.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_radius.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';

/// Payment method selector — Cash / Card / Transfer (visual split bar).
class PaymentMethodSelector extends StatefulWidget {
  const PaymentMethodSelector({super.key});

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  late PaymentMethod _selected;

  @override
  void initState() {
    super.initState();
    _selected = PaymentMethod.cash;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _MethodButton(
          label: 'Cash',
          icon: Icons.money,
          isActive: _selected == PaymentMethod.cash,
          onTap: () => setState(() => _selected = PaymentMethod.cash),
        ),
        const SizedBox(width: AppSpacing.space8),
        _MethodButton(
          label: 'Card',
          icon: Icons.credit_card,
          isActive: _selected == PaymentMethod.card,
          onTap: () => setState(() => _selected = PaymentMethod.card),
        ),
        const SizedBox(width: AppSpacing.space8),
        _MethodButton(
          label: 'Transfer',
          icon: Icons.account_balance,
          isActive: _selected == PaymentMethod.transfer,
          onTap: () => setState(() => _selected = PaymentMethod.transfer),
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
            horizontal: AppSpacing.space12,
            vertical: AppSpacing.space12,
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
              const SizedBox(height: AppSpacing.space4),
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
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

enum PaymentMethod { cash, card, transfer }
