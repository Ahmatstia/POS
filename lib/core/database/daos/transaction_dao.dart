import 'package:drift/drift.dart';
import 'package:lexa_pos/core/database/app_database.dart';
import 'package:lexa_pos/core/database/tables/transaction_items.dart';
import 'package:lexa_pos/core/database/tables/transactions.dart';

part 'transaction_dao.g.dart';

@DriftAccessor(tables: [Transactions, TransactionItems])
class TransactionDao extends DatabaseAccessor<AppDatabase> with _$TransactionDaoMixin {
  TransactionDao(super.db);

  Future<int> insertCheckout(TransactionsCompanion transaction, List<TransactionItemsCompanion> items) {
    return this.transaction(() async {
      final txId = await into(transactions).insert(transaction);
      
      for (final item in items) {
        await into(transactionItems).insert(item.copyWith(transactionId: Value(txId)));
      }
      
      return txId;
    });
  }
}
