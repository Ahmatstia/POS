import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_radius.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/utils/format_currency.dart';
import 'package:lexa_pos/core/widgets/app_card.dart';
import 'package:lexa_pos/features/catalog/domain/entities/product.dart';

/// Product grid card — image (60% top), name, price. Tap to add to cart.
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.isLoading = false,
  });

  final Product product;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const _ProductCardSkeleton();
    }

    return GestureDetector(
      onTap: product.currentStock > 0 && product.isActive ? onTap : null,
      child: _CardContent(product: product),
    );
  }
}

class _CardContent extends StatefulWidget {
  const _CardContent({required this.product});

  final Product product;

  @override
  State<_CardContent> createState() => _CardContentState();
}

class _CardContentState extends State<_CardContent> {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image area (60% of height)
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppRadius.card - 1), // account for border
                      topRight: Radius.circular(AppRadius.card - 1),
                    ),
                  ),
                  child: Center(
                    child: widget.product.imageUrl != null
                        ? ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(AppRadius.card - 1),
                              topRight: Radius.circular(AppRadius.card - 1),
                            ),
                            child: Image.network(
                              widget.product.imageUrl!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          )
                        : Icon(
                            Icons.image_not_supported_outlined,
                            color: AppColors.mutedText,
                            size: 48,
                          ),
                  ),
                ),
              ),
              // Name (40% of height)
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s8,
                    vertical: AppSpacing.s8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.name,
                        style: AppTextStyles.body12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        formatCurrency(widget.product.sellingPrice),
                        style: AppTextStyles.body12.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Stock badge (top-right)
          Positioned(
            top: AppSpacing.s8,
            right: AppSpacing.s8,
            child: _StockBadge(quantity: widget.product.currentStock),
          ),
          // Out-of-stock overlay
          if (widget.product.currentStock == 0 || !widget.product.isActive)
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
              child: Center(
                child: Text(
                  'Out of Stock',
                  style: AppTextStyles.label12.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: const Duration(milliseconds: 300))
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1.0, 1.0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
  }
}

class _StockBadge extends StatelessWidget {
  const _StockBadge({required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    final isLow = quantity > 0 && quantity <= 10;
    final color = quantity > 0
        ? (isLow ? AppColors.warning : AppColors.success)
        : AppColors.danger;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s8,
        vertical: AppSpacing.s4,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      child: Text(
        quantity.toString(),
        style: AppTextStyles.body12.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ProductCardSkeleton extends StatelessWidget {
  const _ProductCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(color: AppColors.border),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.s8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 12,
                    width: double.infinity,
                    color: AppColors.border,
                  ),
                  Container(
                    height: 12,
                    width: 80,
                    color: AppColors.border,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
