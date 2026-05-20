import 'package:lexa_pos/features/auth/data/models/login_response_model.dart';
import 'package:lexa_pos/features/auth/data/models/user_model.dart';

/// Thrown when mock/API login credentials are invalid.
class AuthRemoteException implements Exception {
  AuthRemoteException(this.message);

  final String message;
}

/// Remote auth API — mock implementation for offline-first development.
class AuthRemoteDataSource {
  static const _demoAccounts = <String, _DemoAccount>{
    'cashier@lexa.pos': _DemoAccount(
      password: 'cashier123',
      pinHash: '1234',
      user: UserModel(
        id: 'usr_cashier_01',
        name: 'Ayu Wijaya',
        email: 'cashier@lexa.pos',
        role: 'cashier',
        storeId: 'store_jakarta_01',
      ),
    ),
    'manager@lexa.pos': _DemoAccount(
      password: 'manager123',
      pinHash: '5678',
      user: UserModel(
        id: 'usr_manager_01',
        name: 'Budi Santoso',
        email: 'manager@lexa.pos',
        role: 'manager',
        storeId: 'store_jakarta_01',
      ),
    ),
    'owner@lexa.pos': _DemoAccount(
      password: 'owner123',
      pinHash: '9999',
      user: UserModel(
        id: 'usr_owner_01',
        name: 'Siti Rahayu',
        email: 'owner@lexa.pos',
        role: 'owner',
        storeId: 'store_jakarta_01',
      ),
    ),
  };

  /// Authenticates staff and returns tokens (mock latency included).
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));

    final account = _demoAccounts[email.trim().toLowerCase()];
    if (account == null || account.password != password) {
      throw AuthRemoteException('Invalid credentials');
    }

    return LoginResponseModel(
      user: account.user,
      accessToken: 'mock_access_${account.user.id}',
      refreshToken: 'mock_refresh_${account.user.id}',
      pinHash: account.pinHash,
    );
  }
}

class _DemoAccount {
  const _DemoAccount({
    required this.password,
    required this.pinHash,
    required this.user,
  });

  final String password;
  final String pinHash;
  final UserModel user;
}
