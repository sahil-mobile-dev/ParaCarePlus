import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class LoginInfoSection extends StatelessWidget {
  const LoginInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.secondaryAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.local_hospital_rounded,
            color: AppColors.secondaryAccent,
            size: 48,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
          ),
          child: Text(
            'PARACARE+ HIMS V3.0 - ENTERPRISE EDITION',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        RichText(
          text: TextSpan(
            style: AppTextStyles.titleLarge.copyWith(fontSize: 36, height: 1.2),
            children: const [
              TextSpan(text: 'World-Class\nHealthcare '),
              TextSpan(
                text: 'Management',
                style: TextStyle(color: AppColors.secondaryAccent),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'An end-to-end, AI-enabled Hospital Information System for the Government of Uttarakhand - integrating all clinical, financial, and administrative workflows into a single unified platform.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.secondaryText,
            height: 1.5,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        _buildStatsGrid(),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: AppSpacing.md,
      crossAxisSpacing: AppSpacing.md,
      childAspectRatio: 1.25,
      children: [
        _buildStatItem('241', 'LIVE PATIENTS', Icons.people_outline_rounded),
        _buildStatItem('52', 'TODAY OPD', Icons.assignment_outlined),
        _buildStatItem('12', 'LAB PENDING', Icons.biotech_outlined),
        _buildStatItem('3', 'AMBULANCES', Icons.local_shipping_outlined),
      ],
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.card.withValues(alpha: 0.6),
            AppColors.surface.withValues(alpha: 0.2),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.secondaryAccent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.secondaryAccent, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTextStyles.titleLarge.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}
