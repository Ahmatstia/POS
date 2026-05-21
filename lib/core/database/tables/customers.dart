import 'package:drift/drift.dart';

@DataClassName('CustomerRow')
class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();
  IntColumn get loyaltyPoints => integer().withDefault(const Constant(0))();
  DateTimeColumn get birthDate => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get totalSpend => integer().withDefault(const Constant(0))();
  IntColumn get visitCount => integer().withDefault(const Constant(0))();
  
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
