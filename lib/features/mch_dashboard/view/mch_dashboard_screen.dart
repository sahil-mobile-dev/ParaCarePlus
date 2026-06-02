import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/mch_dashboard/view/widgets/charts/mch_delivery_trend_chart.dart';
import 'package:paracareplus/features/mch_dashboard/view/widgets/charts/mch_funnel_charts.dart';
import 'package:paracareplus/features/mch_dashboard/view/widgets/charts/mch_immunisation_chart.dart';
import 'package:paracareplus/features/mch_dashboard/view/widgets/charts/mch_malnutrition_chart.dart';
import 'package:paracareplus/features/mch_dashboard/view/widgets/charts/mch_mortality_trend_chart.dart';
import 'package:paracareplus/features/mch_dashboard/view/widgets/charts/mch_risk_heatmaps.dart';
import 'package:paracareplus/features/mch_dashboard/view/widgets/mch_dashboard_ticker.dart';
import 'package:paracareplus/features/mch_dashboard/view/widgets/mch_district_scorecard.dart';
import 'package:paracareplus/features/mch_dashboard/view/widgets/mch_gis_maps.dart';
import 'package:paracareplus/features/mch_dashboard/view/widgets/mch_hrp_register.dart';
import 'package:paracareplus/features/mch_dashboard/view/widgets/mch_kpi_grid.dart';
import 'package:paracareplus/features/mch_dashboard/view/widgets/mch_program_grid.dart';
import 'package:paracareplus/features/mch_dashboard/view_model/mch_dashboard_view_model.dart';
import 'package:paracareplus/routes/route_paths.dart';

class MchDashboardScreen extends ConsumerWidget {
  const MchDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mchDashboardProvider);

    final Widget mainBody = Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MMR Alert Banner
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.08),
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.25),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: AppColors.error),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'MMR ALERT: 4 maternal deaths reported MTD (Pithoragarh x2, Chamoli x1, Rudraprayag x1). Audit initiated. Root cause: Delayed referral + PPH.',
                        style: TextStyle(
                          color: AppColors.error,
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              // SAM Alert Banner
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.secondaryAccent.withValues(alpha: 0.08),
                  border: Border.all(
                    color: AppColors.secondaryAccent.withValues(alpha: 0.25),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.child_care, color: AppColors.secondaryAccent),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'SAM ALERT: 4,218 children with Severe Acute Malnutrition identified. NRC bed utilisation at 87%. Udham Singh Nagar & Haridwar highest burden.',
                        style: TextStyle(
                          color: AppColors.secondaryAccent,
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // SECTION 1: MCH Indicators KPI cards
              const MchKpiGrid(),
              const SizedBox(height: AppSpacing.lg),

              // Section 3: Programme Achievements
              const MchProgramGrid(),
              const SizedBox(height: AppSpacing.lg),

              // Charts Row 1
              const Column(
                children: [
                  SizedBox(height: 320, child: MchDeliveryTrendChart()),
                  SizedBox(height: 14),
                  SizedBox(height: 320, child: MchImmunisationChart()),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Charts Row 2
              const SizedBox(height: 320, child: MchMortalityTrendChart()),
              const SizedBox(height: 12),
              const SizedBox(height: 320, child: MchMalnutritionChart()),
              const SizedBox(height: AppSpacing.lg),

              // Funnel charts
              const MchFunnelCharts(),
              const SizedBox(height: AppSpacing.lg),

              // Heatmaps
              const MchRiskHeatmaps(),
              const SizedBox(height: AppSpacing.lg),

              // GIS Maps
              const MchGisMaps(),
              const SizedBox(height: AppSpacing.lg),

              // District scorecard
              const MchDistrictScorecard(),
              const SizedBox(height: AppSpacing.lg),

              // High risk pregnancy register
              const MchHrpRegister(),
              const SizedBox(height: AppSpacing.xxl),

              // Footer
              Center(
                child: Text(
                  'ParaCare+ Uttarakhand — Maternal & Child Health Dashboard v4.0 — RMNCH+A | NHM | POSHAN 2.0',
                  style: TextStyle(
                    color: AppColors.secondaryText.withValues(alpha: 0.5),
                    fontSize: 10,
                    fontFamily: AppTextStyles.fontFamily,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (state.isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.5),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go(RoutePaths.dashboardHub),
        ),

        title: Column(
          children: [
            Row(
              children: [
                Text(
                  'Maternal & Child Health',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              'MCH Dashboard — RMNCH+A Programme Intelligence',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () => ref.read(mchDashboardProvider.notifier).refresh(),
          ),
          const SizedBox(width: 12),
        ],
        backgroundColor: AppColors.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(children: [const MchDashboardTicker(), mainBody]),
      ),
    );
  }
}
