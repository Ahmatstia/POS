import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';
import 'package:lexa_pos/core/widgets/app_card.dart';
import 'package:lexa_pos/core/widgets/app_text_field.dart';
import 'package:lexa_pos/core/widgets/status_badge.dart';
import 'package:lexa_pos/features/catalog/domain/entities/product.dart';
import 'package:lexa_pos/router/app_router.dart';

/// Catalog Management Screen for creating and editing products.
class CatalogManagementScreen extends StatefulWidget {
  const CatalogManagementScreen({super.key});

  @override
  State<CatalogManagementScreen> createState() => _CatalogManagementScreenState();
}

class _CatalogManagementScreenState extends State<CatalogManagementScreen> {
  // Mock data for initial UI build
  final List<Product> _mockProducts = [
    Product(
      id: 1,
      categoryId: 1,
      name: 'Air Mineral 600ml',
      sku: 'SKU001',
      sellingPrice: 4000,
      costPrice: 2000,
      unit: 'pcs',
      minStock: 10,
      currentStock: 200,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: 2,
      categoryId: 1,
      name: 'Kopi Tubruk',
      sku: 'SKU002',
      sellingPrice: 15000,
      costPrice: 5000,
      unit: 'cup',
      minStock: 20,
      currentStock: 120,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: 3,
      categoryId: 2,
      name: 'Nasi Uduk Komplit',
      sku: 'SKU003',
      sellingPrice: 25000,
      costPrice: 15000,
      unit: 'porsi',
      minStock: 10,
      currentStock: 45,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: 4,
      categoryId: 2,
      name: 'Mie Goreng Spesial',
      sku: 'SKU004',
      sellingPrice: 22000,
      costPrice: 12000,
      unit: 'porsi',
      minStock: 10,
      currentStock: 0,
      isActive: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        foregroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.manager),
        ),
        title: const Text('Catalog Management', style: AppTextStyles.heading24),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
            child: AppButton.primary(
              text: 'Add Product',
              onPressed: () {
                // Add product logic
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s32),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    name: 'search',
                    label: 'Search Catalog',
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search),
                    onChanged: (val) {},
                  ),
                ),
                const SizedBox(width: AppSpacing.s16),
                AppButton.secondary(
                  text: 'Filter',
                  onPressed: () {},
                ),
                const SizedBox(width: AppSpacing.s16),
                AppButton.secondary(
                  text: 'Export',
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s24),
            Expanded(
              child: AppCard(
                level: AppCardLevel.level1,
                child: ListView.separated(
                  itemCount: _mockProducts.length + 1,
                  separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.border),
                  itemBuilder: (context, index) {
                    if (index == 0) return const _CatalogTableHeader();
                    return _CatalogTableRow(product: _mockProducts[index - 1]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CatalogTableHeader extends StatelessWidget {
  const _CatalogTableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24, vertical: AppSpacing.s16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text('Product Name', style: AppTextStyles.label12.copyWith(color: AppColors.mutedText)),
          ),
          Expanded(
            flex: 2,
            child: Text('Price', style: AppTextStyles.label12.copyWith(color: AppColors.mutedText)),
          ),
          Expanded(
            flex: 1,
            child: Text('Stock', style: AppTextStyles.label12.copyWith(color: AppColors.mutedText)),
          ),
          Expanded(
            flex: 1,
            child: Text('Status', style: AppTextStyles.label12.copyWith(color: AppColors.mutedText)),
          ),
          const SizedBox(width: 48), // Action icon spacing
        ],
      ),
    );
  }
}

class _CatalogTableRow extends StatelessWidget {
  const _CatalogTableRow({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Edit product logic
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24, vertical: AppSpacing.s16),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                product.name,
                style: AppTextStyles.body14.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Rp ${product.sellingPrice}',
                style: AppTextStyles.body14.copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                product.currentStock.toString(),
                style: AppTextStyles.body14,
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: StatusBadge(
                  status: product.isActive ? BadgeStatus.active : BadgeStatus.inactive,
                  text: product.isActive ? 'Active' : 'Inactive',
                ),
              ),
            ),
            SizedBox(
              width: 48,
              child: AppButton.iconOnly(
                icon: Icons.edit_outlined,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
