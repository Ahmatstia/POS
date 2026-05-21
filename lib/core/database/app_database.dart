import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:lexa_pos/core/database/tables/categories.dart';
import 'package:lexa_pos/core/database/tables/customers.dart';
import 'package:lexa_pos/core/database/tables/product_variants.dart';
import 'package:lexa_pos/core/database/tables/products.dart';
import 'package:lexa_pos/core/database/tables/shifts.dart';
import 'package:lexa_pos/core/database/tables/stock_movements.dart';
import 'package:lexa_pos/core/database/tables/sync_queue.dart';
import 'package:lexa_pos/core/database/tables/transaction_items.dart';
import 'package:lexa_pos/core/database/tables/transactions.dart';
import 'package:lexa_pos/core/database/tables/users.dart';
import 'package:lexa_pos/core/database/daos/product_dao.dart';
import 'package:lexa_pos/core/database/daos/transaction_dao.dart';
import 'package:lexa_pos/core/database/daos/customer_dao.dart';
import 'package:lexa_pos/core/database/daos/inventory_dao.dart';

part 'app_database.g.dart';

/// Lexa POS on-device SQLite database (Drift).
@DriftDatabase(tables: [
  Users,
  Categories,
  Products,
  ProductVariants,
  Customers,
  Shifts,
  Transactions,
  TransactionItems,
  StockMovements,
  SyncQueue,
])
class AppDatabase extends _$AppDatabase {
  /// Opens the default app database file on device storage.
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'lexa_pos_v2'));

  ProductDao get productDao => ProductDao(this);
  TransactionDao get transactionDao => TransactionDao(this);
  CustomerDao get customerDao => CustomerDao(this);
  InventoryDao get inventoryDao => InventoryDao(this);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator migrator) async {
          await migrator.createAll();
          await _seedDefaultData();
        },
        onUpgrade: (Migrator migrator, int from, int to) async {
          // Future migrations will go here
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
          await customStatement('PRAGMA journal_mode = WAL');
        },
      );

  Future<void> _seedDefaultData() async {
    final now = DateTime.now();
    
    await batch((batch) {
      // 1. Seed Owner User
      batch.insert(
        users,
        UsersCompanion.insert(
          name: 'Owner',
          username: 'owner',
          passwordHash: 'hash', // mock
          role: 0,
          createdAt: now,
          updatedAt: now,
        ),
      );

      // 2. Seed default categories
      batch.insert(
        categories,
        CategoriesCompanion.insert(
          name: 'Umum',
          createdAt: now,
          updatedAt: now,
        ),
      );
    });
  }
}
