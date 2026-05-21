import 'package:drift/drift.dart';
import 'package:lexa_pos/core/database/tables/categories.dart';

@DataClassName('ProductRow')
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer().references(Categories, #id)();
  TextColumn get name => text()();
  TextColumn get sku => text().unique()();
  TextColumn get barcode => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  IntColumn get sellingPrice => integer()(); // Rupiah integer
  IntColumn get costPrice => integer().withDefault(const Constant(0))();
  TextColumn get unit => text().withDefault(const Constant('pcs'))();
  IntColumn get minStock => integer().withDefault(const Constant(5))();
  IntColumn get currentStock => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
