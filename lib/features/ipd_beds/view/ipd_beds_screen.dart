import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_sidebar.dart';
import 'package:paracareplus/features/ipd_beds/view/widgets/charts/ipd_adm_dis_chart.dart';
import 'package:paracareplus/features/ipd_beds/view/widgets/charts/ipd_bed_pressure_heatmap.dart';
import 'package:paracareplus/features/ipd_beds/view/widgets/charts/ipd_los_dist_chart.dart';
import 'package:paracareplus/features/ipd_beds/view/widgets/charts/ipd_occupancy_trend_chart.dart';
import 'package:paracareplus/features/ipd_beds/view/widgets/charts/ipd_sunburst_charts.dart';
import 'package:paracareplus/features/ipd_beds/view/widgets/charts/ipd_ward_occ_chart.dart';
import 'package:paracareplus/features/ipd_beds/view/widgets/ipd_ambulance_table.dart';
import 'package:paracareplus/features/ipd_beds/view/widgets/ipd_bed_matrix.dart';
import 'package:paracareplus/features/ipd_beds/view/widgets/ipd_beds_map_panel.dart';
import 'package:paracareplus/features/ipd_beds/view/widgets/ipd_beds_ticker.dart';
import 'package:paracareplus/features/ipd_beds/view/widgets/ipd_live_counter_strip.dart';
import 'package:paracareplus/features/ipd_beds/view/widgets/ipd_scorecard_table.dart';
import 'package:paracareplus/features/ipd_beds/view/widgets/ipd_triage_grid.dart';
import 'package:paracareplus/features/ipd_beds/view_model/ipd_beds_view_model.dart';
import 'package:paracareplus/routes/route_paths.dart';

class IpdBedsScreen extends ConsumerWidget {
  const IpdBedsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ipdBedsProvider);
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 1200;

    final Widget mainBody = Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Alert Banner
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
                        'MCI ALERT [ACTIVE] — Roorkee NH-58 Highway Pile-Up | 14 Casualties Inbound | 3 Trauma Centres on Standby | Last Updated: 14:32 IST',
                        style: TextStyle(
                          color: AppColors.error,
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // SECTION 1: IPD & Bed Management Live counters
              const IpdLiveCounterStrip(),
              const SizedBox(height: AppSpacing.lg),

              // Ward matrix status
              const IpdBedMatrix(),
              const SizedBox(height: AppSpacing.lg),

              // Charts Row 1
              const SizedBox(height: 320, child: IpdOccupancyTrendChart()),
              const SizedBox(height: 12),
              const SizedBox(height: 320, child: IpdAdmDisChart()),
              const SizedBox(height: AppSpacing.lg),

              // Charts Row 2
              const SizedBox(height: 340, child: IpdWardOccChart()),
              const SizedBox(height: 14),
              const SizedBox(height: 340, child: IpdLosDistChart()),
              const SizedBox(height: AppSpacing.lg),

              // Heatmap
              const SizedBox(height: 340, child: IpdBedPressureHeatmap()),
              const SizedBox(height: AppSpacing.lg),

              // SECTION 2: GIS Statewide Bed Maps
              const IpdBedsMapPanel(),
              const SizedBox(height: AppSpacing.lg),

              // SECTION 3: ER Triage Grid
              const IpdTriageGrid(),
              const SizedBox(height: AppSpacing.lg),

              // Section 5: Ambulances & Transfers
              const IpdAmbulanceTable(),
              const SizedBox(height: AppSpacing.lg),

              // Section 6: Hospital scorecards
              const IpdScorecardTable(),
              const SizedBox(height: AppSpacing.lg),

              // Sunburst hierarchy visualizations
              const IpdSunburstCharts(),
              const SizedBox(height: AppSpacing.xxl),

              // Footer
              Center(
                child: Text(
                  'ParaCare+ Uttarakhand State HIMS — IPD & Bed Management / Emergency & Trauma — v4.0 — Data refreshes every 60s',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'IPD & Bed Management',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              'Emergency & Trauma Centre',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () => ref.read(ipdBedsProvider.notifier).refresh(),
          ),
          const SizedBox(width: 12),
        ],
        backgroundColor: AppColors.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(children: [const IpdBedsTicker(), mainBody]),
      ),
    );
  }
}
