import 'package:drift/drift.dart';

@DataClassName('UserRow')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get username => text().unique()();
  TextColumn get passwordHash => text()();
  IntColumn get role => integer()(); // 0=owner, 1=manager, 2=cashier
  TextColumn get pin => text().nullable()(); // 6-digit hashed
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get lastLoginAt => dateTime().nullable()();
  
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
