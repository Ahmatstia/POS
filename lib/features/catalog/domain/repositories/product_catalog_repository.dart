import 'package:lexa_pos/features/catalog/domain/entities/product.dart';

/// Reads and writes catalog products from the local database.
abstract interface class ProductCatalogRepository {
  /// Emits whenever active products change (offline-first POS grid).
  Stream<List<Product>> watchActiveProducts();

  /// Snapshot of active products for one-off loads.
  Future<List<Product>> listActiveProducts();

  /// Inserts or replaces a product row.
  Future<void> upsertProduct(Product product);
}
