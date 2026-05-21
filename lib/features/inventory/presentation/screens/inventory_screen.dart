import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_radius.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';
import 'package:lexa_pos/core/widgets/app_card.dart';
import 'package:lexa_pos/core/widgets/status_badge.dart';
import 'package:lexa_pos/router/app_router.dart';

/// Inventory Management Screen for tracking stock and doing adjustments.
class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

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
          onPressed: () => context.go(AppRoutes.manager),
        ),
        title: const Text('Inventory / Stock', style: AppTextStyles.heading24),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
            child: AppButton.secondary(
              text: 'Export CSV',
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.s32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _MetricCardsRow(),
            const SizedBox(height: AppSpacing.s24),
            const _LowStockAlertBanner(),
            const SizedBox(height: AppSpacing.s24),
            AppCard(
              level: AppCardLevel.level1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.s20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Stock List', style: AppTextStyles.heading20),
                        AppButton.secondary(
                          text: 'Filter',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.border),
                  const _InventoryTableHeader(),
                  const Divider(height: 1, color: AppColors.border),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4, // Mock data
                    separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.border),
                    itemBuilder: (context, index) {
                      return _InventoryTableRow(index: index);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricCardsRow extends StatelessWidget {
  const _MetricCardsRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _MetricCard(
          title: 'Total SKU',
          value: '124',
          icon: Icons.inventory_2_outlined,
        ),
        SizedBox(width: AppSpacing.s16),
        _MetricCard(
          title: 'Stok Rendah',
          value: '5',
          icon: Icons.warning_amber_rounded,
          isWarning: true,
        ),
        SizedBox(width: AppSpacing.s16),
        _MetricCard(
          title: 'Nilai Inventori',
          value: 'Rp 45.250.000',
          icon: Icons.monetization_on_outlined,
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    this.isWarning = false,
  });

  final String title;
  final String value;
  final IconData icon;
  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    final textColor = isWarning ? AppColors.warning : AppColors.primary;
    final iconBgColor = isWarning ? AppColors.warning.withValues(alpha: 0.1) : AppColors.accent.withValues(alpha: 0.1);
    final iconColor = isWarning ? AppColors.warning : AppColors.accent;

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
                  Text(title, style: AppTextStyles.label14.copyWith(color: AppColors.mutedText)),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.s8),
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: iconColor, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s12),
              Text(
                value,
                style: AppTextStyles.heading24.copyWith(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LowStockAlertBanner extends StatelessWidget {
  const _LowStockAlertBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.s16),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: AppColors.warning),
          const SizedBox(width: AppSpacing.s12),
          Expanded(
            child: Text(
              '5 produk mendekati batas stok minimum. Segera lakukan restock untuk menghindari kehabisan barang.',
              style: AppTextStyles.body14.copyWith(color: AppColors.warning),
            ),
          ),
          AppButton.secondary(
            text: 'Lihat Produk',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _InventoryTableHeader extends StatelessWidget {
  const _InventoryTableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20, vertical: AppSpacing.s12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text('Produk', style: AppTextStyles.label12.copyWith(color: AppColors.mutedText)),
          ),
          Expanded(
            flex: 1,
            child: Text('Stok Saat Ini', style: AppTextStyles.label12.copyWith(color: AppColors.mutedText)),
          ),
          Expanded(
            flex: 1,
            child: Text('Min. Stok', style: AppTextStyles.label12.copyWith(color: AppColors.mutedText)),
          ),
          Expanded(
            flex: 1,
            child: Text('Status', style: AppTextStyles.label12.copyWith(color: AppColors.mutedText)),
          ),
          Expanded(
            flex: 2,
            child: Text('Terakhir Diperbarui', style: AppTextStyles.label12.copyWith(color: AppColors.mutedText)),
          ),
          const SizedBox(width: 100), // Aksi
        ],
      ),
    );
  }
}

class _InventoryTableRow extends StatelessWidget {
  const _InventoryTableRow({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final isLowStock = index == 0;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20, vertical: AppSpacing.s12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              isLowStock ? 'Mie Goreng Spesial' : 'Kopi Tubruk',
              style: AppTextStyles.body14.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              isLowStock ? '4' : '120',
              style: AppTextStyles.body14.copyWith(
                color: isLowStock ? AppColors.danger : AppColors.primary,
                fontWeight: isLowStock ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text(
              '10',
              style: AppTextStyles.body14,
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: StatusBadge(
                status: isLowStock ? BadgeStatus.danger : BadgeStatus.active,
                text: isLowStock ? 'Hampir Habis' : 'Aman',
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Hari ini, 14:30',
              style: AppTextStyles.body14.copyWith(color: AppColors.mutedText),
            ),
          ),
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton.secondary(
                  text: 'Restock',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
