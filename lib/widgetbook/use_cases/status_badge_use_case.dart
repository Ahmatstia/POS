import 'package:flutter/material.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/widgets/status_badge.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Active', type: StatusBadge)
Widget statusBadgeActiveUseCase(BuildContext context) {
  return const _BadgePreview(
    child: StatusBadge(label: 'In stock', type: StatusBadgeType.active),
  );
}

@UseCase(name: 'Inactive', type: StatusBadge)
Widget statusBadgeInactiveUseCase(BuildContext context) {
  return const _BadgePreview(
    child: StatusBadge(label: 'Archived', type: StatusBadgeType.inactive),
  );
}

@UseCase(name: 'Warning', type: StatusBadge)
Widget statusBadgeWarningUseCase(BuildContext context) {
  return const _BadgePreview(
    child: StatusBadge(label: 'Low stock', type: StatusBadgeType.warning),
  );
}

@UseCase(name: 'Danger', type: StatusBadge)
Widget statusBadgeDangerUseCase(BuildContext context) {
  return const _BadgePreview(
    child: StatusBadge(label: 'Out of stock', type: StatusBadgeType.danger),
  );
}

@UseCase(name: 'All variants', type: StatusBadge)
Widget statusBadgeAllUseCase(BuildContext context) {
  return const _BadgePreview(
    child: Wrap(
      spacing: AppSpacing.space12,
      runSpacing: AppSpacing.space12,
      children: [
        StatusBadge(label: 'In stock', type: StatusBadgeType.active),
        StatusBadge(label: 'Draft', type: StatusBadgeType.inactive),
        StatusBadge(label: 'Low stock', type: StatusBadgeType.warning),
        StatusBadge(label: 'Voided', type: StatusBadgeType.danger),
      ],
    ),
  );
}

class _BadgePreview extends StatelessWidget {
  const _BadgePreview({required this.child});

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
