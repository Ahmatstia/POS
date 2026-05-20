import 'package:lexa_pos/features/auth/domain/entities/auth_session.dart';
import 'package:lexa_pos/features/auth/domain/repositories/auth_repository.dart';

/// Signs in a staff member with email and password.
class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  /// Executes login and returns a new [AuthSession].
  Future<AuthSession> call({
    required String email,
    required String password,
  }) {
    return _repository.login(email: email, password: password);
  }
}
