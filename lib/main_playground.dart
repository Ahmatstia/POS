import 'package:flutter/material.dart';
import 'core/design/app_colors.dart';
import 'core/design/app_spacing.dart';
import 'core/design/app_text_styles.dart';
import 'core/design/app_theme.dart';
import 'core/widgets/app_button.dart';
import 'core/widgets/app_card.dart';
import 'core/widgets/status_badge.dart';
import 'core/widgets/shimmer_box.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTheme.configureSystemUi();
  runApp(const PlaygroundApp());
}

class PlaygroundApp extends StatelessWidget {
  const PlaygroundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design System Playground',
      theme: AppTheme.material,
      debugShowCheckedModeBanner: false,
      home: const DesignPlaygroundScreen(),
    );
  }
}

class DesignPlaygroundScreen extends StatelessWidget {
  const DesignPlaygroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text('Module 1: Design System', style: AppTextStyles.heading20),
        backgroundColor: AppColors.card,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.s24),
        children: [
          _buildSectionTitle('Typography & Colors'),
          Text('Heading 32', style: AppTextStyles.heading32),
          Text('Heading 24', style: AppTextStyles.heading24),
          Text('Heading 20', style: AppTextStyles.heading20),
          Text('Heading 16', style: AppTextStyles.heading16),
          Text('Body 16', style: AppTextStyles.body16),
          Text('Label 14', style: AppTextStyles.label14),
          const SizedBox(height: AppSpacing.s8),
          Text('Rp 125.000', style: AppTextStyles.price(24)),
          const SizedBox(height: AppSpacing.s32),

          _buildSectionTitle('Buttons (AppButton)'),
          Wrap(
            spacing: AppSpacing.s16,
            runSpacing: AppSpacing.s16,
            children: [
              AppButton.primary(text: 'Primary Button', onPressed: () {}),
              AppButton.secondary(text: 'Secondary Button', onPressed: () {}),
              AppButton.tertiary(text: 'Tertiary Button', onPressed: () {}),
              AppButton.danger(text: 'Danger Button', onPressed: () {}),
              AppButton.icon(icon: Icons.add, onPressed: () {}),
              AppButton.primary(text: 'Loading...', isLoading: true, onPressed: () {}),
            ],
          ),
          const SizedBox(height: AppSpacing.s32),

          _buildSectionTitle('Status Badges (StatusBadge)'),
          Wrap(
            spacing: AppSpacing.s12,
            children: const [
              StatusBadge(text: 'Active', status: BadgeStatus.active),
              StatusBadge(text: 'Inactive', status: BadgeStatus.inactive),
              StatusBadge(text: 'Warning', status: BadgeStatus.warning),
              StatusBadge(text: 'Danger', status: BadgeStatus.danger),
            ],
          ),
          const SizedBox(height: AppSpacing.s32),

          _buildSectionTitle('Cards (AppCard) & Skeletons (ShimmerBox)'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppCard(
                  level: AppCardLevel.level1,
                  padding: const EdgeInsets.all(AppSpacing.s16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Level 1 Card', style: AppTextStyles.heading16),
                      const SizedBox(height: AppSpacing.s8),
                      Text('Used for standard surfaces.', style: AppTextStyles.body14.copyWith(color: AppColors.mutedText)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.s16),
              Expanded(
                child: AppCard(
                  level: AppCardLevel.level2,
                  padding: const EdgeInsets.all(AppSpacing.s16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Level 2 Card', style: AppTextStyles.heading16),
                      const SizedBox(height: AppSpacing.s8),
                      Text('Used for floating elements like sheets.', style: AppTextStyles.body14.copyWith(color: AppColors.mutedText)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.s16),
              const Expanded(
                child: ShimmerBox(width: double.infinity, height: 80),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s16),
      child: Text(title, style: AppTextStyles.heading20.copyWith(color: AppColors.accent)),
    );
  }
}
