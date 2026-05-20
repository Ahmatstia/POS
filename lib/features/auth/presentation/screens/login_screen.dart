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
                padding: const EdgeInsets.all(AppSpacing.space48),
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
      padding: const EdgeInsets.all(AppSpacing.space48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppConfig.appName,
            style: AppTextStyles.display.copyWith(color: AppColors.onAccent),
          ),
          const SizedBox(height: AppSpacing.space16),
          Text(
            'Fast, trustworthy point of sale for Southeast Asia merchants.',
            style: AppTextStyles.body.copyWith(
              color: AppColors.subtle,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Sign in', style: AppTextStyles.title),
          const SizedBox(height: AppSpacing.space8),
          Text(
            'Use your staff credentials to access this terminal.',
            style: AppTextStyles.body.copyWith(color: AppColors.muted),
          ),
          if (errorMessage != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.space12),
              decoration: BoxDecoration(
                color: AppColors.dangerMuted,
                borderRadius: BorderRadius.circular(AppRadius.input),
                border: Border.all(color: AppColors.danger),
              ),
              child: Text(
                errorMessage!,
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.danger),
              ),
            ),
            const SizedBox(height: AppSpacing.space20),
          ],
          const SizedBox(height: AppSpacing.space32),
          AppTextField(
            key: emailKey,
            name: 'email',
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofocus: true,
            validator: Validators.email,
          ),
          const SizedBox(height: AppSpacing.space20),
          AppTextField(
            key: passwordKey,
            name: 'password',
            label: 'Password',
            obscureText: true,
            textInputAction: TextInputAction.done,
            validator: Validators.password,
            onSubmitted: (_) => onSubmit(),
          ),
          const SizedBox(height: AppSpacing.space32),
          AppButton(
            label: 'Sign in',
            onPressed: onSubmit,
            isExpanded: true,
          ),
          const SizedBox(height: AppSpacing.space24),
          Text(
            'Demo: cashier@lexa.pos / cashier123',
            style: AppTextStyles.caption,
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
      child: const AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ShimmerBox(width: 120, height: AppSpacing.space24),
            SizedBox(height: AppSpacing.space12),
            ShimmerBox(height: AppSpacing.space12),
            SizedBox(height: AppSpacing.space32),
            ShimmerBox(height: AppSpacing.space48),
            SizedBox(height: AppSpacing.space20),
            ShimmerBox(height: AppSpacing.space48),
            SizedBox(height: AppSpacing.space32),
            ShimmerBox(height: AppSpacing.space48),
          ],
        ),
      ),
    );
  }
}
