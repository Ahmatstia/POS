import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:lexa_pos/core/design/app_colors.dart';

import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';
import 'package:lexa_pos/core/widgets/app_card.dart';
import 'package:lexa_pos/router/app_router.dart';

/// Reports Screen for viewing analytics and sales data.
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

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
        title: const Text('Laporan & Analitik', style: AppTextStyles.heading24),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
            child: Row(
              children: [
                AppButton.secondary(
                  text: 'PDF',
                  onPressed: () {},
                ),
                const SizedBox(width: AppSpacing.s8),
                AppButton.secondary(
                  text: 'Excel',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.s32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DateRangeFilter(),
            SizedBox(height: AppSpacing.s24),
            _MetricCardsRow(),
            SizedBox(height: AppSpacing.s24),
            _RevenueChartCard(),
            SizedBox(height: AppSpacing.s24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _CategoryTableCard()),
                SizedBox(width: AppSpacing.s24),
                Expanded(child: _PaymentMethodTableCard()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DateRangeFilter extends StatelessWidget {
  const _DateRangeFilter();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      level: AppCardLevel.level1,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_today_outlined, color: AppColors.mutedText, size: 20),
            const SizedBox(width: AppSpacing.s12),
            Text('1 Mei 2026 - 7 Mei 2026', style: AppTextStyles.body14.copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(width: AppSpacing.s24),
            AppButton.primary(
              text: 'Terapkan',
              onPressed: () {},
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
          title: 'Pendapatan Hari Ini',
          value: 'Rp 4.250.000',
          trend: '+12%',
          isPositive: true,
        ),
        SizedBox(width: AppSpacing.s16),
        _MetricCard(
          title: 'Total Transaksi',
          value: '142',
          trend: '+5%',
          isPositive: true,
        ),
        SizedBox(width: AppSpacing.s16),
        _MetricCard(
          title: 'Item Terjual',
          value: '315',
          trend: '-2%',
          isPositive: false,
        ),
        SizedBox(width: AppSpacing.s16),
        _MetricCard(
          title: 'Pelanggan Baru',
          value: '12',
          trend: '+4',
          isPositive: true,
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.trend,
    required this.isPositive,
  });

  final String title;
  final String value;
  final String trend;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    final trendColor = isPositive ? AppColors.success : AppColors.danger;
    final trendIcon = isPositive ? Icons.arrow_upward : Icons.arrow_downward;

    return Expanded(
      child: AppCard(
        level: AppCardLevel.level1,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.label14.copyWith(color: AppColors.mutedText)),
              const SizedBox(height: AppSpacing.s12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value,
                    style: AppTextStyles.heading24,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(trendIcon, color: trendColor, size: 16),
                      const SizedBox(width: AppSpacing.s4),
                      Text(
                        trend,
                        style: AppTextStyles.label12.copyWith(color: trendColor),
                      ),
                    ],
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

class _RevenueChartCard extends StatelessWidget {
  const _RevenueChartCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      level: AppCardLevel.level1,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pendapatan per Hari', style: AppTextStyles.heading20),
            const SizedBox(height: AppSpacing.s24),
            SizedBox(
              height: 220,
              width: double.infinity,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 6000000,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = AppTextStyles.label12;
                          String text;
                          switch (value.toInt()) {
                            case 0: text = 'Sen'; break;
                            case 1: text = 'Sel'; break;
                            case 2: text = 'Rab'; break;
                            case 3: text = 'Kam'; break;
                            case 4: text = 'Jum'; break;
                            case 5: text = 'Sab'; break;
                            case 6: text = 'Min'; break;
                            default: text = '';
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(text, style: style.copyWith(color: AppColors.mutedText)),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 60,
                        getTitlesWidget: (value, meta) {
                          if (value == 0) return const SizedBox.shrink();
                          return Text(
                            'Rp ${(value / 1000000).toStringAsFixed(1)}M',
                            style: AppTextStyles.label12.copyWith(color: AppColors.mutedText),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 2000000,
                    getDrawingHorizontalLine: (value) => const FlLine(
                      color: AppColors.border,
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    _makeGroupData(0, 3200000),
                    _makeGroupData(1, 4100000),
                    _makeGroupData(2, 2800000),
                    _makeGroupData(3, 3900000),
                    _makeGroupData(4, 5500000),
                    _makeGroupData(5, 5100000),
                    _makeGroupData(6, 4250000),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppColors.accent,
          width: 32,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  }
}

class _CategoryTableCard extends StatelessWidget {
  const _CategoryTableCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      level: AppCardLevel.level1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(AppSpacing.s20),
            child: Text('Per Kategori', style: AppTextStyles.heading20),
          ),
          const Divider(height: 1, color: AppColors.border),
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20, vertical: AppSpacing.s12),
            child: Row(
              children: [
                Expanded(child: Text('Kategori', style: AppTextStyles.label12.copyWith(color: AppColors.mutedText))),
                Expanded(child: Text('Terjual', textAlign: TextAlign.right, style: AppTextStyles.label12.copyWith(color: AppColors.mutedText))),
                Expanded(child: Text('Pendapatan', textAlign: TextAlign.right, style: AppTextStyles.label12.copyWith(color: AppColors.mutedText))),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          _buildRow('Makanan', '145', 'Rp 2.100.000'),
          const Divider(height: 1, color: AppColors.border),
          _buildRow('Minuman', '120', 'Rp 1.450.000'),
          const Divider(height: 1, color: AppColors.border),
          _buildRow('Snack', '50', 'Rp 700.000'),
        ],
      ),
    );
  }

  Widget _buildRow(String name, String qty, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20, vertical: AppSpacing.s12),
      child: Row(
        children: [
          Expanded(child: Text(name, style: AppTextStyles.body14.copyWith(fontWeight: FontWeight.w500))),
          Expanded(child: Text(qty, textAlign: TextAlign.right, style: AppTextStyles.body14)),
          Expanded(child: Text(amount, textAlign: TextAlign.right, style: AppTextStyles.body14.copyWith(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}

class _PaymentMethodTableCard extends StatelessWidget {
  const _PaymentMethodTableCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      level: AppCardLevel.level1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(AppSpacing.s20),
            child: Text('Per Metode Pembayaran', style: AppTextStyles.heading20),
          ),
          const Divider(height: 1, color: AppColors.border),
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20, vertical: AppSpacing.s12),
            child: Row(
              children: [
                Expanded(child: Text('Metode', style: AppTextStyles.label12.copyWith(color: AppColors.mutedText))),
                Expanded(child: Text('Transaksi', textAlign: TextAlign.right, style: AppTextStyles.label12.copyWith(color: AppColors.mutedText))),
                Expanded(child: Text('Total', textAlign: TextAlign.right, style: AppTextStyles.label12.copyWith(color: AppColors.mutedText))),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          _buildRow('QRIS', '85', 'Rp 2.800.000'),
          const Divider(height: 1, color: AppColors.border),
          _buildRow('Tunai', '42', 'Rp 950.000'),
          const Divider(height: 1, color: AppColors.border),
          _buildRow('Kartu Debit', '15', 'Rp 500.000'),
        ],
      ),
    );
  }

  Widget _buildRow(String name, String qty, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20, vertical: AppSpacing.s12),
      child: Row(
        children: [
          Expanded(child: Text(name, style: AppTextStyles.body14.copyWith(fontWeight: FontWeight.w500))),
          Expanded(child: Text(qty, textAlign: TextAlign.right, style: AppTextStyles.body14)),
          Expanded(child: Text(amount, textAlign: TextAlign.right, style: AppTextStyles.body14.copyWith(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
