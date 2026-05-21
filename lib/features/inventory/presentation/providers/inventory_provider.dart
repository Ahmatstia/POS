import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexa_pos/features/catalog/domain/entities/product.dart';
import 'package:lexa_pos/core/database/database_provider.dart';

/// Provides a stream of all active products for the inventory screen.
final inventoryProductsProvider = StreamProvider<List<Product>>((ref) {
  final repo = ref.watch(productCatalogRepositoryProvider);
  return repo.watchActiveProducts();
});

/// Metrics aggregated from the inventory.
typedef InventoryMetrics = ({
  int totalSku,
  int lowStockCount,
  int totalValue,
});

/// Computes metrics based on the current inventory stream.
final inventoryMetricsProvider = Provider<InventoryMetrics>((ref) {
  final products = ref.watch(inventoryProductsProvider).valueOrNull ?? [];
  
  int lowStock = 0;
  int totalVal = 0;
  
  for (final p in products) {
    if (p.stockQuantity <= p.minStock) {
      lowStock++;
    }
    totalVal += (p.stockQuantity * p.priceRupiah);
  }
  
  return (
    totalSku: products.length,
    lowStockCount: lowStock,
    totalValue: totalVal,
  );
});
