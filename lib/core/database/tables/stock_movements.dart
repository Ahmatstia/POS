import 'package:drift/drift.dart';
import 'package:lexa_pos/core/database/tables/product_variants.dart';
import 'package:lexa_pos/core/database/tables/products.dart';
import 'package:lexa_pos/core/database/tables/users.dart';

@DataClassName('StockMovementRow')
class StockMovements extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get variantId => integer().nullable().references(ProductVariants, #id)();
  IntColumn get type => integer()(); // 0=sale, 1=restock, 2=adjustment, 3=waste, 4=return
  IntColumn get quantity => integer()(); // positive=stock in, negative=stock out
  IntColumn get stockBefore => integer()();
  IntColumn get stockAfter => integer()();
  IntColumn get referenceId => integer().nullable()(); // transactionId or PO id
  TextColumn get notes => text().nullable()();
  IntColumn get userId => integer().references(Users, #id)();
  
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
