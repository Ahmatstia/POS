/// Sellable catalog item for POS — immutable value object.
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.priceRupiah,
    required this.stockQuantity,
    this.categoryId,
    this.imageUrl,
    required this.isActive,
    required this.updatedAtMillis,
  });

  final String id;
  final String name;
  final int priceRupiah;
  final int stockQuantity;
  final String? categoryId;
  final String? imageUrl;
  final bool isActive;
  final int updatedAtMillis;
}
