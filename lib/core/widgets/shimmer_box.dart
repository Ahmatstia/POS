import 'package:flutter/material.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_radius.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:shimmer/shimmer.dart';

/// Reusable skeleton block matching real content layout during loading.
class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    this.width,
    this.height = AppSpacing.space16,
    this.borderRadius = AppRadius.input,
  });

  /// Product grid card skeleton — 3:4 aspect ratio preset.
  const ShimmerBox.productCard({
    super.key,
    this.width = 120,
  })  : height = 160,
        borderRadius = AppRadius.card;

  /// Single-line text skeleton preset.
  const ShimmerBox.textLine({
    super.key,
    this.width = double.infinity,
  })  : height = AppSpacing.space12,
        borderRadius = AppRadius.chip;

  final double? width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.border,
      highlightColor: AppColors.card,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.border,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
