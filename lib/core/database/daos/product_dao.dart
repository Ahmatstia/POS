import 'package:drift/drift.dart';
import 'package:lexa_pos/core/database/app_database.dart';
import 'package:lexa_pos/core/database/tables/categories.dart';
import 'package:lexa_pos/core/database/tables/products.dart';
import 'package:lexa_pos/core/database/tables/stock_movements.dart';

part 'product_dao.g.dart';

class ProductWithCategory {
  ProductWithCategory({required this.product, this.category});
  
  final ProductRow product;
  final CategoryRow? category;
}

@DriftAccessor(tables: [Products, Categories, StockMovements])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(super.db);

  /// Watch all active products with category, ordered by name.
  Stream<List<ProductWithCategory>> watchAllActive() {
    final query = select(products).join([
      leftOuterJoin(categories, categories.id.equalsExp(products.categoryId)),
    ])
      ..where(products.isDeleted.equals(false) & products.isActive.equals(true))
      ..orderBy([OrderingTerm.asc(products.name)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return ProductWithCategory(
          product: row.readTable(products),
          category: row.readTableOrNull(categories),
        );
      }).toList();
    });
  }

  /// Search by name or barcode — used by POS search bar + scanner.
  Future<List<ProductRow>> search(String query) {
    return (select(products)
          ..where((p) =>
              p.isDeleted.equals(false) &
              (p.name.like('%$query%') | p.barcode.like('%$query%'))))
        .get();
  }

  /// Decrement stock atomically. ALWAYS use this — never update stock directly.
  Future<void> decrementStock(int productId, int qty) {
    return transaction(() async {
      final p = await (select(products)..where((t) => t.id.equals(productId))).getSingle();
      await (update(products)..where((t) => t.id.equals(productId))).write(
        ProductsCompanion(
          currentStock: Value(p.currentStock - qty),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }
}
