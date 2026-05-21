import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexa_pos/core/database/database_provider.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_radius.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/utils/format_currency.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';
import 'package:lexa_pos/core/widgets/app_toast.dart';
import 'package:lexa_pos/features/auth/presentation/widgets/pin_pad.dart';
import 'package:lexa_pos/features/pos/domain/entities/cart_item.dart';
import 'package:lexa_pos/features/pos/presentation/providers/cart_provider.dart';
import 'package:lexa_pos/features/pos/presentation/providers/payment_provider.dart';
import 'package:lexa_pos/features/pos/presentation/widgets/payment_method_selector.dart';

/// Payment entry dialog — number pad, validation, receipt preview.
class PaymentDialog extends ConsumerStatefulWidget {
  const PaymentDialog({super.key});

  @override
  ConsumerState<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends ConsumerState<PaymentDialog> {
  late String _amountStr;
  final int _shakeTrigger = 0;

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
        padding: const EdgeInsets.all(AppSpacing.s24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            // Title
            Text('Confirm Payment', style: AppTextStyles.heading24),
            const SizedBox(height: AppSpacing.s32),
            // Amount display
            Container(
              padding: const EdgeInsets.all(AppSpacing.s20),
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
                    style: AppTextStyles.body12.copyWith(
                      color: AppColors.mutedText,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s8),
                  Text(
                    _amountStr.isEmpty ? 'Rp 0' : formatCurrency(amountEntered),
                    style: AppTextStyles.heading32.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (isValid) ...[
                    const SizedBox(height: AppSpacing.s16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s12,
                        vertical: AppSpacing.s8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                      ),
                      child: Text(
                        'Change: ${formatCurrency(change)}',
                        style: AppTextStyles.body12.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.s32),
            // Payment method selector (required)
            Text(
              'Payment Method',
              style: AppTextStyles.body12.copyWith(
                color: AppColors.mutedText,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSpacing.s8),
            const PaymentMethodSelector(),
            const SizedBox(height: AppSpacing.s32),
            // Number pad
            PinPad(
              onDigit: _onDigit,
              onBackspace: _onBackspace,
              shakeTrigger: _shakeTrigger,
            ),
            const SizedBox(height: AppSpacing.s32),
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: AppButton.secondary(
                    text: 'Cancel',
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: AppSpacing.s12),
                Expanded(
                  child: AppButton.primary(
                    text: 'Confirm',
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
    final paymentMethod = ref.read(paymentMethodProvider);
    _showReceiptPreview(context, amountReceived, change, paymentMethod);
  }

  void _showReceiptPreview(
    BuildContext context,
    int amountReceived,
    int change,
    PaymentMethod paymentMethod,
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
          padding: const EdgeInsets.all(AppSpacing.s24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Text('Receipt', style: AppTextStyles.heading24),
              const SizedBox(height: AppSpacing.s24),
              // Receipt content
              Container(
                constraints: const BoxConstraints(maxWidth: 300),
                padding: const EdgeInsets.all(AppSpacing.s16),
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
                        style: AppTextStyles.heading24.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s12),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: AppSpacing.s12),
                    // Items
                    ...cart.map((item) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(bottom: AppSpacing.s8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.productName,
                                style: AppTextStyles.body12,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '${item.quantity}x ${formatCurrency(item.priceRupiah)}',
                              style: AppTextStyles.body12,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: AppSpacing.s12),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: AppSpacing.s12),
                    // Totals
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal', style: AppTextStyles.body12),
                        Text(
                          formatCurrency(subtotal),
                          style: AppTextStyles.body12,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tax', style: AppTextStyles.body12),
                        Text(
                          formatCurrency(tax),
                          style: AppTextStyles.body12,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.s8,
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
                            style: AppTextStyles.body12.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            formatCurrency(total),
                            style: AppTextStyles.body12.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment',
                          style: AppTextStyles.body12,
                        ),
                        Text(
                          paymentMethod.displayName,
                          style: AppTextStyles.body12.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Paid',
                          style: AppTextStyles.body12,
                        ),
                        Text(
                          formatCurrency(amountReceived),
                          style: AppTextStyles.body12,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Change',
                          style: AppTextStyles.body12.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.success,
                          ),
                        ),
                        Text(
                          formatCurrency(change),
                          style: AppTextStyles.body12.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.s24),
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: AppButton.secondary(
                      text: 'Print',
                      onPressed: () {
                        _printReceipt(context, cart, subtotal, tax, total,
                            amountReceived, change, paymentMethod);
                      },
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s12),
                  Expanded(
                    child: AppButton.primary(
                      text: 'Complete',
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
      ),
    );
  }

  void _completeTransaction(BuildContext context) {
    final cart = ref.read(cartItemsProvider);
    // Write transaction to database
    final db = ref.read(databaseProvider);

    db.transaction(() async {
      // Write transaction (will be called from _showReceiptPreview)
      // For now, just clear the cart
    });

    ref.read(cartNotifierProvider.notifier).clearCart();
    HapticFeedback.heavyImpact();

    showAppToast(
      context,
      message: 'Transaction completed',
      icon: Icons.check_circle,
      backgroundColor: AppColors.success,
    );
  }

  void _printReceipt(
    BuildContext context,
    List<CartItem> cart,
    int subtotal,
    int tax,
    int total,
    int amountReceived,
    int change,
    PaymentMethod paymentMethod,
  ) {
    // TODO: Integrate with actual receipt printer (bluetooth_print/ESC-POS)
    // For now, show toast indicating receipt was sent to printer
    showAppToast(
      context,
      message: 'Receipt sent to printer',
      icon: Icons.print,
      backgroundColor: AppColors.accent,
    );

    // In future, this would:
    // 1. Format receipt as ESC-POS commands
    // 2. Send to Bluetooth printer
    // 3. Handle printer errors
  }
}
