import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_radius.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/utils/format_currency.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';
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
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.space8),
      child: Row(
        children: [
          // Product name + price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.productName,
                  style: AppTextStyles.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(
                  formatCurrency(widget.item.priceRupiah),
                  style: AppTextStyles.caption.copyWith(color: AppColors.muted),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.space12),
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
                  horizontal: AppSpacing.space8,
                  vertical: AppSpacing.space4,
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
          const SizedBox(width: AppSpacing.space12),
          // Total price
          SizedBox(
            width: 100,
            child: Text(
              formatCurrency(widget.item.total),
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: AppSpacing.space12),
          // Remove button
          AppButton(
            icon: Icons.close,
            variant: AppButtonVariant.icon,
            onPressed: () => _removeItem(),
          ),
        ],
      ),
    );
  }

  void _removeItem() {
    ref.read(cartNotifierProvider.notifier).removeItem(widget.item.productId);
  }
}
