import 'package:flutter/material.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/widgets/app_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Level 1', type: AppCard)
Widget appCardLevelOneUseCase(BuildContext context) {
  return const _CardPreview(
    child: AppCard(
      level: AppCardLevel.one,
      child: _SampleCardContent(),
    ),
  );
}

@UseCase(name: 'Level 2', type: AppCard)
Widget appCardLevelTwoUseCase(BuildContext context) {
  return const _CardPreview(
    child: AppCard(
      level: AppCardLevel.two,
      child: _SampleCardContent(),
    ),
  );
}

@UseCase(name: 'With overlay', type: AppCard)
Widget appCardOverlayUseCase(BuildContext context) {
  return const ColoredBox(
    color: Color(0xFFE2E8F0),
    child: Center(
      child: SizedBox(
        width: 320,
        child: AppCard(
          level: AppCardLevel.two,
          showOverlay: true,
          child: _SampleCardContent(),
        ),
      ),
    ),
  );
}

@UseCase(name: 'Tappable', type: AppCard)
Widget appCardTappableUseCase(BuildContext context) {
  return _CardPreview(
    child: AppCard(
      onTap: () {},
      child: const _SampleCardContent(
        subtitle: 'Tap to open detail drawer',
      ),
    ),
  );
}

class _CardPreview extends StatelessWidget {
  const _CardPreview({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 320,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space24),
          child: child,
        ),
      ),
    );
  }
}

class _SampleCardContent extends StatelessWidget {
  const _SampleCardContent({this.subtitle = 'Border elevation, no shadow'});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Transaction #1042', style: AppTextStyles.heading),
        const SizedBox(height: AppSpacing.space8),
        Text(subtitle, style: AppTextStyles.caption),
        const SizedBox(height: AppSpacing.space16),
        Text('Rp 125.000', style: AppTextStyles.price),
      ],
    );
  }
}
