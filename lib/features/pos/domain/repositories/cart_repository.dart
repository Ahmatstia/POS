import 'package:lexa_pos/features/pos/domain/entities/cart_item.dart';

/// Manages shopping cart state — add, remove, clear, hold orders.
abstract interface class CartRepository {
  /// Add or increment item. Returns updated CartItem.
  Future<CartItem> addItem({
    required String productId,
    required String productName,
    required int priceRupiah,
  });

  /// Remove item entirely from cart.
  Future<void> removeItem(String productId);

  /// Update quantity for existing item (must be >= 1).
  Future<CartItem> updateQuantity(String productId, int quantity);

  /// Empty the cart.
  Future<void> clearCart();

  /// Get snapshot of current cart items.
  Future<Map<String, CartItem>> getCart();

  /// Hold current cart for later retrieval (up to 10 holds).
  Future<void> holdOrder(String holdId);

  /// Restore a previously held order.
  Future<void> restoreHoldOrder(String holdId);

  /// List all held orders.
  Future<List<String>> listHeldOrders();
}
