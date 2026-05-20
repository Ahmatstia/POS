import 'package:drift/drift.dart';

/// Offline mutation queue — payloads are JSON for forward-compatible sync.
@DataClassName('SyncOutboxRow')
class SyncOutbox extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Domain entity name, e.g. `transaction`, `inventory_adjustment`.
  TextColumn get entityType => text()();

  /// High-level operation for the sync worker.
  TextColumn get operation => text()();

  /// Serialized payload for the remote adapter.
  TextColumn get payloadJson => text()();

  IntColumn get createdAtMillis => integer()();

  IntColumn get attemptCount => integer().withDefault(const Constant(0))();
}
