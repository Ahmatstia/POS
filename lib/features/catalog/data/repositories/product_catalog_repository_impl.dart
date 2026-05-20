import 'package:drift/drift.dart';
import 'package:lexa_pos/core/database/app_database.dart';
import 'package:lexa_pos/features/catalog/domain/entities/product.dart';
import 'package:lexa_pos/features/catalog/domain/repositories/product_catalog_repository.dart';

/// Drift-backed implementation of [ProductCatalogRepository].
class ProductCatalogRepositoryImpl implements ProductCatalogRepository {
  ProductCatalogRepositoryImpl(this._database);

  final AppDatabase _database;

  @override
  Stream<List<Product>> watchActiveProducts() {
    return (_database.select(_database.products)
          ..where((row) => row.isActive.equals(true))
          ..orderBy([(row) => OrderingTerm.asc(row.name)]))
        .watch()
        .map((rows) => rows.map(_mapRow).toList());
  }

  @override
  Future<List<Product>> listActiveProducts() {
    return (_database.select(_database.products)
          ..where((row) => row.isActive.equals(true))
          ..orderBy([(row) => OrderingTerm.asc(row.name)]))
        .get()
        .then((rows) => rows.map(_mapRow).toList());
  }

  @override
  Future<void> upsertProduct(Product product) {
    return _database.into(_database.products).insert(
          ProductsCompanion(
            id: Value(product.id),
            name: Value(product.name),
            priceRupiah: Value(product.priceRupiah),
            stockQuantity: Value(product.stockQuantity),
            categoryId: Value(product.categoryId),
            imageUrl: Value(product.imageUrl),
            isActive: Value(product.isActive),
            updatedAtMillis: Value(product.updatedAtMillis),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  Product _mapRow(ProductRow row) {
    return Product(
      id: row.id,
      name: row.name,
      priceRupiah: row.priceRupiah,
      stockQuantity: row.stockQuantity,
      categoryId: row.categoryId,
      imageUrl: row.imageUrl,
      isActive: row.isActive,
      updatedAtMillis: row.updatedAtMillis,
    );
  }
}
