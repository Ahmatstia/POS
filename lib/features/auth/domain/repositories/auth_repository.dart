import 'package:lexa_pos/features/auth/domain/entities/auth_session.dart';
import 'package:lexa_pos/features/auth/domain/failures/auth_failure.dart';

/// Contract for authentication operations — domain layer only.
abstract interface class AuthRepository {
  /// Signs in with email and password, persisting session on success.
  Future<AuthSession> login({
    required String email,
    required String password,
  });

  /// Restores session from secure storage if tokens exist.
  Future<AuthSession?> restoreSession();

  /// Verifies the staff PIN and marks session as unlocked.
  Future<AuthSession> verifyPin({
    required String pin,
    required AuthSession session,
  });

  /// Clears tokens and ends the session.
  Future<void> logout();

  /// Opens a cashier shift (required before POS access).
  Future<AuthSession> openShift(AuthSession session);

  /// Whether a shift is currently open for this terminal.
  Future<bool> isShiftOpen();
}

/// Result type alias for auth operations that can fail.
typedef AuthResult<T> = ({T? data, AuthFailure? failure});
