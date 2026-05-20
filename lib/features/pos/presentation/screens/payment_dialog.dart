import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_radius.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/utils/format_currency.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';
import 'package:lexa_pos/features/auth/presentation/widgets/pin_pad.dart';
import 'package:lexa_pos/features/pos/presentation/providers/cart_provider.dart';

/// Payment entry dialog — number pad, validation, receipt preview.
class PaymentDialog extends ConsumerStatefulWidget {
  const PaymentDialog({super.key});

  @override
  ConsumerState<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends ConsumerState<PaymentDialog> {
  late String _amountStr;
  int _shakeTrigger = 0;

  @override
  void initState() {
    super.initState();
    _amountStr = '';
  }

  @override
  Widget build(BuildContext context) {
    final total = ref.watch(cartTotalProvider);
    final amountEntered = int.tryParse(_amountStr) ?? 0;
    final change = amountEntered - total;
    final isValid = change >= 0;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.dialog),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text('Confirm Payment', style: AppTextStyles.headline),
            const SizedBox(height: AppSpacing.space32),
            // Amount display
            Container(
              padding: const EdgeInsets.all(AppSpacing.space20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.input),
                border: Border.all(
                  color: isValid ? AppColors.success : AppColors.danger,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Amount Received',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.muted,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  Text(
                    _amountStr.isEmpty ? 'Rp 0' : formatCurrency(amountEntered),
                    style: AppTextStyles.display.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (isValid) ...[
                    const SizedBox(height: AppSpacing.space16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.space12,
                        vertical: AppSpacing.space8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                      ),
                      child: Text(
                        'Change: ${formatCurrency(change)}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.space32),
            // Number pad
            PinPad(
              onDigit: _onDigit,
              onBackspace: _onBackspace,
              shakeTrigger: _shakeTrigger,
            ),
            const SizedBox(height: AppSpacing.space32),
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Cancel',
                    variant: AppButtonVariant.secondary,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: AppButton(
                    label: 'Confirm',
                    onPressed: isValid
                        ? () => _confirmPayment(context, amountEntered, change)
                        : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onDigit(String digit) {
    setState(() {
      if (_amountStr.length < 12) {
        _amountStr += digit;
      }
    });
  }

  void _onBackspace() {
    setState(() {
      if (_amountStr.isNotEmpty) {
        _amountStr = _amountStr.substring(0, _amountStr.length - 1);
      }
    });
  }

  void _confirmPayment(
    BuildContext context,
    int amountReceived,
    int change,
  ) {
    Navigator.pop(context);
    _showReceiptPreview(context, amountReceived, change);
  }

  void _showReceiptPreview(
    BuildContext context,
    int amountReceived,
    int change,
  ) {
    final cart = ref.read(cartItemsProvider);
    final subtotal = ref.read(cartSubtotalProvider);
    final tax = ref.read(cartTaxProvider);
    final total = ref.read(cartTotalProvider);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.dialog),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Receipt', style: AppTextStyles.headline),
              const SizedBox(height: AppSpacing.space24),
              // Receipt content
              Container(
                constraints: const BoxConstraints(maxWidth: 300),
                padding: const EdgeInsets.all(AppSpacing.space16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        'LEXA POS',
                        style: AppTextStyles.title.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space12),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: AppSpacing.space12),
                    // Items
                    ...cart.map((item) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(bottom: AppSpacing.space8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.productName,
                                style: AppTextStyles.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '${item.quantity}x ${formatCurrency(item.priceRupiah)}',
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: AppSpacing.space12),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: AppSpacing.space12),
                    // Totals
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal', style: AppTextStyles.bodySmall),
                        Text(
                          formatCurrency(subtotal),
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.space4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tax', style: AppTextStyles.bodySmall),
                        Text(
                          formatCurrency(tax),
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.space12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.space8,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: AppColors.border),
                          bottom: BorderSide(color: AppColors.border),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TOTAL',
                            style: AppTextStyles.bodySmall.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            formatCurrency(total),
                            style: AppTextStyles.bodySmall.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Paid',
                          style: AppTextStyles.bodySmall,
                        ),
                        Text(
                          formatCurrency(amountReceived),
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.space4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Change',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.success,
                          ),
                        ),
                        Text(
                          formatCurrency(change),
                          style: AppTextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.space24),
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Print',
                      variant: AppButtonVariant.secondary,
                      onPressed: () {
                        // TODO: Print receipt
                      },
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space12),
                  Expanded(
                    child: AppButton(
                      label: 'Complete',
                      onPressed: () {
                        Navigator.pop(context);
                        _completeTransaction(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _completeTransaction(BuildContext context) {
    // TODO: Write to sync_outbox, clear cart
    ref.read(cartNotifierProvider.notifier).clearCart();
    HapticFeedback.heavyImpact();
  }
}
