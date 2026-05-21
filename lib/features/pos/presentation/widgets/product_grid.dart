import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexa_pos/core/database/database_provider.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/widgets/app_empty_view.dart';
import 'package:lexa_pos/core/widgets/app_error_view.dart';
import 'package:lexa_pos/core/widgets/app_toast.dart';
import 'package:lexa_pos/features/catalog/domain/entities/product.dart';
import 'package:lexa_pos/features/pos/presentation/providers/cart_provider.dart';
import 'package:lexa_pos/features/pos/presentation/widgets/product_card.dart';

/// Stream provider for product catalog.
final activeProductsProvider = StreamProvider<List<Product>>((ref) {
  final repo = ref.watch(productCatalogRepositoryProvider);
  return repo.watchActiveProducts();
});

/// Product grid for POS screen — 4-5 columns, staggered load, add-to-cart.
class ProductGrid extends ConsumerWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(activeProductsProvider);

    return productsAsync.when(
      data: (products) {
        if (products.isEmpty) {
          return const AppEmptyView(
            title: 'No Products',
            description: 'Stock your catalog to get started.',
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(AppSpacing.s16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.75,
            mainAxisSpacing: AppSpacing.s16,
            crossAxisSpacing: AppSpacing.s16,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              product: product,
              onTap: () => _addToCart(context, ref, product),
            )
                .animate()
                .fadeIn(
                  duration: const Duration(milliseconds: 300),
                  delay: Duration(milliseconds: index * 50),
                )
                .scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1.0, 1.0),
                  duration: const Duration(milliseconds: 300),
                  delay: Duration(milliseconds: index * 50),
                  curve: Curves.easeOut,
                );
          },
        );
      },
      loading: () => const _ProductGridSkeleton(),
      error: (error, stackTrace) => AppErrorView(
        title: 'Failed to Load Products',
        message: error.toString(),
        errorCode: 'ERR_CATALOG',
        onRetry: () => ref.refresh(activeProductsProvider),
      ),
    );
  }

  void _addToCart(
    BuildContext context,
    WidgetRef ref,
    dynamic product,
  ) {
    ref.read(cartNotifierProvider.notifier).addItem(
          productId: product.id,
          productName: product.name,
          priceRupiah: product.sellingPrice,
          costPrice: product.costPrice,
        );
    showAppToast(
      context,
      message: '${product.name} added to cart',
      icon: Icons.add_circle,
    );
  }
}

class _ProductGridSkeleton extends StatelessWidget {
  const _ProductGridSkeleton();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.s16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.75,
        mainAxisSpacing: AppSpacing.s16,
        crossAxisSpacing: AppSpacing.s16,
      ),
      itemCount: 12,
      itemBuilder: (context, index) => ProductCard(
        product: _skeletonProduct,
        onTap: () {},
        isLoading: true,
      ),
    );
  }
}

/// Dummy for skeleton — not a real Product.
final _skeletonProduct = Product(
  id: 0,
  categoryId: 1,
  name: '',
  sku: '',
  sellingPrice: 0,
  costPrice: 0,
  unit: 'pcs',
  minStock: 0,
  currentStock: 0,
  isActive: true,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);
