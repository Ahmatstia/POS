import 'package:flutter/material.dart';
import 'package:lexa_pos/core/design/app_theme.dart';
import 'package:lexa_pos/widgetbook/widgetbook_app.dart';

/// Widgetbook catalog entry — run with: flutter run -t lib/main_widgetbook.dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTheme.configureSystemUi();
  runApp(const WidgetbookApp());
}
