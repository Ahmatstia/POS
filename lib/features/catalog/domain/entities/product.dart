import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

/// Sellable catalog item for POS — immutable value object.
@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required int categoryId,
    required String name,
    required String sku,
    String? barcode,
    String? description,
    String? imageUrl,
    required int sellingPrice,
    required int costPrice,
    required String unit,
    required int minStock,
    required int currentStock,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
