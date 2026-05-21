import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_radius.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/utils/format_currency.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';
import 'package:lexa_pos/core/widgets/app_toast.dart';
import 'package:lexa_pos/features/pos/domain/entities/cart_item.dart';
import 'package:lexa_pos/features/pos/presentation/providers/cart_provider.dart';

/// Cart item row — product, price, quantity editor, remove button.
class CartItemRowWidget extends ConsumerStatefulWidget {
  const CartItemRowWidget({super.key, required this.item});

  final CartItem item;

  @override
  ConsumerState<CartItemRowWidget> createState() => _CartItemRowState();
}

class _CartItemRowState extends ConsumerState<CartItemRowWidget> {
  late TextEditingController _qtyController;

  @override
  void initState() {
    super.initState();
    _qtyController = TextEditingController(text: widget.item.quantity.toString());
  }

  @override
  void didUpdateWidget(CartItemRowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.quantity != widget.item.quantity) {
      final newQtyStr = widget.item.quantity.toString();
      if (_qtyController.text != newQtyStr) {
        _qtyController.text = newQtyStr;
      }
    }
  }

  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s8),
      child: Row(
        children: [
          // Product name + price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.productName,
                  style: AppTextStyles.body12,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.s4),
                Text(
                  formatCurrency(widget.item.priceRupiah),
                  style: AppTextStyles.body12.copyWith(color: AppColors.mutedText),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.s12),
          // Quantity editor
          SizedBox(
            width: 80,
            child: TextField(
              controller: _qtyController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s8,
                  vertical: AppSpacing.s4,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.input),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                hintText: '1',
              ),
              onChanged: (value) {
                if (value.isEmpty) return;
                final qty = int.tryParse(value);
                if (qty != null && qty > 0) {
                  ref.read(cartNotifierProvider.notifier).updateQuantity(
                        widget.item.productId,
                        qty,
                      );
                }
              },
            ),
          ),
          const SizedBox(width: AppSpacing.s12),
          // Total price
          SizedBox(
            width: 100,
            child: Text(
              formatCurrency(widget.item.total),
              style: AppTextStyles.body12.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: AppSpacing.s12),
          // Remove button
          AppButton.iconOnly(
            icon: Icons.close,
            onPressed: () => _removeItem(),
          ),
        ],
      ),
    );
  }

  void _removeItem() {
    ref.read(cartNotifierProvider.notifier).removeItem(widget.item.productId);
    showAppToast(
      context,
      message: '${widget.item.productName} removed',
      icon: Icons.delete_outline,
      backgroundColor: AppColors.warning,
    );
  }
}
