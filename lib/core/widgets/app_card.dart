import 'package:flutter/material.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_radius.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';

/// Elevation level for [AppCard] — border-based, no drop shadows.
enum AppCardLevel {
  one,
  two,
}

/// Border-based card surface for lists, panels, and sheets.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.level = AppCardLevel.one,
    this.padding = const EdgeInsets.all(AppSpacing.space16),
    this.onTap,
    this.showOverlay = false,
  });

  final Widget child;
  final AppCardLevel level;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final bool showOverlay;

  @override
  Widget build(BuildContext context) {
    final card = _CardSurface(
      level: level,
      padding: padding,
      onTap: onTap,
      child: child,
    );

    if (!showOverlay) {
      return card;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Positioned.fill(
          child: ColoredBox(color: AppColors.sheetOverlay),
        ),
        card,
      ],
    );
  }
}

class _CardSurface extends StatelessWidget {
  const _CardSurface({
    required this.child,
    required this.level,
    required this.padding,
    this.onTap,
  });

  final Widget child;
  final AppCardLevel level;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor =
        level == AppCardLevel.one ? AppColors.border : AppColors.borderStrong;

    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: child,
    );

    if (onTap == null) {
      return content;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: content,
      ),
    );
  }
}
