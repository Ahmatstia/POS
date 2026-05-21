import 'package:drift/drift.dart';
import 'package:lexa_pos/core/database/app_database.dart';
import 'package:lexa_pos/core/database/daos/product_dao.dart';
import 'package:lexa_pos/features/catalog/domain/entities/product.dart';
import 'package:lexa_pos/features/catalog/domain/repositories/product_catalog_repository.dart';

/// Drift-backed implementation of [ProductCatalogRepository].
class ProductCatalogRepositoryImpl implements ProductCatalogRepository {
  ProductCatalogRepositoryImpl(this._database);

  final AppDatabase _database;

  @override
  Stream<List<Product>> watchActiveProducts() {
    return _database.productDao.watchAllActive().map((list) {
      return list.map((item) => _mapRow(item.product)).toList();
    });
  }

  @override
  Future<List<Product>> listActiveProducts() async {
    final query = _database.select(_database.products)
      ..where((row) => row.isActive.equals(true))
      ..orderBy([(row) => OrderingTerm.asc(row.name)]);
    final rows = await query.get();
    return rows.map(_mapRow).toList();
  }

  @override
  Future<void> upsertProduct(Product product) {
    return _database.into(_database.products).insert(
          ProductsCompanion(
            id: product.id != 0 ? Value(product.id) : const Value.absent(),
            categoryId: Value(product.categoryId),
            name: Value(product.name),
            sku: Value(product.sku),
            barcode: Value(product.barcode),
            description: Value(product.description),
            imageUrl: Value(product.imageUrl),
            sellingPrice: Value(product.sellingPrice),
            costPrice: Value(product.costPrice),
            unit: Value(product.unit),
            minStock: Value(product.minStock),
            currentStock: Value(product.currentStock),
            isActive: Value(product.isActive),
            createdAt: Value(product.createdAt),
            updatedAt: Value(product.updatedAt),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  Product _mapRow(ProductRow row) {
    return Product(
      id: row.id,
      categoryId: row.categoryId,
      name: row.name,
      sku: row.sku,
      barcode: row.barcode,
      description: row.description,
      imageUrl: row.imageUrl,
      sellingPrice: row.sellingPrice,
      costPrice: row.costPrice,
      unit: row.unit,
      minStock: row.minStock,
      currentStock: row.currentStock,
      isActive: row.isActive,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
