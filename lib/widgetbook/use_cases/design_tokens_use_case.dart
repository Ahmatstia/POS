import 'package:flutter/material.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Tokens', type: Widget)
Widget designTokensUseCase(BuildContext context) {
  return const SingleChildScrollView(
    padding: EdgeInsets.all(AppSpacing.space24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: 'Color palette'),
        SizedBox(height: AppSpacing.space16),
        _ColorSwatches(),
        SizedBox(height: AppSpacing.space32),
        _SectionTitle(title: 'Type scale'),
        SizedBox(height: AppSpacing.space16),
        _TypeScale(),
        SizedBox(height: AppSpacing.space32),
        _SectionTitle(title: 'Spacing ruler'),
        SizedBox(height: AppSpacing.space16),
        _SpacingRuler(),
      ],
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyles.title);
  }
}

class _ColorSwatches extends StatelessWidget {
  const _ColorSwatches();

  static const _swatches = <({String name, Color color})>[
    (name: 'primary', color: AppColors.primary),
    (name: 'surface', color: AppColors.surface),
    (name: 'card', color: AppColors.card),
    (name: 'accent', color: AppColors.accent),
    (name: 'accentDark', color: AppColors.accentDark),
    (name: 'success', color: AppColors.success),
    (name: 'warning', color: AppColors.warning),
    (name: 'danger', color: AppColors.danger),
    (name: 'border', color: AppColors.border),
    (name: 'muted', color: AppColors.muted),
    (name: 'subtle', color: AppColors.subtle),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.space12,
      runSpacing: AppSpacing.space12,
      children: _swatches
          .map(
            (swatch) => _ColorSwatch(
              name: swatch.name,
              color: swatch.color,
            ),
          )
          .toList(),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(name, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

class _TypeScale extends StatelessWidget {
  const _TypeScale();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('bodySmall 12px', style: AppTextStyles.bodySmall),
        const SizedBox(height: AppSpacing.space8),
        Text('caption 13px', style: AppTextStyles.caption),
        const SizedBox(height: AppSpacing.space8),
        Text('body 14px', style: AppTextStyles.body),
        const SizedBox(height: AppSpacing.space8),
        Text('label 14px medium', style: AppTextStyles.label),
        const SizedBox(height: AppSpacing.space8),
        Text('heading 16px', style: AppTextStyles.heading),
        const SizedBox(height: AppSpacing.space8),
        Text('title 20px', style: AppTextStyles.title),
        const SizedBox(height: AppSpacing.space8),
        Text('headline 24px', style: AppTextStyles.headline),
        const SizedBox(height: AppSpacing.space8),
        Text('display 32px', style: AppTextStyles.display),
        const SizedBox(height: AppSpacing.space16),
        Text('Rp 125.000', style: AppTextStyles.price),
        const SizedBox(height: AppSpacing.space8),
        Text('Rp 1.250.000', style: AppTextStyles.priceLarge),
      ],
    );
  }
}

class _SpacingRuler extends StatelessWidget {
  const _SpacingRuler();

  static const _steps = <({String label, double size})>[
    (label: '4', size: AppSpacing.space4),
    (label: '8', size: AppSpacing.space8),
    (label: '12', size: AppSpacing.space12),
    (label: '16', size: AppSpacing.space16),
    (label: '20', size: AppSpacing.space20),
    (label: '24', size: AppSpacing.space24),
    (label: '32', size: AppSpacing.space32),
    (label: '40', size: AppSpacing.space40),
    (label: '48', size: AppSpacing.space48),
    (label: '64', size: AppSpacing.space64),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _steps
          .map(
            (step) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.space8),
              child: Row(
                children: [
                  SizedBox(
                    width: 28,
                    child: Text(step.label, style: AppTextStyles.caption),
                  ),
                  Container(
                    width: step.size,
                    height: AppSpacing.space12,
                    color: AppColors.accent,
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
