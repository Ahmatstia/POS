import 'package:lexa_pos/features/auth/domain/entities/user.dart';
import 'package:lexa_pos/features/auth/domain/entities/user_role.dart';

/// Serializable user model for API and secure storage.
class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.storeId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      storeId: json['store_id'] as String,
    );
  }

  final String id;
  final String name;
  final String email;
  final String role;
  final String storeId;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role,
        'store_id': storeId,
      };

  /// Maps API/storage model to domain entity.
  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      role: UserRole.values.firstWhere(
        (value) => value.name == role,
        orElse: () => UserRole.cashier,
      ),
      storeId: storeId,
    );
  }

  /// Creates model from domain entity.
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role.name,
      storeId: user.storeId,
    );
  }
}
