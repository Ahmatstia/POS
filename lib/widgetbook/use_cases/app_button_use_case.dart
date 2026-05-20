import 'package:flutter/material.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Primary', type: AppButton)
Widget appButtonPrimaryUseCase(BuildContext context) {
  return _ButtonPreview(
    child: AppButton(
      label: 'Charge',
      onPressed: _noop,
      variant: AppButtonVariant.primary,
    ),
  );
}

@UseCase(name: 'Secondary', type: AppButton)
Widget appButtonSecondaryUseCase(BuildContext context) {
  return _ButtonPreview(
    child: AppButton(
      label: 'Hold order',
      onPressed: _noop,
      variant: AppButtonVariant.secondary,
    ),
  );
}

@UseCase(name: 'Tertiary', type: AppButton)
Widget appButtonTertiaryUseCase(BuildContext context) {
  return _ButtonPreview(
    child: AppButton(
      label: 'View details',
      onPressed: _noop,
      variant: AppButtonVariant.tertiary,
    ),
  );
}

@UseCase(name: 'Danger', type: AppButton)
Widget appButtonDangerUseCase(BuildContext context) {
  return _ButtonPreview(
    child: AppButton(
      label: 'Void transaction',
      onPressed: _noop,
      variant: AppButtonVariant.danger,
    ),
  );
}

@UseCase(name: 'Icon', type: AppButton)
Widget appButtonIconUseCase(BuildContext context) {
  return _ButtonPreview(
    child: AppButton(
      label: 'Search',
      icon: Icons.search,
      semanticsLabel: 'Search products',
      onPressed: _noop,
      variant: AppButtonVariant.icon,
    ),
  );
}

@UseCase(name: 'Loading', type: AppButton)
Widget appButtonLoadingUseCase(BuildContext context) {
  return _ButtonPreview(
    child: AppButton(
      label: 'Processing',
      onPressed: _noop,
      isLoading: true,
    ),
  );
}

@UseCase(name: 'Expanded', type: AppButton)
Widget appButtonExpandedUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.space24),
    child: AppButton(
      label: 'Charge Rp 125.000',
      onPressed: _noop,
      isExpanded: true,
    ),
  );
}

@UseCase(name: 'Disabled', type: AppButton)
Widget appButtonDisabledUseCase(BuildContext context) {
  return const _ButtonPreview(
    child: AppButton(
      label: 'Charge',
      onPressed: null,
    ),
  );
}

class _ButtonPreview extends StatelessWidget {
  const _ButtonPreview({required this.child});

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

void _noop() {}
