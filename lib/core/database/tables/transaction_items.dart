import 'package:drift/drift.dart';
import 'package:lexa_pos/core/database/tables/product_variants.dart';
import 'package:lexa_pos/core/database/tables/products.dart';
import 'package:lexa_pos/core/database/tables/transactions.dart';

@DataClassName('TransactionItemRow')
class TransactionItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get transactionId => integer().references(Transactions, #id, onDelete: KeyAction.cascade)();
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get variantId => integer().nullable().references(ProductVariants, #id)();
  TextColumn get productName => text()();
  TextColumn get variantName => text().nullable()();
  IntColumn get unitPrice => integer()();
  IntColumn get costPrice => integer()();
  IntColumn get quantity => integer()();
  IntColumn get discountAmount => integer().withDefault(const Constant(0))();
  IntColumn get subtotal => integer()(); // (unitPrice - discount) * quantity
  TextColumn get notes => text().nullable()();
  
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
