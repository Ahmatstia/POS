import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexa_pos/core/constants/app_config.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_radius.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/utils/validators.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';
import 'package:lexa_pos/core/widgets/app_card.dart';
import 'package:lexa_pos/core/widgets/app_text_field.dart';
import 'package:lexa_pos/core/widgets/shimmer_box.dart';
import 'package:lexa_pos/features/auth/domain/failures/auth_failure.dart';
import 'package:lexa_pos/features/auth/presentation/providers/auth_providers.dart';
import 'package:shimmer/shimmer.dart';

/// Staff email/password sign-in screen.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailKey = GlobalKey<AppTextFieldState>();
  final _passwordKey = GlobalKey<AppTextFieldState>();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;

    final failure = authState.error is AuthFailure
        ? authState.error! as AuthFailure
        : null;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Row(
        children: [
          const Expanded(child: _BrandPanel()),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.s48),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: isLoading
                      ? const _LoginFormSkeleton()
                      : _LoginForm(
                          emailKey: _emailKey,
                          passwordKey: _passwordKey,
                          onSubmit: _submit,
                          errorMessage: failure?.message,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final emailValid = _emailKey.currentState?.validate() ?? false;
    final passwordValid = _passwordKey.currentState?.validate() ?? false;
    if (!emailValid || !passwordValid) {
      return;
    }

    await ref.read(authNotifierProvider.notifier).login(
          email: _emailKey.currentState!.value!.trim(),
          password: _passwordKey.currentState!.value!,
        );
  }
}

class _BrandPanel extends StatelessWidget {
  const _BrandPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.all(AppSpacing.s48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppConfig.appName,
            style: AppTextStyles.heading32.copyWith(color: AppColors.card),
          ),
          const SizedBox(height: AppSpacing.s16),
          Text(
            'Fast, trustworthy point of sale for Southeast Asia merchants.',
            style: AppTextStyles.body16.copyWith(
              color: AppColors.subtleText,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.emailKey,
    required this.passwordKey,
    required this.onSubmit,
    this.errorMessage,
  });

  final GlobalKey<AppTextFieldState> emailKey;
  final GlobalKey<AppTextFieldState> passwordKey;
  final VoidCallback onSubmit;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.s32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Sign in', style: AppTextStyles.heading24),
          const SizedBox(height: AppSpacing.s8),
          Text(
            'Use your staff credentials to access this terminal.',
            style: AppTextStyles.body14.copyWith(color: AppColors.mutedText),
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: AppSpacing.s24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.s12),
              decoration: BoxDecoration(
                color: AppColors.danger.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.input),
                border: Border.all(color: AppColors.danger),
              ),
              child: Text(
                errorMessage!,
                style: AppTextStyles.body12.copyWith(color: AppColors.danger),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.s32),
          AppTextField(
            key: emailKey,
            name: 'email',
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofocus: true,
            validator: Validators.email,
          ),
          const SizedBox(height: AppSpacing.s20),
          AppTextField(
            key: passwordKey,
            name: 'password',
            label: 'Password',
            obscureText: true,
            textInputAction: TextInputAction.done,
            validator: Validators.password,
            onSubmitted: (_) => onSubmit(),
          ),
          const SizedBox(height: AppSpacing.s32),
          SizedBox(
            width: double.infinity,
            child: AppButton.primary(
              text: 'Sign in',
              onPressed: onSubmit,
            ),
          ),
          const SizedBox(height: AppSpacing.s24),
          Text(
            'Demo: cashier@lexa.pos / cashier123',
            style: AppTextStyles.body12.copyWith(color: AppColors.subtleText),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _LoginFormSkeleton extends StatelessWidget {
  const _LoginFormSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.border,
      highlightColor: AppColors.card,
      child: AppCard(
        padding: const EdgeInsets.all(AppSpacing.s32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            ShimmerBox(width: 120, height: AppSpacing.s24),
            SizedBox(height: AppSpacing.s12),
            ShimmerBox(width: double.infinity, height: AppSpacing.s12),
            SizedBox(height: AppSpacing.s32),
            ShimmerBox(width: double.infinity, height: AppSpacing.s48),
            SizedBox(height: AppSpacing.s20),
            ShimmerBox(width: double.infinity, height: AppSpacing.s48),
            SizedBox(height: AppSpacing.s32),
            ShimmerBox(width: double.infinity, height: AppSpacing.s48),
          ],
        ),
      ),
    );
  }
}
