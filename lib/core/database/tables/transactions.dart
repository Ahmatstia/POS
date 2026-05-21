import 'package:drift/drift.dart';
import 'package:lexa_pos/core/database/tables/customers.dart';
import 'package:lexa_pos/core/database/tables/shifts.dart';
import 'package:lexa_pos/core/database/tables/users.dart';

@DataClassName('TransactionRow')
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get invoiceNumber => text().unique()(); // e.g. "INV-20240521-0042"
  IntColumn get shiftId => integer().references(Shifts, #id)();
  IntColumn get cashierId => integer().references(Users, #id)();
  IntColumn get customerId => integer().nullable().references(Customers, #id)();
  IntColumn get subtotal => integer()();
  IntColumn get discountAmount => integer().withDefault(const Constant(0))();
  IntColumn get taxAmount => integer().withDefault(const Constant(0))();
  IntColumn get serviceCharge => integer().withDefault(const Constant(0))();
  IntColumn get totalAmount => integer()();
  IntColumn get paymentMethod => integer()(); // 0=cash,1=qris,2=card,3=transfer,4=ewallet,5=split
  IntColumn get amountPaid => integer()();
  IntColumn get changeAmount => integer().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
  IntColumn get status => integer().withDefault(const Constant(1))(); // 0=voided, 1=completed, 2=refunded
  DateTimeColumn get printedAt => dateTime().nullable()();
  
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
