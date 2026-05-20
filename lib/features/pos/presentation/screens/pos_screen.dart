import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/features/pos/presentation/screens/payment_dialog.dart';
import 'package:lexa_pos/features/pos/presentation/widgets/cart_panel.dart';
import 'package:lexa_pos/features/pos/presentation/widgets/product_grid.dart';

/// Main POS screen — cashier interface for adding items, cart, checkout.
/// Layout: Navigation rail (left, 88px) + Product grid (center) + Cart panel (right, 320px)
class PosScreen extends ConsumerWidget {
  const PosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Row(
        children: [
          // Left: Product grid (main content area)
          Expanded(
            child: ProductGrid(),
          ),
          // Right: Cart panel (sticky)
          CartPanel(
            onCheckout: () => _showPaymentDialog(context),
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const PaymentDialog(),
    );
  }
}
