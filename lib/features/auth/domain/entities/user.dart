import 'package:lexa_pos/features/auth/domain/entities/user_role.dart';

/// Authenticated staff member identity.
class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.storeId,
  });

  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String storeId;
}
