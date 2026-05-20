import 'package:lexa_pos/features/auth/domain/entities/auth_session.dart';
import 'package:lexa_pos/features/auth/domain/repositories/auth_repository.dart';

/// Opens a cashier shift before POS operations.
class OpenShiftUseCase {
  const OpenShiftUseCase(this._repository);

  final AuthRepository _repository;

  /// Marks shift as open and returns updated session.
  Future<AuthSession> call(AuthSession session) => _repository.openShift(session);
}
