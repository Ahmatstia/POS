import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';
import 'package:lexa_pos/core/widgets/app_card.dart';
import 'package:lexa_pos/core/widgets/app_text_field.dart';
import 'package:lexa_pos/router/app_router.dart';

/// Customer Management Screen for viewing and managing customers.
class CustomerManagementScreen extends StatelessWidget {
  const CustomerManagementScreen({super.key});

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
        title: const Text('Manajemen Pelanggan', style: AppTextStyles.heading24),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
            child: AppButton.primary(
              text: 'Tambah Pelanggan',
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.s32),
        child: AppCard(
          level: AppCardLevel.level1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.s20),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: AppTextField(
                        name: 'search',
                        label: 'Cari Pelanggan',
                        hintText: 'Nama atau No. HP',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.s16),
                    Expanded(
                      flex: 1,
                      child: AppButton.secondary(
                        text: 'Filter',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.border),
              const _CustomerTableHeader(),
              const Divider(height: 1, color: AppColors.border),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.border),
                itemBuilder: (context, index) {
                  return _CustomerTableRow(index: index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomerTableHeader extends StatelessWidget {
  const _CustomerTableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20, vertical: AppSpacing.s12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text('Nama', style: AppTextStyles.label12.copyWith(color: AppColors.mutedText)),
          ),
          Expanded(
            flex: 2,
            child: Text('No. HP', style: AppTextStyles.label12.copyWith(color: AppColors.mutedText)),
          ),
          Expanded(
            flex: 2,
            child: Text('Total Belanja', style: AppTextStyles.label12.copyWith(color: AppColors.mutedText)),
          ),
          Expanded(
            flex: 1,
            child: Text('Kunjungan', style: AppTextStyles.label12.copyWith(color: AppColors.mutedText)),
          ),
          Expanded(
            flex: 2,
            child: Text('Poin Loyalti', style: AppTextStyles.label12.copyWith(color: AppColors.mutedText)),
          ),
          const SizedBox(width: 80), // Aksi
        ],
      ),
    );
  }
}

class _CustomerTableRow extends StatelessWidget {
  const _CustomerTableRow({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final names = [
      'Budi Santoso',
      'Siti Aminah',
      'Andi Saputra',
      'Dewi Lestari',
      'Rina Wati',
      'Agus Setiawan'
    ];
    final phones = [
      '0812-3456-7890',
      '0856-7890-1234',
      '0811-2233-4455',
      '0899-8877-6655',
      '0877-1234-5678',
      '0821-9876-5432'
    ];
    final totals = [
      'Rp 2.450.000',
      'Rp 1.200.000',
      'Rp 3.100.000',
      'Rp 850.000',
      'Rp 1.750.000',
      'Rp 5.250.000'
    ];
    final visits = ['12', '5', '18', '3', '8', '25'];
    final points = ['1.250', '600', '1.550', '425', '875', '2.625'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20, vertical: AppSpacing.s12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              names[index],
              style: AppTextStyles.body14.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              phones[index],
              style: AppTextStyles.body14.copyWith(color: AppColors.mutedText),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              totals[index],
              style: AppTextStyles.body14,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              visits[index],
              style: AppTextStyles.body14,
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                const Icon(Icons.star, color: AppColors.warning, size: 16),
                const SizedBox(width: AppSpacing.s4),
                Text(
                  '${points[index]} poin',
                  style: AppTextStyles.body14.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.warning,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.mutedText),
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
