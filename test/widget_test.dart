import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';
import 'package:lexa_pos/features/auth/domain/entities/auth_session.dart';
import 'package:lexa_pos/features/auth/presentation/providers/auth_providers.dart';
import 'package:lexa_pos/features/auth/presentation/screens/login_screen.dart';

void main() {
  testWidgets('AppButton primary renders label', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(
            label: 'Charge',
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('Charge'), findsOneWidget);
  });

  testWidgets('Login screen renders sign in form', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authNotifierProvider.overrideWith(_IdleAuthNotifier.new),
        ],
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Sign in'), findsWidgets);
    expect(find.text('Email'), findsOneWidget);
  });
}

class _IdleAuthNotifier extends AuthNotifier {
  @override
  Future<AuthSession?> build() async => null;
}
