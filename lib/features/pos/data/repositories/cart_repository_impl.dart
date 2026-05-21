import 'package:lexa_pos/features/pos/domain/entities/cart_item.dart';
import 'package:lexa_pos/features/pos/domain/repositories/cart_repository.dart';

/// In-memory cart — Map for O(1) lookup, no persistence until checkout.
class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl() : _items = {}, _heldOrders = {};

  final Map<int, CartItem> _items;
  final Map<String, Map<int, CartItem>> _heldOrders;

  @override
  Future<CartItem> addItem({
    required int productId,
    required String productName,
    required int priceRupiah,
    required int costPrice,
  }) async {
    final existing = _items[productId];
    final item = existing != null
        ? existing.copyWith(quantity: existing.quantity + 1)
        : CartItem(
            productId: productId,
            productName: productName,
            priceRupiah: priceRupiah,
            costPrice: costPrice,
            quantity: 1,
          );
    _items[productId] = item;
    return item;
  }

  @override
  Future<void> removeItem(int productId) async {
    _items.remove(productId);
  }

  @override
  Future<CartItem> updateQuantity(int productId, int quantity) async {
    if (quantity < 1) {
      throw ArgumentError('Quantity must be >= 1');
    }
    final existing = _items[productId];
    if (existing == null) {
      throw ArgumentError('Item not in cart');
    }
    final updated = existing.copyWith(quantity: quantity);
    _items[productId] = updated;
    return updated;
  }

  @override
  Future<void> clearCart() async {
    _items.clear();
  }

  @override
  Future<Map<int, CartItem>> getCart() async {
    return Map.unmodifiable(_items);
  }

  @override
  Future<void> holdOrder(String holdId) async {
    if (_heldOrders.length >= 10) {
      throw Exception('Maximum 10 held orders allowed');
    }
    _heldOrders[holdId] = Map.from(_items);
    _items.clear();
  }

  @override
  Future<void> restoreHoldOrder(String holdId) async {
    final held = _heldOrders[holdId];
    if (held == null) {
      throw ArgumentError('Hold order not found: $holdId');
    }
    _items.clear();
    _items.addAll(held);
    _heldOrders.remove(holdId);
  }

  @override
  Future<List<String>> listHeldOrders() async {
    return _heldOrders.keys.toList();
  }
}
