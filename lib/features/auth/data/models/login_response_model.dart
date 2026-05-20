import 'package:lexa_pos/features/auth/data/models/user_model.dart';

/// API response payload for successful login.
class LoginResponseModel {
  const LoginResponseModel({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.pinHash,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      pinHash: json['pin_hash'] as String,
    );
  }

  final UserModel user;
  final String accessToken;
  final String refreshToken;
  final String pinHash;
}
