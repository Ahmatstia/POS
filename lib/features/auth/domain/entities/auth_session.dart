import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lexa_pos/features/auth/domain/entities/user.dart';

part 'auth_session.freezed.dart';
part 'auth_session.g.dart';

/// Active authenticated session including tokens and PIN verification state.
@freezed
class AuthSession with _$AuthSession {
  const factory AuthSession({
    required User user,
    required String accessToken,
    required String refreshToken,
    @Default(false) bool isPinVerified,
    @Default(false) bool isShiftOpen,
  }) = _AuthSession;

  factory AuthSession.fromJson(Map<String, dynamic> json) => _$AuthSessionFromJson(json);
}
