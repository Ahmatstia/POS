import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexa_pos/core/database/database_provider.dart';
import 'package:lexa_pos/features/pos/presentation/widgets/payment_method_selector.dart';

// Re-export database provider for convenience.
export 'package:lexa_pos/core/database/database_provider.dart' show appDatabaseProvider;

// Alias for payment flow convenience.
final databaseProvider = appDatabaseProvider;

/// Global payment method selection — defaults to Cash.
final paymentMethodProvider =
    StateProvider<PaymentMethod>((ref) => PaymentMethod.cash);
