import 'package:drift/drift.dart';
import 'package:lexa_pos/core/database/tables/users.dart';

@DataClassName('ShiftRow')
class Shifts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  DateTimeColumn get openedAt => dateTime()();
  DateTimeColumn get closedAt => dateTime().nullable()();
  IntColumn get openingCash => integer().withDefault(const Constant(0))();
  IntColumn get closingCash => integer().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get status => integer().withDefault(const Constant(0))(); // 0=open, 1=closed
  
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
