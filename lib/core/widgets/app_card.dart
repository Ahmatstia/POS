import 'package:flutter/material.dart';
import '../design/app_colors.dart';

enum AppCardLevel {
  level1,
  level2,
}

/// A custom card component that adheres to the elevation model rules.
/// Level 1: White + 1px slate-200 border
/// Level 2: White + 1px slate-300 border + slight darken overlay behind
class AppCard extends StatelessWidget {
  final Widget child;
  final AppCardLevel level;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.level = AppCardLevel.level1,
    this.padding,
    this.margin,
    this.borderRadius = 12.0, // Strict 12px
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderCol = level == AppCardLevel.level1
        ? AppColors.border
        : const Color(0xFFCBD5E1); // slate-300

    final cardContent = Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderCol,
          width: 1,
        ),
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: cardContent,
      );
    }

    return cardContent;
  }
}
