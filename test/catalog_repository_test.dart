import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexa_pos/core/database/app_database.dart';
import 'package:lexa_pos/features/catalog/data/repositories/product_catalog_repository_impl.dart';

void main() {
  test('ProductCatalogRepository seeds three demo products on first open', () async {
    final executor = NativeDatabase.memory();
    final db = AppDatabase(executor);
    addTearDown(db.close);

    final repo = ProductCatalogRepositoryImpl(db);
    final products = await repo.listActiveProducts();

    expect(products, hasLength(3));
    expect(products.map((product) => product.id).toList(), contains('demo_kopi'));
  });
}
