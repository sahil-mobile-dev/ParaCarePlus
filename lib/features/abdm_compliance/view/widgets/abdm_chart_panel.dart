import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/features/abdm_compliance/view/widgets/charts/abha_trend_chart.dart';
import 'package:paracareplus/features/abdm_compliance/view/widgets/charts/api_performance_chart.dart';
import 'package:paracareplus/features/abdm_compliance/view/widgets/charts/consent_analytics_chart.dart';
import 'package:paracareplus/features/abdm_compliance/view/widgets/charts/facility_district_charts.dart';
import 'package:paracareplus/features/abdm_compliance/view/widgets/charts/health_locker_chart.dart';
import 'package:paracareplus/features/abdm_compliance/view/widgets/charts/hie_exchange_chart.dart';

class AbdmChartPanel extends StatelessWidget {
  const AbdmChartPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AbhaTrendChart(),
        SizedBox(height: AppSpacing.lg),
        HieExchangeChart(),
        SizedBox(height: AppSpacing.lg),
        ConsentAnalyticsChart(),
        SizedBox(height: AppSpacing.lg),
        FacilityDistrictCharts(),
        SizedBox(height: AppSpacing.lg),
        ApiPerformanceChart(),
        SizedBox(height: AppSpacing.lg),
        HealthLockerChart(),
      ],
    );
  }
}
