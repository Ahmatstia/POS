import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexa_pos/core/database/app_database.dart';
import 'package:lexa_pos/features/catalog/data/repositories/product_catalog_repository_impl.dart';
import 'package:lexa_pos/features/catalog/domain/repositories/product_catalog_repository.dart';

/// Singleton [AppDatabase] for the app process — closed on scope dispose.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

/// Catalog read/write backed by local SQLite.
final productCatalogRepositoryProvider = Provider<ProductCatalogRepository>(
  (ref) => ProductCatalogRepositoryImpl(ref.watch(appDatabaseProvider)),
);
