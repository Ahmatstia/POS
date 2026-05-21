import 'package:drift/drift.dart';

/// Completed transactions — revenue records for reporting & reconciliation.
@DataClassName('TransactionRow')
class Transactions extends Table {
  TextColumn get id => text().clientDefault(() => DateTime.now().millisecondsSinceEpoch.toString())();

  /// JSON array of {productId, productName, quantity, priceRupiah}.
  TextColumn get itemsJson => text()();

  IntColumn get subtotalRupiah => integer()();

  IntColumn get taxRupiah => integer()();

  IntColumn get totalRupiah => integer()();

  IntColumn get amountReceivedRupiah => integer()();

  IntColumn get changeRupiah => integer()();

  /// cash, card, transfer.
  TextColumn get paymentMethod => text()();

  IntColumn get completedAtMillis => integer()();
}
