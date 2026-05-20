import 'package:lexa_pos/core/widgets/status_badge.dart';
import 'package:lexa_pos/features/auth/domain/entities/user_role.dart';
import 'package:flutter/material.dart';

/// Maps [UserRole] to a [StatusBadge] for staff headers.
class RoleBadge extends StatelessWidget {
  const RoleBadge({super.key, required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context) {
    final (type, label) = switch (role) {
      UserRole.cashier => (StatusBadgeType.inactive, 'Cashier'),
      UserRole.manager => (StatusBadgeType.warning, 'Manager'),
      UserRole.owner => (StatusBadgeType.active, 'Owner'),
    };

    return StatusBadge(label: label, type: type);
  }
}
