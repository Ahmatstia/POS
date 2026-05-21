import 'package:flutter/material.dart';
import 'package:lexa_pos/core/widgets/status_badge.dart';
import 'package:lexa_pos/features/auth/domain/entities/user_role.dart';

/// Maps [UserRole] to a [StatusBadge] for staff identity headers.
class RoleBadge extends StatelessWidget {
  const RoleBadge({super.key, required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context) {
    final (status, label) = switch (role) {
      UserRole.cashier => (BadgeStatus.inactive, 'Cashier'),
      UserRole.manager => (BadgeStatus.warning, 'Manager'),
      UserRole.owner   => (BadgeStatus.active,  'Owner'),
    };

    return StatusBadge(text: label, status: status);
  }
}
