/// Item in the shopping cart during a transaction.
class CartItem {
  const CartItem({
    required this.productId,
    required this.productName,
    required this.priceRupiah,
    required this.quantity,
  });

  final String productId;
  final String productName;
  final int priceRupiah;
  final int quantity;

  /// Total for this line item (priceRupiah × quantity).
  int get total => priceRupiah * quantity;

  /// Immutable copy with optional overrides.
  CartItem copyWith({
    String? productId,
    String? productName,
    int? priceRupiah,
    int? quantity,
  }) =>
      CartItem(
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        priceRupiah: priceRupiah ?? this.priceRupiah,
        quantity: quantity ?? this.quantity,
      );
}
