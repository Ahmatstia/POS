import 'package:lexa_pos/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:lexa_pos/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:lexa_pos/features/auth/domain/entities/auth_session.dart';
import 'package:lexa_pos/features/auth/domain/failures/auth_failure.dart';
import 'package:lexa_pos/features/auth/domain/repositories/auth_repository.dart';

/// Implements [AuthRepository] using secure storage and mock remote API.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    AuthRemoteDataSource? remote,
    AuthLocalDataSource? local,
  })  : _remote = remote ?? AuthRemoteDataSource(),
        _local = local ?? AuthLocalDataSource();

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remote.login(
        email: email,
        password: password,
      );

      await _local.saveSession(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        user: response.user,
        pinHash: response.pinHash,
      );

      final shiftOpen = await _local.isShiftOpen();

      return AuthSession(
        user: response.user.toEntity(),
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        isShiftOpen: shiftOpen,
      );
    } on AuthRemoteException {
      throw const InvalidCredentialsFailure();
    } on AuthFailure {
      rethrow;
    } catch (_) {
      throw const AuthUnexpectedFailure();
    }
  }

  @override
  Future<AuthSession?> restoreSession() async {
    try {
      final token = await _local.readAccessToken();
      final refresh = await _local.readRefreshToken();
      final user = await _local.readUser();

      if (token == null || refresh == null || user == null) {
        return null;
      }

      final shiftOpen = await _local.isShiftOpen();

      return AuthSession(
        user: user.toEntity(),
        accessToken: token,
        refreshToken: refresh,
        isShiftOpen: shiftOpen,
      );
    } catch (_) {
      throw const AuthUnexpectedFailure();
    }
  }

  @override
  Future<AuthSession> verifyPin({
    required String pin,
    required AuthSession session,
  }) async {
    final storedHash = await _local.readPinHash();
    if (storedHash == null) {
      throw const SessionNotFoundFailure();
    }
    if (storedHash != pin) {
      throw const InvalidPinFailure();
    }
    return session.copyWith(isPinVerified: true);
  }

  @override
  Future<void> logout() async {
    await _local.clearSession();
  }

  @override
  Future<AuthSession> openShift(AuthSession session) async {
    await _local.setShiftOpen(true);
    return session.copyWith(isShiftOpen: true);
  }

  @override
  Future<bool> isShiftOpen() => _local.isShiftOpen();
}
