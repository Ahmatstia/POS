import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:lexa_pos/core/database/tables/products.dart';
import 'package:lexa_pos/core/database/tables/sync_outbox.dart';
import 'package:lexa_pos/core/database/tables/transactions.dart';

part 'app_database.g.dart';

/// Lexa POS on-device SQLite database (Drift).
@DriftDatabase(tables: [Products, SyncOutbox, Transactions])
class AppDatabase extends _$AppDatabase {
  /// Opens the default app database file on device storage.
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'lexa_pos'));

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator migrator) async {
          await migrator.createAll();
          await _seedDemoProducts();
        },
        onUpgrade: (Migrator migrator, int from, int to) async {
          if (from < 3) {
            try {
              await migrator.addColumn(products, products.minStock);
            } catch (e) {
              // Ignore if column already exists
            }
          }
        },
      );

  Future<void> _seedDemoProducts() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await batch((batch) {
      batch.insertAll(
        products,
        [
          ProductsCompanion.insert(
            id: 'demo_kopi',
            name: 'Kopi Tubruk',
            priceRupiah: 15000,
            stockQuantity: const Value(120),
            categoryId: const Value('cat_beverages'),
            imageUrl: const Value.absent(),
            updatedAtMillis: Value(now),
          ),
          ProductsCompanion.insert(
            id: 'demo_nasi',
            name: 'Nasi Uduk Komplit',
            priceRupiah: 25000,
            stockQuantity: const Value(45),
            categoryId: const Value('cat_food'),
            imageUrl: const Value.absent(),
            updatedAtMillis: Value(now),
          ),
          ProductsCompanion.insert(
            id: 'demo_air',
            name: 'Air Mineral 600ml',
            priceRupiah: 4000,
            stockQuantity: const Value(200),
            categoryId: const Value('cat_beverages'),
            imageUrl: const Value.absent(),
            updatedAtMillis: Value(now),
          ),
        ],
        mode: InsertMode.insertOrReplace,
      );
    });
  }
}
