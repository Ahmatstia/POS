import 'package:lexa_pos/features/auth/domain/entities/user.dart';

/// Active authenticated session including tokens and PIN verification state.
class AuthSession {
  const AuthSession({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    this.isPinVerified = false,
    this.isShiftOpen = false,
  });

  final User user;
  final String accessToken;
  final String refreshToken;
  final bool isPinVerified;
  final bool isShiftOpen;

  /// Returns a copy with updated PIN verification flag.
  AuthSession copyWith({
    bool? isPinVerified,
    bool? isShiftOpen,
  }) {
    return AuthSession(
      user: user,
      accessToken: accessToken,
      refreshToken: refreshToken,
      isPinVerified: isPinVerified ?? this.isPinVerified,
      isShiftOpen: isShiftOpen ?? this.isShiftOpen,
    );
  }
}
