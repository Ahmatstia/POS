/// Typed authentication failure — never expose raw exceptions to UI.
sealed class AuthFailure {
  const AuthFailure(this.code, this.message);

  final String code;
  final String message;
}

/// Invalid email or password combination.
final class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure()
      : super('AUTH_001', 'Email or password is incorrect.');
}

/// PIN does not match stored value.
final class InvalidPinFailure extends AuthFailure {
  const InvalidPinFailure()
      : super('AUTH_002', 'PIN is incorrect. Try again.');
}

/// No stored session when one was required.
final class SessionNotFoundFailure extends AuthFailure {
  const SessionNotFoundFailure()
      : super('AUTH_003', 'Session expired. Please sign in again.');
}

/// Secure storage or network error.
final class AuthUnexpectedFailure extends AuthFailure {
  const AuthUnexpectedFailure()
      : super('AUTH_500', 'Something went wrong. Please try again.');
}
