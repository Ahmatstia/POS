import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Convenience extensions on [BuildContext] for navigation and theming.
extension BuildContextExtensions on BuildContext {
  /// Navigates using GoRouter.
  void goNamed(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) {
    GoRouter.of(this).goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  /// Shows a modal bottom sheet with Lexa surface styling.
  Future<T?> showLexaBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (context) => child,
    );
  }
}
