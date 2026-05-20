import 'package:flutter/material.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/widgets/shimmer_box.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default block', type: ShimmerBox)
Widget shimmerBoxDefaultUseCase(BuildContext context) {
  return const _ShimmerPreview(
    child: ShimmerBox(width: 200, height: AppSpacing.space16),
  );
}

@UseCase(name: 'Product card', type: ShimmerBox)
Widget shimmerBoxProductCardUseCase(BuildContext context) {
  return const _ShimmerPreview(
    child: ShimmerBox.productCard(),
  );
}

@UseCase(name: 'Text line', type: ShimmerBox)
Widget shimmerBoxTextLineUseCase(BuildContext context) {
  return const _ShimmerPreview(
    child: SizedBox(
      width: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox.textLine(),
          SizedBox(height: AppSpacing.space8),
          ShimmerBox.textLine(width: 160),
        ],
      ),
    ),
  );
}

@UseCase(name: 'Product grid', type: ShimmerBox)
Widget shimmerBoxGridUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.space24),
    child: GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: AppSpacing.space16,
      crossAxisSpacing: AppSpacing.space16,
      childAspectRatio: 3 / 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        8,
        (_) => const ShimmerBox.productCard(width: double.infinity),
      ),
    ),
  );
}

class _ShimmerPreview extends StatelessWidget {
  const _ShimmerPreview({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space24),
        child: child,
      ),
    );
  }
}
