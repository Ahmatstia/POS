import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_radius.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';
import 'package:lexa_pos/core/widgets/app_card.dart';
import 'package:lexa_pos/core/widgets/app_text_field.dart';
import 'package:lexa_pos/router/app_router.dart';

/// Settings Screen for configuring the store, printer, and access.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
        title: const Text('Pengaturan', style: AppTextStyles.heading24),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Sidebar (Categories)
          Container(
            width: 280,
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(right: BorderSide(color: AppColors.border)),
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.s16),
              children: const [
                _SettingsCategoryItem(title: 'Profil Toko', icon: Icons.store_outlined, isActive: true),
                _SettingsCategoryItem(title: 'Pajak & Biaya', icon: Icons.receipt_long_outlined, isActive: false),
                _SettingsCategoryItem(title: 'Printer', icon: Icons.print_outlined, isActive: false),
                _SettingsCategoryItem(title: 'Pengguna & Akses', icon: Icons.admin_panel_settings_outlined, isActive: false),
                _SettingsCategoryItem(title: 'Integrasi', icon: Icons.extension_outlined, isActive: false),
                _SettingsCategoryItem(title: 'Tentang', icon: Icons.info_outline, isActive: false),
              ],
            ),
          ),
          
          // Right Panel (Active Settings)
          const Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppSpacing.s32),
              child: _StoreProfilePanel(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsCategoryItem extends StatelessWidget {
  const _SettingsCategoryItem({
    required this.title,
    required this.icon,
    required this.isActive,
  });

  final String title;
  final IconData icon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final bgColor = isActive ? AppColors.accent.withValues(alpha: 0.1) : Colors.transparent;
    final textColor = isActive ? AppColors.accent : AppColors.mutedText;
    final iconColor = isActive ? AppColors.accent : AppColors.mutedText;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.s16, vertical: AppSpacing.s4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title, style: AppTextStyles.body14.copyWith(color: textColor, fontWeight: isActive ? FontWeight.w600 : FontWeight.w400)),
        onTap: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.card)),
      ),
    );
  }
}

class _StoreProfilePanel extends StatelessWidget {
  const _StoreProfilePanel();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      level: AppCardLevel.level1,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Profil Toko', style: AppTextStyles.heading20),
            const SizedBox(height: AppSpacing.s8),
            Text('Kelola informasi dasar toko yang akan ditampilkan di struk.', style: AppTextStyles.body14.copyWith(color: AppColors.mutedText)),
            const SizedBox(height: AppSpacing.s32),
            
            // Logo Upload Area
            const Text('Logo Toko', style: AppTextStyles.label14),
            const SizedBox(height: AppSpacing.s12),
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Center(
                    child: Icon(Icons.storefront, size: 40, color: AppColors.subtleText),
                  ),
                ),
                const SizedBox(width: AppSpacing.s24),
                AppButton.secondary(
                  text: 'Unggah Logo',
                  onPressed: () {},
                ),
                const SizedBox(width: AppSpacing.s16),
                Text('Format JPG, PNG (Maks 2MB)', style: AppTextStyles.label12.copyWith(color: AppColors.mutedText)),
              ],
            ),
            const SizedBox(height: AppSpacing.s32),
            
            // Form Fields
            const AppTextField(
              name: 'store_name',
              label: 'Nama Toko',
              hintText: 'Contoh: Kopi Lexa Jakarta',
            ),
            const SizedBox(height: AppSpacing.s24),
            const AppTextField(
              name: 'address',
              label: 'Alamat Lengkap',
              hintText: 'Jalan, RT/RW, Kota, Kode Pos',
            ),
            const SizedBox(height: AppSpacing.s24),
            const Row(
              children: [
                Expanded(
                  child: AppTextField(
                    name: 'npwp',
                    label: 'No. NPWP',
                    hintText: 'Masukkan NPWP toko',
                  ),
                ),
                SizedBox(width: AppSpacing.s24),
                Expanded(
                  child: AppTextField(
                    name: 'operating_hours',
                    label: 'Jam Operasional',
                    hintText: 'Contoh: 08:00 - 22:00',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s48),
            
            // Save Button
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: AppSpacing.s24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton.primary(
                  text: 'Simpan Perubahan',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
