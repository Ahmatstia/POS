import 'package:flutter/material.dart';
import 'package:lexa_pos/core/design/app_theme.dart';
import 'package:lexa_pos/widgetbook/widgetbook_app.directories.g.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Widgetbook catalog entry for Lexa POS design system components.
@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      lightTheme: AppTheme.material,
      darkTheme: AppTheme.material,
      themeMode: ThemeMode.light,
      appBuilder: (context, child) {
        return ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: child,
        );
      },
    );
  }
}
