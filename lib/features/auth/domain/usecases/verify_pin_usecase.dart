import 'package:lexa_pos/features/auth/domain/entities/auth_session.dart';
import 'package:lexa_pos/features/auth/domain/repositories/auth_repository.dart';

/// Verifies staff PIN after login or app resume.
class VerifyPinUseCase {
  const VerifyPinUseCase(this._repository);

  final AuthRepository _repository;

  /// Validates PIN and returns session with [AuthSession.isPinVerified] true.
  Future<AuthSession> call({
    required String pin,
    required AuthSession session,
  }) {
    return _repository.verifyPin(pin: pin, session: session);
  }
}
