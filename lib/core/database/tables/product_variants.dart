import 'package:drift/drift.dart';
import 'package:lexa_pos/core/database/tables/products.dart';

@DataClassName('ProductVariantRow')
class ProductVariants extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()(); // e.g. "Ukuran L", "Rasa Coklat"
  TextColumn get sku => text().unique()();
  IntColumn get sellingPrice => integer()();
  IntColumn get costPrice => integer().withDefault(const Constant(0))();
  IntColumn get currentStock => integer().withDefault(const Constant(0))();
  
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
