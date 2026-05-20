import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexa_pos/core/design/app_theme.dart';
import 'package:lexa_pos/features/auth/domain/entities/user_role.dart';
import 'package:lexa_pos/features/auth/presentation/providers/auth_providers.dart';
import 'package:lexa_pos/features/auth/presentation/screens/login_screen.dart';
import 'package:lexa_pos/features/auth/presentation/screens/open_shift_screen.dart';
import 'package:lexa_pos/features/auth/presentation/screens/pin_lock_screen.dart';
import 'package:lexa_pos/features/home/presentation/screens/home_shell_screen.dart';
import 'package:lexa_pos/features/home/presentation/screens/manager_dashboard_screen.dart';

/// Route path constants for deep links and navigation.
abstract final class AppRoutes {
  static const String login = '/login';
  static const String pin = '/pin';
  static const String shift = '/shift';
  static const String home = '/home';
  static const String manager = '/manager';
}

/// Provides the application [GoRouter] with auth, PIN, shift, and role guards.
final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.pin,
        name: 'pin',
        builder: (context, state) => const PinLockScreen(),
      ),
      GoRoute(
        path: AppRoutes.shift,
        name: 'shift',
        builder: (context, state) => const OpenShiftScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeShellScreen(),
      ),
      GoRoute(
        path: AppRoutes.manager,
        name: 'manager',
        builder: (context, state) => const ManagerDashboardScreen(),
      ),
    ],
    redirect: (context, state) {
      final location = state.matchedLocation;
      final session = authState.valueOrNull;
      final isAuthLoading = authState.isLoading && !authState.hasValue;

      if (isAuthLoading) {
        return null;
      }

      if (session == null) {
        return location == AppRoutes.login ? null : AppRoutes.login;
      }

      if (!session.isPinVerified) {
        return location == AppRoutes.pin ? null : AppRoutes.pin;
      }

      if (!session.isShiftOpen) {
        return location == AppRoutes.shift ? null : AppRoutes.shift;
      }

      if (location == AppRoutes.manager && !session.user.role.isManagerOrAbove) {
        return AppRoutes.home;
      }

      if (location == AppRoutes.login ||
          location == AppRoutes.pin ||
          location == AppRoutes.shift) {
        return AppRoutes.home;
      }

      return null;
    },
  );
});

/// Root app widget wired to [GoRouter].
class LexaPosApp extends ConsumerWidget {
  const LexaPosApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Lexa POS',
      theme: AppTheme.material,
      routerConfig: router,
    );
  }
}
