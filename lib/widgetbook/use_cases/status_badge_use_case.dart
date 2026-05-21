import 'package:flutter/material.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/widgets/status_badge.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Active', type: StatusBadge)
Widget statusBadgeActiveUseCase(BuildContext context) {
  return const _BadgePreview(
    child: StatusBadge(text: 'In stock', status: BadgeStatus.active),
  );
}

@UseCase(name: 'Inactive', type: StatusBadge)
Widget statusBadgeInactiveUseCase(BuildContext context) {
  return const _BadgePreview(
    child: StatusBadge(text: 'Archived', status: BadgeStatus.inactive),
  );
}

@UseCase(name: 'Warning', type: StatusBadge)
Widget statusBadgeWarningUseCase(BuildContext context) {
  return const _BadgePreview(
    child: StatusBadge(text: 'Low stock', status: BadgeStatus.warning),
  );
}

@UseCase(name: 'Danger', type: StatusBadge)
Widget statusBadgeDangerUseCase(BuildContext context) {
  return const _BadgePreview(
    child: StatusBadge(text: 'Out of stock', status: BadgeStatus.danger),
  );
}

@UseCase(name: 'All variants', type: StatusBadge)
Widget statusBadgeAllUseCase(BuildContext context) {
  return const _BadgePreview(
    child: Wrap(
      spacing: AppSpacing.s12,
      runSpacing: AppSpacing.s12,
      children: [
        StatusBadge(text: 'In stock', status: BadgeStatus.active),
        StatusBadge(text: 'Draft', status: BadgeStatus.inactive),
        StatusBadge(text: 'Low stock', status: BadgeStatus.warning),
        StatusBadge(text: 'Voided', status: BadgeStatus.danger),
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
        padding: const EdgeInsets.all(AppSpacing.s24),
        child: child,
      ),
    );
  }
}
