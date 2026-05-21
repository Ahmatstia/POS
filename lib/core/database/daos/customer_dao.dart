import 'package:drift/drift.dart';
import 'package:lexa_pos/core/database/app_database.dart';
import 'package:lexa_pos/core/database/tables/customers.dart';

part 'customer_dao.g.dart';

@DriftAccessor(tables: [Customers])
class CustomerDao extends DatabaseAccessor<AppDatabase> with _$CustomerDaoMixin {
  CustomerDao(super.db);

  Stream<List<CustomerRow>> watchAllActive() {
    return (select(customers)..where((c) => c.isDeleted.equals(false))).watch();
  }
}
