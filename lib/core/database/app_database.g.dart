// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProductsTable extends Products
    with TableInfo<$ProductsTable, ProductRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceRupiahMeta = const VerificationMeta(
    'priceRupiah',
  );
  @override
  late final GeneratedColumn<int> priceRupiah = GeneratedColumn<int>(
    'price_rupiah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stockQuantityMeta = const VerificationMeta(
    'stockQuantity',
  );
  @override
  late final GeneratedColumn<int> stockQuantity = GeneratedColumn<int>(
    'stock_quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _updatedAtMillisMeta = const VerificationMeta(
    'updatedAtMillis',
  );
  @override
  late final GeneratedColumn<int> updatedAtMillis = GeneratedColumn<int>(
    'updated_at_millis',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    priceRupiah,
    stockQuantity,
    categoryId,
    imageUrl,
    isActive,
    updatedAtMillis,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price_rupiah')) {
      context.handle(
        _priceRupiahMeta,
        priceRupiah.isAcceptableOrUnknown(
          data['price_rupiah']!,
          _priceRupiahMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_priceRupiahMeta);
    }
    if (data.containsKey('stock_quantity')) {
      context.handle(
        _stockQuantityMeta,
        stockQuantity.isAcceptableOrUnknown(
          data['stock_quantity']!,
          _stockQuantityMeta,
        ),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('updated_at_millis')) {
      context.handle(
        _updatedAtMillisMeta,
        updatedAtMillis.isAcceptableOrUnknown(
          data['updated_at_millis']!,
          _updatedAtMillisMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      priceRupiah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_rupiah'],
      )!,
      stockQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock_quantity'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      updatedAtMillis: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_millis'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class ProductRow extends DataClass implements Insertable<ProductRow> {
  /// Stable product identifier (SKU or server id).
  final String id;
  final String name;

  /// Price in whole Indonesian Rupiah (no fractional IDR in retail).
  final int priceRupiah;
  final int stockQuantity;
  final String? categoryId;
  final String? imageUrl;
  final bool isActive;

  /// Last mutation time for sync conflict hints.
  final int updatedAtMillis;
  const ProductRow({
    required this.id,
    required this.name,
    required this.priceRupiah,
    required this.stockQuantity,
    this.categoryId,
    this.imageUrl,
    required this.isActive,
    required this.updatedAtMillis,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['price_rupiah'] = Variable<int>(priceRupiah);
    map['stock_quantity'] = Variable<int>(stockQuantity);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['updated_at_millis'] = Variable<int>(updatedAtMillis);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      priceRupiah: Value(priceRupiah),
      stockQuantity: Value(stockQuantity),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      isActive: Value(isActive),
      updatedAtMillis: Value(updatedAtMillis),
    );
  }

  factory ProductRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      priceRupiah: serializer.fromJson<int>(json['priceRupiah']),
      stockQuantity: serializer.fromJson<int>(json['stockQuantity']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      updatedAtMillis: serializer.fromJson<int>(json['updatedAtMillis']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'priceRupiah': serializer.toJson<int>(priceRupiah),
      'stockQuantity': serializer.toJson<int>(stockQuantity),
      'categoryId': serializer.toJson<String?>(categoryId),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'isActive': serializer.toJson<bool>(isActive),
      'updatedAtMillis': serializer.toJson<int>(updatedAtMillis),
    };
  }

  ProductRow copyWith({
    String? id,
    String? name,
    int? priceRupiah,
    int? stockQuantity,
    Value<String?> categoryId = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    bool? isActive,
    int? updatedAtMillis,
  }) => ProductRow(
    id: id ?? this.id,
    name: name ?? this.name,
    priceRupiah: priceRupiah ?? this.priceRupiah,
    stockQuantity: stockQuantity ?? this.stockQuantity,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    isActive: isActive ?? this.isActive,
    updatedAtMillis: updatedAtMillis ?? this.updatedAtMillis,
  );
  ProductRow copyWithCompanion(ProductsCompanion data) {
    return ProductRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      priceRupiah: data.priceRupiah.present
          ? data.priceRupiah.value
          : this.priceRupiah,
      stockQuantity: data.stockQuantity.present
          ? data.stockQuantity.value
          : this.stockQuantity,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      updatedAtMillis: data.updatedAtMillis.present
          ? data.updatedAtMillis.value
          : this.updatedAtMillis,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('priceRupiah: $priceRupiah, ')
          ..write('stockQuantity: $stockQuantity, ')
          ..write('categoryId: $categoryId, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAtMillis: $updatedAtMillis')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    priceRupiah,
    stockQuantity,
    categoryId,
    imageUrl,
    isActive,
    updatedAtMillis,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.priceRupiah == this.priceRupiah &&
          other.stockQuantity == this.stockQuantity &&
          other.categoryId == this.categoryId &&
          other.imageUrl == this.imageUrl &&
          other.isActive == this.isActive &&
          other.updatedAtMillis == this.updatedAtMillis);
}

class ProductsCompanion extends UpdateCompanion<ProductRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> priceRupiah;
  final Value<int> stockQuantity;
  final Value<String?> categoryId;
  final Value<String?> imageUrl;
  final Value<bool> isActive;
  final Value<int> updatedAtMillis;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.priceRupiah = const Value.absent(),
    this.stockQuantity = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.isActive = const Value.absent(),
    this.updatedAtMillis = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String id,
    required String name,
    required int priceRupiah,
    this.stockQuantity = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.isActive = const Value.absent(),
    this.updatedAtMillis = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       priceRupiah = Value(priceRupiah);
  static Insertable<ProductRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? priceRupiah,
    Expression<int>? stockQuantity,
    Expression<String>? categoryId,
    Expression<String>? imageUrl,
    Expression<bool>? isActive,
    Expression<int>? updatedAtMillis,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (priceRupiah != null) 'price_rupiah': priceRupiah,
      if (stockQuantity != null) 'stock_quantity': stockQuantity,
      if (categoryId != null) 'category_id': categoryId,
      if (imageUrl != null) 'image_url': imageUrl,
      if (isActive != null) 'is_active': isActive,
      if (updatedAtMillis != null) 'updated_at_millis': updatedAtMillis,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? priceRupiah,
    Value<int>? stockQuantity,
    Value<String?>? categoryId,
    Value<String?>? imageUrl,
    Value<bool>? isActive,
    Value<int>? updatedAtMillis,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      priceRupiah: priceRupiah ?? this.priceRupiah,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      categoryId: categoryId ?? this.categoryId,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      updatedAtMillis: updatedAtMillis ?? this.updatedAtMillis,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (priceRupiah.present) {
      map['price_rupiah'] = Variable<int>(priceRupiah.value);
    }
    if (stockQuantity.present) {
      map['stock_quantity'] = Variable<int>(stockQuantity.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (updatedAtMillis.present) {
      map['updated_at_millis'] = Variable<int>(updatedAtMillis.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('priceRupiah: $priceRupiah, ')
          ..write('stockQuantity: $stockQuantity, ')
          ..write('categoryId: $categoryId, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAtMillis: $updatedAtMillis, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncOutboxTable extends SyncOutbox
    with TableInfo<$SyncOutboxTable, SyncOutboxRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncOutboxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMillisMeta = const VerificationMeta(
    'createdAtMillis',
  );
  @override
  late final GeneratedColumn<int> createdAtMillis = GeneratedColumn<int>(
    'created_at_millis',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptCountMeta = const VerificationMeta(
    'attemptCount',
  );
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
    'attempt_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    operation,
    payloadJson,
    createdAtMillis,
    attemptCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_outbox';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncOutboxRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('created_at_millis')) {
      context.handle(
        _createdAtMillisMeta,
        createdAtMillis.isAcceptableOrUnknown(
          data['created_at_millis']!,
          _createdAtMillisMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMillisMeta);
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
        _attemptCountMeta,
        attemptCount.isAcceptableOrUnknown(
          data['attempt_count']!,
          _attemptCountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncOutboxRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncOutboxRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      createdAtMillis: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_millis'],
      )!,
      attemptCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempt_count'],
      )!,
    );
  }

  @override
  $SyncOutboxTable createAlias(String alias) {
    return $SyncOutboxTable(attachedDatabase, alias);
  }
}

class SyncOutboxRow extends DataClass implements Insertable<SyncOutboxRow> {
  final int id;

  /// Domain entity name, e.g. `transaction`, `inventory_adjustment`.
  final String entityType;

  /// High-level operation for the sync worker.
  final String operation;

  /// Serialized payload for the remote adapter.
  final String payloadJson;
  final int createdAtMillis;
  final int attemptCount;
  const SyncOutboxRow({
    required this.id,
    required this.entityType,
    required this.operation,
    required this.payloadJson,
    required this.createdAtMillis,
    required this.attemptCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['operation'] = Variable<String>(operation);
    map['payload_json'] = Variable<String>(payloadJson);
    map['created_at_millis'] = Variable<int>(createdAtMillis);
    map['attempt_count'] = Variable<int>(attemptCount);
    return map;
  }

  SyncOutboxCompanion toCompanion(bool nullToAbsent) {
    return SyncOutboxCompanion(
      id: Value(id),
      entityType: Value(entityType),
      operation: Value(operation),
      payloadJson: Value(payloadJson),
      createdAtMillis: Value(createdAtMillis),
      attemptCount: Value(attemptCount),
    );
  }

  factory SyncOutboxRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncOutboxRow(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      operation: serializer.fromJson<String>(json['operation']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      createdAtMillis: serializer.fromJson<int>(json['createdAtMillis']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityType': serializer.toJson<String>(entityType),
      'operation': serializer.toJson<String>(operation),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'createdAtMillis': serializer.toJson<int>(createdAtMillis),
      'attemptCount': serializer.toJson<int>(attemptCount),
    };
  }

  SyncOutboxRow copyWith({
    int? id,
    String? entityType,
    String? operation,
    String? payloadJson,
    int? createdAtMillis,
    int? attemptCount,
  }) => SyncOutboxRow(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    operation: operation ?? this.operation,
    payloadJson: payloadJson ?? this.payloadJson,
    createdAtMillis: createdAtMillis ?? this.createdAtMillis,
    attemptCount: attemptCount ?? this.attemptCount,
  );
  SyncOutboxRow copyWithCompanion(SyncOutboxCompanion data) {
    return SyncOutboxRow(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      operation: data.operation.present ? data.operation.value : this.operation,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      createdAtMillis: data.createdAtMillis.present
          ? data.createdAtMillis.value
          : this.createdAtMillis,
      attemptCount: data.attemptCount.present
          ? data.attemptCount.value
          : this.attemptCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxRow(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAtMillis: $createdAtMillis, ')
          ..write('attemptCount: $attemptCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    operation,
    payloadJson,
    createdAtMillis,
    attemptCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncOutboxRow &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.operation == this.operation &&
          other.payloadJson == this.payloadJson &&
          other.createdAtMillis == this.createdAtMillis &&
          other.attemptCount == this.attemptCount);
}

class SyncOutboxCompanion extends UpdateCompanion<SyncOutboxRow> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<String> operation;
  final Value<String> payloadJson;
  final Value<int> createdAtMillis;
  final Value<int> attemptCount;
  const SyncOutboxCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.operation = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.createdAtMillis = const Value.absent(),
    this.attemptCount = const Value.absent(),
  });
  SyncOutboxCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    required String operation,
    required String payloadJson,
    required int createdAtMillis,
    this.attemptCount = const Value.absent(),
  }) : entityType = Value(entityType),
       operation = Value(operation),
       payloadJson = Value(payloadJson),
       createdAtMillis = Value(createdAtMillis);
  static Insertable<SyncOutboxRow> custom({
    Expression<int>? id,
    Expression<String>? entityType,
    Expression<String>? operation,
    Expression<String>? payloadJson,
    Expression<int>? createdAtMillis,
    Expression<int>? attemptCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (operation != null) 'operation': operation,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (createdAtMillis != null) 'created_at_millis': createdAtMillis,
      if (attemptCount != null) 'attempt_count': attemptCount,
    });
  }

  SyncOutboxCompanion copyWith({
    Value<int>? id,
    Value<String>? entityType,
    Value<String>? operation,
    Value<String>? payloadJson,
    Value<int>? createdAtMillis,
    Value<int>? attemptCount,
  }) {
    return SyncOutboxCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      operation: operation ?? this.operation,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAtMillis: createdAtMillis ?? this.createdAtMillis,
      attemptCount: attemptCount ?? this.attemptCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (createdAtMillis.present) {
      map['created_at_millis'] = Variable<int>(createdAtMillis.value);
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAtMillis: $createdAtMillis, ')
          ..write('attemptCount: $attemptCount')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, TransactionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().millisecondsSinceEpoch.toString(),
  );
  static const VerificationMeta _itemsJsonMeta = const VerificationMeta(
    'itemsJson',
  );
  @override
  late final GeneratedColumn<String> itemsJson = GeneratedColumn<String>(
    'items_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalRupiahMeta = const VerificationMeta(
    'subtotalRupiah',
  );
  @override
  late final GeneratedColumn<int> subtotalRupiah = GeneratedColumn<int>(
    'subtotal_rupiah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxRupiahMeta = const VerificationMeta(
    'taxRupiah',
  );
  @override
  late final GeneratedColumn<int> taxRupiah = GeneratedColumn<int>(
    'tax_rupiah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalRupiahMeta = const VerificationMeta(
    'totalRupiah',
  );
  @override
  late final GeneratedColumn<int> totalRupiah = GeneratedColumn<int>(
    'total_rupiah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountReceivedRupiahMeta =
      const VerificationMeta('amountReceivedRupiah');
  @override
  late final GeneratedColumn<int> amountReceivedRupiah = GeneratedColumn<int>(
    'amount_received_rupiah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changeRupiahMeta = const VerificationMeta(
    'changeRupiah',
  );
  @override
  late final GeneratedColumn<int> changeRupiah = GeneratedColumn<int>(
    'change_rupiah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMillisMeta = const VerificationMeta(
    'completedAtMillis',
  );
  @override
  late final GeneratedColumn<int> completedAtMillis = GeneratedColumn<int>(
    'completed_at_millis',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    itemsJson,
    subtotalRupiah,
    taxRupiah,
    totalRupiah,
    amountReceivedRupiah,
    changeRupiah,
    paymentMethod,
    completedAtMillis,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('items_json')) {
      context.handle(
        _itemsJsonMeta,
        itemsJson.isAcceptableOrUnknown(data['items_json']!, _itemsJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_itemsJsonMeta);
    }
    if (data.containsKey('subtotal_rupiah')) {
      context.handle(
        _subtotalRupiahMeta,
        subtotalRupiah.isAcceptableOrUnknown(
          data['subtotal_rupiah']!,
          _subtotalRupiahMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subtotalRupiahMeta);
    }
    if (data.containsKey('tax_rupiah')) {
      context.handle(
        _taxRupiahMeta,
        taxRupiah.isAcceptableOrUnknown(data['tax_rupiah']!, _taxRupiahMeta),
      );
    } else if (isInserting) {
      context.missing(_taxRupiahMeta);
    }
    if (data.containsKey('total_rupiah')) {
      context.handle(
        _totalRupiahMeta,
        totalRupiah.isAcceptableOrUnknown(
          data['total_rupiah']!,
          _totalRupiahMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalRupiahMeta);
    }
    if (data.containsKey('amount_received_rupiah')) {
      context.handle(
        _amountReceivedRupiahMeta,
        amountReceivedRupiah.isAcceptableOrUnknown(
          data['amount_received_rupiah']!,
          _amountReceivedRupiahMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountReceivedRupiahMeta);
    }
    if (data.containsKey('change_rupiah')) {
      context.handle(
        _changeRupiahMeta,
        changeRupiah.isAcceptableOrUnknown(
          data['change_rupiah']!,
          _changeRupiahMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_changeRupiahMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('completed_at_millis')) {
      context.handle(
        _completedAtMillisMeta,
        completedAtMillis.isAcceptableOrUnknown(
          data['completed_at_millis']!,
          _completedAtMillisMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedAtMillisMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TransactionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      itemsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}items_json'],
      )!,
      subtotalRupiah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal_rupiah'],
      )!,
      taxRupiah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tax_rupiah'],
      )!,
      totalRupiah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_rupiah'],
      )!,
      amountReceivedRupiah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_received_rupiah'],
      )!,
      changeRupiah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}change_rupiah'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      completedAtMillis: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_at_millis'],
      )!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class TransactionRow extends DataClass implements Insertable<TransactionRow> {
  final String id;

  /// JSON array of {productId, productName, quantity, priceRupiah}.
  final String itemsJson;
  final int subtotalRupiah;
  final int taxRupiah;
  final int totalRupiah;
  final int amountReceivedRupiah;
  final int changeRupiah;

  /// cash, card, transfer.
  final String paymentMethod;
  final int completedAtMillis;
  const TransactionRow({
    required this.id,
    required this.itemsJson,
    required this.subtotalRupiah,
    required this.taxRupiah,
    required this.totalRupiah,
    required this.amountReceivedRupiah,
    required this.changeRupiah,
    required this.paymentMethod,
    required this.completedAtMillis,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['items_json'] = Variable<String>(itemsJson);
    map['subtotal_rupiah'] = Variable<int>(subtotalRupiah);
    map['tax_rupiah'] = Variable<int>(taxRupiah);
    map['total_rupiah'] = Variable<int>(totalRupiah);
    map['amount_received_rupiah'] = Variable<int>(amountReceivedRupiah);
    map['change_rupiah'] = Variable<int>(changeRupiah);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['completed_at_millis'] = Variable<int>(completedAtMillis);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      itemsJson: Value(itemsJson),
      subtotalRupiah: Value(subtotalRupiah),
      taxRupiah: Value(taxRupiah),
      totalRupiah: Value(totalRupiah),
      amountReceivedRupiah: Value(amountReceivedRupiah),
      changeRupiah: Value(changeRupiah),
      paymentMethod: Value(paymentMethod),
      completedAtMillis: Value(completedAtMillis),
    );
  }

  factory TransactionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionRow(
      id: serializer.fromJson<String>(json['id']),
      itemsJson: serializer.fromJson<String>(json['itemsJson']),
      subtotalRupiah: serializer.fromJson<int>(json['subtotalRupiah']),
      taxRupiah: serializer.fromJson<int>(json['taxRupiah']),
      totalRupiah: serializer.fromJson<int>(json['totalRupiah']),
      amountReceivedRupiah: serializer.fromJson<int>(
        json['amountReceivedRupiah'],
      ),
      changeRupiah: serializer.fromJson<int>(json['changeRupiah']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      completedAtMillis: serializer.fromJson<int>(json['completedAtMillis']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'itemsJson': serializer.toJson<String>(itemsJson),
      'subtotalRupiah': serializer.toJson<int>(subtotalRupiah),
      'taxRupiah': serializer.toJson<int>(taxRupiah),
      'totalRupiah': serializer.toJson<int>(totalRupiah),
      'amountReceivedRupiah': serializer.toJson<int>(amountReceivedRupiah),
      'changeRupiah': serializer.toJson<int>(changeRupiah),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'completedAtMillis': serializer.toJson<int>(completedAtMillis),
    };
  }

  TransactionRow copyWith({
    String? id,
    String? itemsJson,
    int? subtotalRupiah,
    int? taxRupiah,
    int? totalRupiah,
    int? amountReceivedRupiah,
    int? changeRupiah,
    String? paymentMethod,
    int? completedAtMillis,
  }) => TransactionRow(
    id: id ?? this.id,
    itemsJson: itemsJson ?? this.itemsJson,
    subtotalRupiah: subtotalRupiah ?? this.subtotalRupiah,
    taxRupiah: taxRupiah ?? this.taxRupiah,
    totalRupiah: totalRupiah ?? this.totalRupiah,
    amountReceivedRupiah: amountReceivedRupiah ?? this.amountReceivedRupiah,
    changeRupiah: changeRupiah ?? this.changeRupiah,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    completedAtMillis: completedAtMillis ?? this.completedAtMillis,
  );
  TransactionRow copyWithCompanion(TransactionsCompanion data) {
    return TransactionRow(
      id: data.id.present ? data.id.value : this.id,
      itemsJson: data.itemsJson.present ? data.itemsJson.value : this.itemsJson,
      subtotalRupiah: data.subtotalRupiah.present
          ? data.subtotalRupiah.value
          : this.subtotalRupiah,
      taxRupiah: data.taxRupiah.present ? data.taxRupiah.value : this.taxRupiah,
      totalRupiah: data.totalRupiah.present
          ? data.totalRupiah.value
          : this.totalRupiah,
      amountReceivedRupiah: data.amountReceivedRupiah.present
          ? data.amountReceivedRupiah.value
          : this.amountReceivedRupiah,
      changeRupiah: data.changeRupiah.present
          ? data.changeRupiah.value
          : this.changeRupiah,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      completedAtMillis: data.completedAtMillis.present
          ? data.completedAtMillis.value
          : this.completedAtMillis,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionRow(')
          ..write('id: $id, ')
          ..write('itemsJson: $itemsJson, ')
          ..write('subtotalRupiah: $subtotalRupiah, ')
          ..write('taxRupiah: $taxRupiah, ')
          ..write('totalRupiah: $totalRupiah, ')
          ..write('amountReceivedRupiah: $amountReceivedRupiah, ')
          ..write('changeRupiah: $changeRupiah, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('completedAtMillis: $completedAtMillis')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    itemsJson,
    subtotalRupiah,
    taxRupiah,
    totalRupiah,
    amountReceivedRupiah,
    changeRupiah,
    paymentMethod,
    completedAtMillis,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionRow &&
          other.id == this.id &&
          other.itemsJson == this.itemsJson &&
          other.subtotalRupiah == this.subtotalRupiah &&
          other.taxRupiah == this.taxRupiah &&
          other.totalRupiah == this.totalRupiah &&
          other.amountReceivedRupiah == this.amountReceivedRupiah &&
          other.changeRupiah == this.changeRupiah &&
          other.paymentMethod == this.paymentMethod &&
          other.completedAtMillis == this.completedAtMillis);
}

class TransactionsCompanion extends UpdateCompanion<TransactionRow> {
  final Value<String> id;
  final Value<String> itemsJson;
  final Value<int> subtotalRupiah;
  final Value<int> taxRupiah;
  final Value<int> totalRupiah;
  final Value<int> amountReceivedRupiah;
  final Value<int> changeRupiah;
  final Value<String> paymentMethod;
  final Value<int> completedAtMillis;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.itemsJson = const Value.absent(),
    this.subtotalRupiah = const Value.absent(),
    this.taxRupiah = const Value.absent(),
    this.totalRupiah = const Value.absent(),
    this.amountReceivedRupiah = const Value.absent(),
    this.changeRupiah = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.completedAtMillis = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required String itemsJson,
    required int subtotalRupiah,
    required int taxRupiah,
    required int totalRupiah,
    required int amountReceivedRupiah,
    required int changeRupiah,
    required String paymentMethod,
    required int completedAtMillis,
    this.rowid = const Value.absent(),
  }) : itemsJson = Value(itemsJson),
       subtotalRupiah = Value(subtotalRupiah),
       taxRupiah = Value(taxRupiah),
       totalRupiah = Value(totalRupiah),
       amountReceivedRupiah = Value(amountReceivedRupiah),
       changeRupiah = Value(changeRupiah),
       paymentMethod = Value(paymentMethod),
       completedAtMillis = Value(completedAtMillis);
  static Insertable<TransactionRow> custom({
    Expression<String>? id,
    Expression<String>? itemsJson,
    Expression<int>? subtotalRupiah,
    Expression<int>? taxRupiah,
    Expression<int>? totalRupiah,
    Expression<int>? amountReceivedRupiah,
    Expression<int>? changeRupiah,
    Expression<String>? paymentMethod,
    Expression<int>? completedAtMillis,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemsJson != null) 'items_json': itemsJson,
      if (subtotalRupiah != null) 'subtotal_rupiah': subtotalRupiah,
      if (taxRupiah != null) 'tax_rupiah': taxRupiah,
      if (totalRupiah != null) 'total_rupiah': totalRupiah,
      if (amountReceivedRupiah != null)
        'amount_received_rupiah': amountReceivedRupiah,
      if (changeRupiah != null) 'change_rupiah': changeRupiah,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (completedAtMillis != null) 'completed_at_millis': completedAtMillis,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? itemsJson,
    Value<int>? subtotalRupiah,
    Value<int>? taxRupiah,
    Value<int>? totalRupiah,
    Value<int>? amountReceivedRupiah,
    Value<int>? changeRupiah,
    Value<String>? paymentMethod,
    Value<int>? completedAtMillis,
    Value<int>? rowid,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      itemsJson: itemsJson ?? this.itemsJson,
      subtotalRupiah: subtotalRupiah ?? this.subtotalRupiah,
      taxRupiah: taxRupiah ?? this.taxRupiah,
      totalRupiah: totalRupiah ?? this.totalRupiah,
      amountReceivedRupiah: amountReceivedRupiah ?? this.amountReceivedRupiah,
      changeRupiah: changeRupiah ?? this.changeRupiah,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      completedAtMillis: completedAtMillis ?? this.completedAtMillis,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (itemsJson.present) {
      map['items_json'] = Variable<String>(itemsJson.value);
    }
    if (subtotalRupiah.present) {
      map['subtotal_rupiah'] = Variable<int>(subtotalRupiah.value);
    }
    if (taxRupiah.present) {
      map['tax_rupiah'] = Variable<int>(taxRupiah.value);
    }
    if (totalRupiah.present) {
      map['total_rupiah'] = Variable<int>(totalRupiah.value);
    }
    if (amountReceivedRupiah.present) {
      map['amount_received_rupiah'] = Variable<int>(amountReceivedRupiah.value);
    }
    if (changeRupiah.present) {
      map['change_rupiah'] = Variable<int>(changeRupiah.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (completedAtMillis.present) {
      map['completed_at_millis'] = Variable<int>(completedAtMillis.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('itemsJson: $itemsJson, ')
          ..write('subtotalRupiah: $subtotalRupiah, ')
          ..write('taxRupiah: $taxRupiah, ')
          ..write('totalRupiah: $totalRupiah, ')
          ..write('amountReceivedRupiah: $amountReceivedRupiah, ')
          ..write('changeRupiah: $changeRupiah, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('completedAtMillis: $completedAtMillis, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $SyncOutboxTable syncOutbox = $SyncOutboxTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    products,
    syncOutbox,
    transactions,
  ];
}

typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      required String id,
      required String name,
      required int priceRupiah,
      Value<int> stockQuantity,
      Value<String?> categoryId,
      Value<String?> imageUrl,
      Value<bool> isActive,
      Value<int> updatedAtMillis,
      Value<int> rowid,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> priceRupiah,
      Value<int> stockQuantity,
      Value<String?> categoryId,
      Value<String?> imageUrl,
      Value<bool> isActive,
      Value<int> updatedAtMillis,
      Value<int> rowid,
    });

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priceRupiah => $composableBuilder(
    column: $table.priceRupiah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMillis => $composableBuilder(
    column: $table.updatedAtMillis,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priceRupiah => $composableBuilder(
    column: $table.priceRupiah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMillis => $composableBuilder(
    column: $table.updatedAtMillis,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get priceRupiah => $composableBuilder(
    column: $table.priceRupiah,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get updatedAtMillis => $composableBuilder(
    column: $table.updatedAtMillis,
    builder: (column) => column,
  );
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          ProductRow,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (
            ProductRow,
            BaseReferences<_$AppDatabase, $ProductsTable, ProductRow>,
          ),
          ProductRow,
          PrefetchHooks Function()
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> priceRupiah = const Value.absent(),
                Value<int> stockQuantity = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> updatedAtMillis = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                name: name,
                priceRupiah: priceRupiah,
                stockQuantity: stockQuantity,
                categoryId: categoryId,
                imageUrl: imageUrl,
                isActive: isActive,
                updatedAtMillis: updatedAtMillis,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int priceRupiah,
                Value<int> stockQuantity = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> updatedAtMillis = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                name: name,
                priceRupiah: priceRupiah,
                stockQuantity: stockQuantity,
                categoryId: categoryId,
                imageUrl: imageUrl,
                isActive: isActive,
                updatedAtMillis: updatedAtMillis,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      ProductRow,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (ProductRow, BaseReferences<_$AppDatabase, $ProductsTable, ProductRow>),
      ProductRow,
      PrefetchHooks Function()
    >;
typedef $$SyncOutboxTableCreateCompanionBuilder =
    SyncOutboxCompanion Function({
      Value<int> id,
      required String entityType,
      required String operation,
      required String payloadJson,
      required int createdAtMillis,
      Value<int> attemptCount,
    });
typedef $$SyncOutboxTableUpdateCompanionBuilder =
    SyncOutboxCompanion Function({
      Value<int> id,
      Value<String> entityType,
      Value<String> operation,
      Value<String> payloadJson,
      Value<int> createdAtMillis,
      Value<int> attemptCount,
    });

class $$SyncOutboxTableFilterComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMillis => $composableBuilder(
    column: $table.createdAtMillis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncOutboxTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMillis => $composableBuilder(
    column: $table.createdAtMillis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncOutboxTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtMillis => $composableBuilder(
    column: $table.createdAtMillis,
    builder: (column) => column,
  );

  GeneratedColumn<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => column,
  );
}

class $$SyncOutboxTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncOutboxTable,
          SyncOutboxRow,
          $$SyncOutboxTableFilterComposer,
          $$SyncOutboxTableOrderingComposer,
          $$SyncOutboxTableAnnotationComposer,
          $$SyncOutboxTableCreateCompanionBuilder,
          $$SyncOutboxTableUpdateCompanionBuilder,
          (
            SyncOutboxRow,
            BaseReferences<_$AppDatabase, $SyncOutboxTable, SyncOutboxRow>,
          ),
          SyncOutboxRow,
          PrefetchHooks Function()
        > {
  $$SyncOutboxTableTableManager(_$AppDatabase db, $SyncOutboxTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncOutboxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncOutboxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncOutboxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<int> createdAtMillis = const Value.absent(),
                Value<int> attemptCount = const Value.absent(),
              }) => SyncOutboxCompanion(
                id: id,
                entityType: entityType,
                operation: operation,
                payloadJson: payloadJson,
                createdAtMillis: createdAtMillis,
                attemptCount: attemptCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entityType,
                required String operation,
                required String payloadJson,
                required int createdAtMillis,
                Value<int> attemptCount = const Value.absent(),
              }) => SyncOutboxCompanion.insert(
                id: id,
                entityType: entityType,
                operation: operation,
                payloadJson: payloadJson,
                createdAtMillis: createdAtMillis,
                attemptCount: attemptCount,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncOutboxTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncOutboxTable,
      SyncOutboxRow,
      $$SyncOutboxTableFilterComposer,
      $$SyncOutboxTableOrderingComposer,
      $$SyncOutboxTableAnnotationComposer,
      $$SyncOutboxTableCreateCompanionBuilder,
      $$SyncOutboxTableUpdateCompanionBuilder,
      (
        SyncOutboxRow,
        BaseReferences<_$AppDatabase, $SyncOutboxTable, SyncOutboxRow>,
      ),
      SyncOutboxRow,
      PrefetchHooks Function()
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      Value<String> id,
      required String itemsJson,
      required int subtotalRupiah,
      required int taxRupiah,
      required int totalRupiah,
      required int amountReceivedRupiah,
      required int changeRupiah,
      required String paymentMethod,
      required int completedAtMillis,
      Value<int> rowid,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<String> id,
      Value<String> itemsJson,
      Value<int> subtotalRupiah,
      Value<int> taxRupiah,
      Value<int> totalRupiah,
      Value<int> amountReceivedRupiah,
      Value<int> changeRupiah,
      Value<String> paymentMethod,
      Value<int> completedAtMillis,
      Value<int> rowid,
    });

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemsJson => $composableBuilder(
    column: $table.itemsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotalRupiah => $composableBuilder(
    column: $table.subtotalRupiah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get taxRupiah => $composableBuilder(
    column: $table.taxRupiah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalRupiah => $composableBuilder(
    column: $table.totalRupiah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountReceivedRupiah => $composableBuilder(
    column: $table.amountReceivedRupiah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get changeRupiah => $composableBuilder(
    column: $table.changeRupiah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedAtMillis => $composableBuilder(
    column: $table.completedAtMillis,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemsJson => $composableBuilder(
    column: $table.itemsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotalRupiah => $composableBuilder(
    column: $table.subtotalRupiah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get taxRupiah => $composableBuilder(
    column: $table.taxRupiah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalRupiah => $composableBuilder(
    column: $table.totalRupiah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountReceivedRupiah => $composableBuilder(
    column: $table.amountReceivedRupiah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get changeRupiah => $composableBuilder(
    column: $table.changeRupiah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedAtMillis => $composableBuilder(
    column: $table.completedAtMillis,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemsJson =>
      $composableBuilder(column: $table.itemsJson, builder: (column) => column);

  GeneratedColumn<int> get subtotalRupiah => $composableBuilder(
    column: $table.subtotalRupiah,
    builder: (column) => column,
  );

  GeneratedColumn<int> get taxRupiah =>
      $composableBuilder(column: $table.taxRupiah, builder: (column) => column);

  GeneratedColumn<int> get totalRupiah => $composableBuilder(
    column: $table.totalRupiah,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountReceivedRupiah => $composableBuilder(
    column: $table.amountReceivedRupiah,
    builder: (column) => column,
  );

  GeneratedColumn<int> get changeRupiah => $composableBuilder(
    column: $table.changeRupiah,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completedAtMillis => $composableBuilder(
    column: $table.completedAtMillis,
    builder: (column) => column,
  );
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          TransactionRow,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (
            TransactionRow,
            BaseReferences<_$AppDatabase, $TransactionsTable, TransactionRow>,
          ),
          TransactionRow,
          PrefetchHooks Function()
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> itemsJson = const Value.absent(),
                Value<int> subtotalRupiah = const Value.absent(),
                Value<int> taxRupiah = const Value.absent(),
                Value<int> totalRupiah = const Value.absent(),
                Value<int> amountReceivedRupiah = const Value.absent(),
                Value<int> changeRupiah = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<int> completedAtMillis = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                itemsJson: itemsJson,
                subtotalRupiah: subtotalRupiah,
                taxRupiah: taxRupiah,
                totalRupiah: totalRupiah,
                amountReceivedRupiah: amountReceivedRupiah,
                changeRupiah: changeRupiah,
                paymentMethod: paymentMethod,
                completedAtMillis: completedAtMillis,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String itemsJson,
                required int subtotalRupiah,
                required int taxRupiah,
                required int totalRupiah,
                required int amountReceivedRupiah,
                required int changeRupiah,
                required String paymentMethod,
                required int completedAtMillis,
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                itemsJson: itemsJson,
                subtotalRupiah: subtotalRupiah,
                taxRupiah: taxRupiah,
                totalRupiah: totalRupiah,
                amountReceivedRupiah: amountReceivedRupiah,
                changeRupiah: changeRupiah,
                paymentMethod: paymentMethod,
                completedAtMillis: completedAtMillis,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      TransactionRow,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (
        TransactionRow,
        BaseReferences<_$AppDatabase, $TransactionsTable, TransactionRow>,
      ),
      TransactionRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$SyncOutboxTableTableManager get syncOutbox =>
      $$SyncOutboxTableTableManager(_db, _db.syncOutbox);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
}
