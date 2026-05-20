import 'package:lexa_pos/features/auth/domain/repositories/auth_repository.dart';

/// Ends the current session and clears secure storage.
class LogoutUseCase {
  const LogoutUseCase(this._repository);

  final AuthRepository _repository;

  /// Signs out the current user.
  Future<void> call() => _repository.logout();
}
