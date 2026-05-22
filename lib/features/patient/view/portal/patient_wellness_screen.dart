import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientWellnessScreen extends ConsumerWidget {
  const PatientWellnessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientWellness,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('Wellness & Lifestyle'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: AppColors.primaryText),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _buildScoreRingHero(),
          const SizedBox(height: AppSpacing.md),
          const Text('DAILY ACTIVITY METRICS', style: AppTextStyles.labelSmall),
          const SizedBox(height: AppSpacing.sm),
          _buildWellnessLogCard(
            title: 'Daily Steps Counter',
            value: '4,820 / 8,000 steps',
            percentage: 0.6,
            icon: Icons.directions_walk_rounded,
            color: AppColors.success,
          ),
          _buildWellnessLogCard(
            title: 'Sleep Duration (Last Night)',
            value: '6.2 / 8.0 hours',
            percentage: 0.77,
            icon: Icons.dark_mode_rounded,
            color: AppColors.primaryLight,
          ),
          _buildWellnessLogCard(
            title: 'Daily Hydration Goal',
            value: '1.4 / 2.5 Liters',
            percentage: 0.56,
            icon: Icons.local_drink_rounded,
            color: AppColors.secondaryAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildScoreRingHero() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // Simulated score ring
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.success, width: 4),
            ),
            alignment: Alignment.center,
            child: const Text(
              '78',
              style: TextStyle(
                color: AppColors.success,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(width: 18),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('WELLNESS SCORE', style: AppTextStyles.labelSmall),
                SizedBox(height: 4),
                Text(
                  'Good Health Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Your wellness indexes increased by 3 points this month due to optimized medication adherence.',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 11,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWellnessLogCard({
    required String title,
    required String value,
    required double percentage,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.labelLarge.copyWith(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: AppTextStyles.bodyMedium),
              Text(
                '${(percentage * 100).round()}%',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: percentage,
            color: color,
            backgroundColor: AppColors.border,
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }
}
