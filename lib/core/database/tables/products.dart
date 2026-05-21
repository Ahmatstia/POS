import 'package:drift/drift.dart';

/// Local product row for POS catalog — prices in whole Rupiah (integer).
@DataClassName('ProductRow')
class Products extends Table {
  /// Stable product identifier (SKU or server id).
  TextColumn get id => text()();

  TextColumn get name => text()();

  /// Price in whole Indonesian Rupiah (no fractional IDR in retail).
  IntColumn get priceRupiah => integer()();

  IntColumn get stockQuantity => integer().withDefault(const Constant(0))();
  
  IntColumn get minStock => integer().withDefault(const Constant(10))();

  TextColumn get categoryId => text().nullable()();

  TextColumn get imageUrl => text().nullable()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  /// Last mutation time for sync conflict hints.
  IntColumn get updatedAtMillis =>
      integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
