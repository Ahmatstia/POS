import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/utils/format_currency.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';
import 'package:lexa_pos/core/widgets/app_card.dart';
import 'package:lexa_pos/features/pos/presentation/providers/cart_provider.dart';
import 'package:lexa_pos/features/pos/presentation/widgets/cart_item_row.dart';
import 'package:lexa_pos/features/pos/presentation/widgets/payment_method_selector.dart';

/// Right-side cart panel — items, totals, payment method, checkout button.
class CartPanel extends ConsumerWidget {
  const CartPanel({
    super.key,
    required this.onCheckout,
  });

  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartItemsProvider);
    final subtotal = ref.watch(cartSubtotalProvider);
    final tax = ref.watch(cartTaxProvider);
    final total = ref.watch(cartTotalProvider);
    final itemCount = ref.watch(cartItemCountProvider);

    final isEmpty = items.isEmpty;

    return Container(
      width: 320,
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(left: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(AppSpacing.s16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cart', style: AppTextStyles.heading24),
                const SizedBox(height: AppSpacing.s4),
                Text(
                  '$itemCount item${itemCount == 1 ? '' : 's'}',
                  style: AppTextStyles.body12.copyWith(
                    color: AppColors.mutedText,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          // Items list
          Expanded(
            child: isEmpty
                ? Center(
                    child: Text(
                      'No items',
                      style: AppTextStyles.body14.copyWith(
                        color: AppColors.mutedText,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.s12,
                      vertical: AppSpacing.s12,
                    ),
                    child: Column(
                      children: items
                          .map((item) => CartItemRowWidget(item: item))
                          .toList(),
                    ),
                  ),
          ),
          const Divider(height: 1, color: AppColors.border),
          // Totals
          Padding(
            padding: const EdgeInsets.all(AppSpacing.s16),
            child: AppCard(
              padding: const EdgeInsets.all(AppSpacing.s16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _TotalRow(label: 'Subtotal', amount: subtotal),
                  const SizedBox(height: AppSpacing.s8),
                  _TotalRow(label: 'Tax (10%)', amount: tax),
                  const Divider(
                    height: AppSpacing.s16,
                    color: AppColors.border,
                  ),
                  Text(
                    formatCurrency(total),
                    style: AppTextStyles.heading20.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),
          // Payment method
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16),
            child: PaymentMethodSelector(),
          ),
          const SizedBox(height: AppSpacing.s16),
          // Charge button (sticky bottom)
          Padding(
            padding: const EdgeInsets.all(AppSpacing.s16),
            child: SizedBox(
              width: double.infinity,
              child: AppButton.primary(
                text: 'Charge',
                onPressed: isEmpty ? null : onCheckout,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({
    required this.label,
    required this.amount,
  });

  final String label;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.body12),
        Text(
          formatCurrency(amount),
          style: AppTextStyles.body12.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
