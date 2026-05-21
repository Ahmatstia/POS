import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

/// Item in the shopping cart during a transaction.
@freezed
class CartItem with _$CartItem {
  const CartItem._();

  const factory CartItem({
    required String productId,
    required String productName,
    required int priceRupiah,
    required int quantity,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);

  /// Total for this line item (priceRupiah × quantity).
  int get total => priceRupiah * quantity;
}
