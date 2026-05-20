import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexa_pos/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:lexa_pos/features/auth/domain/entities/auth_session.dart';
import 'package:lexa_pos/features/auth/domain/failures/auth_failure.dart';
import 'package:lexa_pos/features/auth/domain/repositories/auth_repository.dart';
import 'package:lexa_pos/features/auth/domain/usecases/login_usecase.dart';
import 'package:lexa_pos/features/auth/domain/usecases/logout_usecase.dart';
import 'package:lexa_pos/features/auth/domain/usecases/open_shift_usecase.dart';
import 'package:lexa_pos/features/auth/domain/usecases/verify_pin_usecase.dart';

/// Provides the auth repository implementation.
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(),
);

/// Provides login use case.
final loginUseCaseProvider = Provider<LoginUseCase>(
  (ref) => LoginUseCase(ref.watch(authRepositoryProvider)),
);

/// Provides PIN verification use case.
final verifyPinUseCaseProvider = Provider<VerifyPinUseCase>(
  (ref) => VerifyPinUseCase(ref.watch(authRepositoryProvider)),
);

/// Provides logout use case.
final logoutUseCaseProvider = Provider<LogoutUseCase>(
  (ref) => LogoutUseCase(ref.watch(authRepositoryProvider)),
);

/// Provides open shift use case.
final openShiftUseCaseProvider = Provider<OpenShiftUseCase>(
  (ref) => OpenShiftUseCase(ref.watch(authRepositoryProvider)),
);

/// Global authentication state — single source of truth for session.
final authNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, AuthSession?>(AuthNotifier.new);

/// Manages sign-in, PIN unlock, shift, and logout.
class AuthNotifier extends AsyncNotifier<AuthSession?> {
  @override
  Future<AuthSession?> build() async {
    return ref.read(authRepositoryProvider).restoreSession();
  }

  /// Signs in with email and password.
  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref.read(loginUseCaseProvider).call(
            email: email,
            password: password,
          );
    });
  }

  /// Verifies PIN and unlocks the session.
  Future<void> verifyPin(String pin) async {
    final current = state.valueOrNull;
    if (current == null) {
      state = AsyncError(const SessionNotFoundFailure(), StackTrace.current);
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref.read(verifyPinUseCaseProvider).call(
            pin: pin,
            session: current,
          );
    });
  }

  /// Opens shift for the current session.
  Future<void> openShift() async {
    final current = state.valueOrNull;
    if (current == null) {
      return;
    }

    state = await AsyncValue.guard(() async {
      return ref.read(openShiftUseCaseProvider).call(current);
    });
  }

  /// Clears session and signs out.
  Future<void> logout() async {
    await ref.read(logoutUseCaseProvider).call();
    state = const AsyncData(null);
  }

  /// Locks PIN verification (e.g. app backgrounded).
  void lockSession() {
    final current = state.valueOrNull;
    if (current != null) {
      state = AsyncData(current.copyWith(isPinVerified: false));
    }
  }
}
