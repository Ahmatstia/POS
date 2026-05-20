import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexa_pos/router/app_router.dart';

/// Lexa POS application root with Riverpod scope.
class LexaPosRoot extends StatelessWidget {
  const LexaPosRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: LexaPosApp(),
    );
  }
}
