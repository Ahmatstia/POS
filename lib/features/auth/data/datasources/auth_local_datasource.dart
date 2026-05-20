import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lexa_pos/core/constants/storage_keys.dart';
import 'package:lexa_pos/features/auth/data/models/user_model.dart';

/// Persists auth tokens and user profile in secure storage.
class AuthLocalDataSource {
  AuthLocalDataSource({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
            );

  final FlutterSecureStorage _storage;

  /// Saves session tokens and user profile.
  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required UserModel user,
    required String pinHash,
  }) async {
    await Future.wait([
      _storage.write(key: StorageKeys.accessToken, value: accessToken),
      _storage.write(key: StorageKeys.refreshToken, value: refreshToken),
      _storage.write(
        key: StorageKeys.userJson,
        value: jsonEncode(user.toJson()),
      ),
      _storage.write(key: StorageKeys.pinHash, value: pinHash),
    ]);
  }

  /// Reads stored access token, if any.
  Future<String?> readAccessToken() =>
      _storage.read(key: StorageKeys.accessToken);

  /// Reads stored refresh token, if any.
  Future<String?> readRefreshToken() =>
      _storage.read(key: StorageKeys.refreshToken);

  /// Reads stored user profile JSON.
  Future<UserModel?> readUser() async {
    final json = await _storage.read(key: StorageKeys.userJson);
    if (json == null) {
      return null;
    }
    return UserModel.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }

  /// Reads stored PIN hash for verification.
  Future<String?> readPinHash() => _storage.read(key: StorageKeys.pinHash);

  /// Persists shift open state for route guards.
  Future<void> setShiftOpen(bool isOpen) => _storage.write(
        key: StorageKeys.shiftOpen,
        value: isOpen.toString(),
      );

  /// Returns whether a shift is marked open on this device.
  Future<bool> isShiftOpen() async {
    final value = await _storage.read(key: StorageKeys.shiftOpen);
    return value == 'true';
  }

  /// Clears all auth-related secure storage keys.
  Future<void> clearSession() async {
    await Future.wait([
      _storage.delete(key: StorageKeys.accessToken),
      _storage.delete(key: StorageKeys.refreshToken),
      _storage.delete(key: StorageKeys.userJson),
      _storage.delete(key: StorageKeys.pinHash),
      _storage.delete(key: StorageKeys.shiftOpen),
    ]);
  }
}
