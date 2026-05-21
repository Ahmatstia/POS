import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexa_pos/features/pos/data/repositories/cart_repository_impl.dart';
import 'package:lexa_pos/features/pos/domain/entities/cart_item.dart';
import 'package:lexa_pos/features/pos/domain/repositories/cart_repository.dart';

/// Provides singleton cart repository.
final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepositoryImpl();
});

/// Global cart state — Map<productId, CartItem>.
/// Single source of truth for the transaction.
final cartNotifierProvider =
    AsyncNotifierProvider<CartNotifier, Map<String, CartItem>>(
  CartNotifier.new,
);

/// Manages cart mutations — add, remove, update quantity, clear, hold.
class CartNotifier extends AsyncNotifier<Map<String, CartItem>> {
  @override
  Future<Map<String, CartItem>> build() async {
    final repo = ref.read(cartRepositoryProvider);
    return repo.getCart();
  }

  /// Add item to cart (increments if exists).
  Future<void> addItem({
    required String productId,
    required String productName,
    required int priceRupiah,
  }) async {
    state = await AsyncValue.guard(() async {
      final repo = ref.read(cartRepositoryProvider);
      await repo.addItem(
        productId: productId,
        productName: productName,
        priceRupiah: priceRupiah,
      );
      return repo.getCart();
    });
  }

  /// Remove item from cart.
  Future<void> removeItem(String productId) async {
    state = await AsyncValue.guard(() async {
      final repo = ref.read(cartRepositoryProvider);
      await repo.removeItem(productId);
      return repo.getCart();
    });
  }

  /// Update quantity (must be >= 1).
  Future<void> updateQuantity(String productId, int quantity) async {
    state = await AsyncValue.guard(() async {
      final repo = ref.read(cartRepositoryProvider);
      await repo.updateQuantity(productId, quantity);
      return repo.getCart();
    });
  }

  /// Clear all items.
  Future<void> clearCart() async {
    await AsyncValue.guard(() async {
      final repo = ref.read(cartRepositoryProvider);
      await repo.clearCart();
      state = const AsyncValue.data({});
    });
  }

  /// Hold current cart for later.
  Future<void> holdOrder(String holdId) async {
    await AsyncValue.guard(() async {
      final repo = ref.read(cartRepositoryProvider);
      await repo.holdOrder(holdId);
      state = const AsyncValue.data({});
    });
  }

  /// Restore previously held order.
  Future<void> restoreHoldOrder(String holdId) async {
    state = await AsyncValue.guard(() async {
      final repo = ref.read(cartRepositoryProvider);
      await repo.restoreHoldOrder(holdId);
      return repo.getCart();
    });
  }
}

/// Selector: total count of items in cart.
final cartItemCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartNotifierProvider).valueOrNull ?? {};
  return cart.values.fold<int>(0, (sum, item) => sum + item.quantity);
});

/// Selector: subtotal (sum of all line totals).
final cartSubtotalProvider = Provider<int>((ref) {
  final cart = ref.watch(cartNotifierProvider).valueOrNull ?? {};
  return cart.values.fold<int>(0, (sum, item) => sum + item.total);
});

/// Selector: tax (10% of subtotal, for demo — typically server-driven).
final cartTaxProvider = Provider<int>((ref) {
  final subtotal = ref.watch(cartSubtotalProvider);
  return (subtotal * 0.1).toInt();
});

/// Selector: total (subtotal + tax).
final cartTotalProvider = Provider<int>((ref) {
  final subtotal = ref.watch(cartSubtotalProvider);
  final tax = ref.watch(cartTaxProvider);
  return subtotal + tax;
});

/// Selector: list of items (for UI binding).
final cartItemsProvider = Provider<List<CartItem>>((ref) {
  final cart = ref.watch(cartNotifierProvider).valueOrNull ?? {};
  return cart.values.toList();
});
