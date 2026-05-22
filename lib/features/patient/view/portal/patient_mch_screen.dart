import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientMchScreen extends ConsumerWidget {
  const PatientMchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(activeRouteName: RouteNames.patientMch),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('Women & Child Care (MCH)'),
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
          _buildPrenatalProfileBanner(),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'PREGNANCY MILESTONES CALENDAR',
            style: AppTextStyles.labelSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildMilestoneCard(
            week: 'Week 24 Milestone',
            desc:
                'Fetal hearing developed. Regularly monitor movements twice daily.',
            status: 'COMPLETED',
            statusColor: AppColors.success,
          ),
          _buildMilestoneCard(
            week: 'Week 28 Milestone',
            desc:
                'Third-trimester ultrasound due. Check growth velocities and amniotic index.',
            status: 'UPCOMING',
            statusColor: AppColors.secondaryAccent,
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'PEDIATRIC IMMUNIZATION & GROWTH',
            style: AppTextStyles.labelSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildPediatricCard(),
        ],
      ),
    );
  }

  Widget _buildPrenatalProfileBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE91E63), Color(0xFFC2185B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: Colors.white12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ACTIVE PRENATAL TRACKER',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.favorite_rounded, color: Colors.white70, size: 16),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Weekly Maternal Diary',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Currently: 26 Weeks Pregnant · Third Trimester',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Expected Date: 12 Aug 2026',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Consults Done: 6/9',
                style: TextStyle(color: Colors.white70, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneCard({
    required String week,
    required String desc,
    required String status,
    required Color statusColor,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                week,
                style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(desc, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }

  Widget _buildPediatricCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Child Profile Switcher', style: AppTextStyles.labelLarge),
          SizedBox(height: 4),
          Text(
            'Log growth indicators, height and weight curves for linked children.',
            style: AppTextStyles.bodySmall,
          ),
          SizedBox(height: 12),
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: AppColors.primary,
                child: Text(
                  'K',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Kunal Sharma (Age: 3)',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.secondaryText,
                size: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
