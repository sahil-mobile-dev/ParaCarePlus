import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/chronic/chronic_ai_risk.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/chronic/chronic_conditions_grid.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/chronic/chronic_kpis.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/chronic/chronic_trend_radar.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientChronicScreen extends ConsumerWidget {
  const PatientChronicScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientChronic,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Row(
          children: [
            const Icon(
              Icons.favorite_rounded,
              color: AppColors.error,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Chronic Care Portal',
              style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
            ),
          ],
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: AppColors.primaryText),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primaryLight.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.person_outline_rounded,
                  color: AppColors.primaryLight,
                  size: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  'Ramesh Kumar',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            // Top Section - Active Registered Profiles
            _buildActiveProfilesStrip(),
            const SizedBox(height: AppSpacing.md),

            // KPI Grid Section
            const ChronicKpis(),
            const SizedBox(height: AppSpacing.lg),

            // Active & Monitored Conditions Header
            const Row(
              children: [
                Icon(
                  Icons.healing_outlined,
                  color: AppColors.secondaryAccent,
                  size: 18,
                ),
                SizedBox(width: 8),
                Text(
                  'ACTIVE & MONITORED CONDITIONS',
                  style: AppTextStyles.labelSmall,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),

            // 9 Conditions Grid
            const ChronicConditionsGrid(),
            const SizedBox(height: AppSpacing.lg),

            // AI Risk Prediction Outlook
            const ChronicAiRisk(),
            const SizedBox(height: AppSpacing.lg),

            // Trend Visualizers & Multi-Condition Radar
            const ChronicTrendRadar(),
            const SizedBox(height: AppSpacing.lg),

            // Quick Symptom Entry Log Button
            _buildLogSymptomBanner(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveProfilesStrip() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.app_registration_rounded,
            color: AppColors.secondaryAccent,
            size: 20,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'REGISTERED PROFILE TARGETS:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ),
          Wrap(
            spacing: 6,
            children: [
              _buildConditionTag('Hypertension', AppColors.error),
              _buildConditionTag('Type-2 Diabetes', AppColors.secondaryAccent),
              _buildConditionTag('Allergies', AppColors.success),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConditionTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 9.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLogSymptomBanner(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Opening daily symptom checker diary log...'),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit_note_rounded,
                color: AppColors.primaryLight,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Log Daily Symptom Entry',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Update BP readings, glucose entries, and daily diet guidelines.',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10.5,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.secondaryText,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }
}
