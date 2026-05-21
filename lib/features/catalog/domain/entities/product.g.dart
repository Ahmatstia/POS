// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      priceRupiah: (json['priceRupiah'] as num).toInt(),
      stockQuantity: (json['stockQuantity'] as num).toInt(),
      minStock: (json['minStock'] as num?)?.toInt() ?? 10,
      categoryId: json['categoryId'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isActive: json['isActive'] as bool,
      updatedAtMillis: (json['updatedAtMillis'] as num).toInt(),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'priceRupiah': instance.priceRupiah,
      'stockQuantity': instance.stockQuantity,
      'minStock': instance.minStock,
      'categoryId': instance.categoryId,
      'imageUrl': instance.imageUrl,
      'isActive': instance.isActive,
      'updatedAtMillis': instance.updatedAtMillis,
    };
