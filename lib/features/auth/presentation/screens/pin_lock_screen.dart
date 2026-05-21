import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexa_pos/core/constants/app_config.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/widgets/app_error_view.dart';
import 'package:lexa_pos/features/auth/domain/failures/auth_failure.dart';
import 'package:lexa_pos/features/auth/presentation/providers/auth_providers.dart';
import 'package:lexa_pos/features/auth/presentation/widgets/pin_pad.dart';
import 'package:lexa_pos/features/auth/presentation/widgets/role_badge.dart';

/// PIN verification gate after login or app resume.
class PinLockScreen extends ConsumerStatefulWidget {
  const PinLockScreen({super.key});

  @override
  ConsumerState<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends ConsumerState<PinLockScreen> {
  var _pin = '';
  var _shakeTrigger = 0;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final session = authState.valueOrNull;

    ref.listen(authNotifierProvider, (previous, next) {
      if (next.hasError && next.error is InvalidPinFailure) {
        HapticFeedback.vibrate();
        setState(() {
          _pin = '';
          _shakeTrigger++;
        });
      }
    });

    if (authState.hasError && authState.error is! InvalidPinFailure) {
      final failure = authState.error is AuthFailure
          ? authState.error! as AuthFailure
          : const AuthUnexpectedFailure();
      return Scaffold(
        backgroundColor: AppColors.surface,
        body: AppErrorView(
          title: 'Unable to verify PIN',
          message: failure.message,
          errorCode: failure.code,
          onRetry: () => ref.invalidate(authNotifierProvider),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (session != null) RoleBadge(role: session.user.role),
              const SizedBox(height: AppSpacing.s16),
              Text(
                session?.user.name ?? 'Staff',
                style: AppTextStyles.heading24,
              ),
              const SizedBox(height: AppSpacing.s8),
              Text(
                'Enter your PIN to continue',
                style: AppTextStyles.body14.copyWith(color: AppColors.mutedText),
              ),
              const SizedBox(height: AppSpacing.s32),
              PinDots(
                length: AppConfig.pinLength,
                filled: _pin.length,
              ),
              const SizedBox(height: AppSpacing.s48),
              PinPad(
                shakeTrigger: _shakeTrigger,
                onDigit: _onDigit,
                onBackspace: _onBackspace,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onDigit(String digit) {
    if (_pin.length >= AppConfig.pinLength) {
      return;
    }
    setState(() => _pin += digit);
    if (_pin.length == AppConfig.pinLength) {
      ref.read(authNotifierProvider.notifier).verifyPin(_pin);
    }
  }

  void _onBackspace() {
    if (_pin.isEmpty) {
      return;
    }
    setState(() => _pin = _pin.substring(0, _pin.length - 1));
  }
}
