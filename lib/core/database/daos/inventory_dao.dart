import 'package:drift/drift.dart';
import 'package:lexa_pos/core/database/app_database.dart';
import 'package:lexa_pos/core/database/tables/stock_movements.dart';

part 'inventory_dao.g.dart';

@DriftAccessor(tables: [StockMovements])
class InventoryDao extends DatabaseAccessor<AppDatabase> with _$InventoryDaoMixin {
  InventoryDao(super.db);

  Future<int> insertMovement(StockMovementsCompanion movement) {
    return into(stockMovements).insert(movement);
  }
}
