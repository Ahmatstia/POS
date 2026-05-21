import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

/// Sellable catalog item for POS — immutable value object.
@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required int priceRupiah,
    required int stockQuantity,
    @Default(10) int minStock,
    String? categoryId,
    String? imageUrl,
    required bool isActive,
    required int updatedAtMillis,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
