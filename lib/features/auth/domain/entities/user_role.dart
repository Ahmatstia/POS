/// Staff role determining POS permissions and route access.
enum UserRole {
  cashier,
  manager,
  owner,
}

/// Display and permission helpers for [UserRole].
extension UserRoleX on UserRole {
  /// Human-readable role label for UI badges.
  String get displayName => switch (this) {
        UserRole.cashier => 'Cashier',
        UserRole.manager => 'Manager',
        UserRole.owner => 'Owner',
      };

  /// Whether this role can access manager-only screens.
  bool get isManagerOrAbove =>
      this == UserRole.manager || this == UserRole.owner;

  /// Whether this role can access owner-only reports.
  bool get isOwner => this == UserRole.owner;
}
