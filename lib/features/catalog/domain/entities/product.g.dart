// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: (json['id'] as num).toInt(),
      categoryId: (json['categoryId'] as num).toInt(),
      name: json['name'] as String,
      sku: json['sku'] as String,
      barcode: json['barcode'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      sellingPrice: (json['sellingPrice'] as num).toInt(),
      costPrice: (json['costPrice'] as num).toInt(),
      unit: json['unit'] as String,
      minStock: (json['minStock'] as num).toInt(),
      currentStock: (json['currentStock'] as num).toInt(),
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'name': instance.name,
      'sku': instance.sku,
      'barcode': instance.barcode,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'sellingPrice': instance.sellingPrice,
      'costPrice': instance.costPrice,
      'unit': instance.unit,
      'minStock': instance.minStock,
      'currentStock': instance.currentStock,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
