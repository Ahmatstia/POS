import 'package:flutter/material.dart';
import 'package:lexa_pos/app.dart';
import 'package:lexa_pos/core/design/app_theme.dart';

/// Lexa POS production entry point.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTheme.configureSystemUi();
  runApp(const LexaPosRoot());
}
