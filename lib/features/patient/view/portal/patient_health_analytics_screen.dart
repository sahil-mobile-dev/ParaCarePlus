import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/analytics/analytics_ai_insights.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/analytics/analytics_heatmap.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/analytics/analytics_kpis.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/analytics/analytics_predictive.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/analytics/analytics_reference_table.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/analytics/analytics_trends.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientHealthAnalyticsScreen extends ConsumerWidget {
  const PatientHealthAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayStr = DateFormat('dd MMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientHealthAnalytics,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('Health Analytics'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: AppColors.primaryText),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Page Header with Sync Badge Indicators
            _buildPageHeader(todayStr),
            const SizedBox(height: AppSpacing.md),

            // KPI Grid Title
            _buildSectionTitle(
              Icons.speed_rounded,
              'Key Health Metrics — Last 30 Days',
            ),
            const SizedBox(height: AppSpacing.sm),
            const AnalyticsKpiGrid(),
            const SizedBox(height: AppSpacing.md),

            // AI Insights Title
            _buildSectionTitle(Icons.smart_toy_rounded, 'AI Health Insights'),
            const SizedBox(height: AppSpacing.sm),
            const AnalyticsAiInsights(),
            const SizedBox(height: AppSpacing.md),

            // 90 Days Trend charts Title
            _buildSectionTitle(
              Icons.analytics_rounded,
              'Trend Analysis — Last 90 Days',
            ),
            const SizedBox(height: AppSpacing.sm),
            const AnalyticsTrends(),
            const SizedBox(height: AppSpacing.md),

            // Reference table
            const AnalyticsReferenceTable(),
            const SizedBox(height: AppSpacing.md),

            // Predictive Radar / scoring / pie Title
            _buildSectionTitle(
              Icons.online_prediction_rounded,
              'Predictive & Composite Analytics',
            ),
            const SizedBox(height: AppSpacing.sm),
            const AnalyticsPredictive(),
            const SizedBox(height: AppSpacing.md),

            // Heatmap calendar grid
            const AnalyticsHeatmap(),
          ],
        ),
      ),
    );
  }

  Widget _buildPageHeader(String todayStr) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        final infoWidgets = [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primaryLight.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.person_rounded,
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
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primaryLight.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.badge_rounded,
                  color: AppColors.primaryLight,
                  size: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  'ABHA: 43-8912-3456-7890',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primaryLight.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.calendar_today_rounded,
                  color: AppColors.primaryLight,
                  size: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  todayStr,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.show_chart_rounded,
                  color: AppColors.primaryLight,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Health Analytics Dashboard',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (isMobile)
              Wrap(spacing: 6, runSpacing: 6, children: infoWidgets)
            else
              Row(children: infoWidgets),
          ],
        );
      },
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryLight, size: 16),
        const SizedBox(width: 8),
        Text(
          title,
          style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
