import 'package:drift/drift.dart';

@DataClassName('SyncQueueRow')
class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityType => text()(); // 'transaction', 'product', 'customer', etc.
  IntColumn get entityId => integer()();
  TextColumn get action => text()(); // 'create', 'update', 'delete'
  TextColumn get payload => text()(); // JSON string snapshot
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  IntColumn get status => integer().withDefault(const Constant(0))(); // 0=pending, 1=synced, 2=failed
  
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
