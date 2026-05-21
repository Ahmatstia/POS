import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_radius.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';
import 'package:lexa_pos/core/widgets/app_card.dart';
import 'package:lexa_pos/router/app_router.dart';

/// Manager Dashboard - Overview of the store and navigation to management tools.
class ManagerDashboardScreen extends StatelessWidget {
  const ManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        foregroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.home),
        ),
        title: const Text('Manager Dashboard', style: AppTextStyles.heading24),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
            child: AppButton.secondary(
              text: 'Exit Dashboard',
              onPressed: () => context.go(AppRoutes.home),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.s32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Today's Overview", style: AppTextStyles.heading20),
            const SizedBox(height: AppSpacing.s16),
            const Row(
              children: [
                _SummaryMetricCard(
                  title: 'Gross Sales',
                  value: 'Rp 4.250.000',
                  trend: '+12.5%',
                  isPositive: true,
                  icon: Icons.payments_outlined,
                ),
                SizedBox(width: AppSpacing.s16),
                _SummaryMetricCard(
                  title: 'Transactions',
                  value: '48',
                  trend: '+5',
                  isPositive: true,
                  icon: Icons.receipt_long_outlined,
                ),
                SizedBox(width: AppSpacing.s16),
                _SummaryMetricCard(
                  title: 'Active Products',
                  value: '124',
                  trend: '0',
                  isPositive: true,
                  icon: Icons.inventory_2_outlined,
                ),
                SizedBox(width: AppSpacing.s16),
                _SummaryMetricCard(
                  title: 'Low Stock',
                  value: '12',
                  trend: 'Requires Action',
                  isPositive: false,
                  icon: Icons.warning_amber_rounded,
                  accentColor: AppColors.warning,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s48),
            const Text('Management Tools', style: AppTextStyles.heading20),
            const SizedBox(height: AppSpacing.s16),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.s16,
              crossAxisSpacing: AppSpacing.s16,
              childAspectRatio: 2.5,
              children: [
                _ToolCard(
                  title: 'Catalog',
                  description: 'Manage products, categories, and pricing',
                  icon: Icons.category_outlined,
                  onTap: () => context.go(AppRoutes.catalog),
                ),
                _ToolCard(
                  title: 'Inventory',
                  description: 'Stock tracking, adjustments, and purchase orders',
                  icon: Icons.inventory_outlined,
                  onTap: () {},
                ),
                _ToolCard(
                  title: 'Reports',
                  description: 'Sales analytics, tax reports, and shift summaries',
                  icon: Icons.bar_chart_rounded,
                  onTap: () {},
                ),
                _ToolCard(
                  title: 'Staff',
                  description: 'User accounts, roles, and shift history',
                  icon: Icons.people_outline,
                  onTap: () {},
                ),
                _ToolCard(
                  title: 'Settings',
                  description: 'Store details, hardware, and receipts',
                  icon: Icons.settings_outlined,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryMetricCard extends StatelessWidget {
  const _SummaryMetricCard({
    required this.title,
    required this.value,
    required this.trend,
    required this.isPositive,
    required this.icon,
    this.accentColor,
  });

  final String title;
  final String value;
  final String trend;
  final bool isPositive;
  final IconData icon;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final trendColor = accentColor ?? (isPositive ? AppColors.success : AppColors.danger);
    return Expanded(
      child: AppCard(
        level: AppCardLevel.level1,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: AppTextStyles.body14.copyWith(color: AppColors.mutedText)),
                  Icon(icon, color: AppColors.mutedText, size: 20),
                ],
              ),
              const SizedBox(height: AppSpacing.s12),
              Text(value, style: AppTextStyles.heading32),
              const SizedBox(height: AppSpacing.s8),
              Row(
                children: [
                  Icon(
                    isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                    size: 14,
                    color: trendColor,
                  ),
                  const SizedBox(width: AppSpacing.s4),
                  Text(
                    trend,
                    style: AppTextStyles.body12.copyWith(
                      color: trendColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToolCard extends StatelessWidget {
  const _ToolCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: AppCard(
          level: AppCardLevel.level1,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.s12),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.button),
                  ),
                  child: Icon(icon, color: AppColors.accent, size: 28),
                ),
                const SizedBox(width: AppSpacing.s16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.heading16),
                      const SizedBox(height: AppSpacing.s4),
                      Text(
                        description,
                        style: AppTextStyles.body12.copyWith(color: AppColors.mutedText),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
