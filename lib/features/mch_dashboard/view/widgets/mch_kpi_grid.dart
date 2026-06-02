import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/abdm_compliance/view/widgets/abdm_kpi_card.dart';
import 'package:paracareplus/features/mch_dashboard/view_model/mch_dashboard_view_model.dart';

class MchKpiGrid extends ConsumerWidget {
  const MchKpiGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mchDashboardProvider);
    final kpi = state.kpiData;

    final maternalKpis = [
      {
        'title': 'Maternal Mortality Rate',
        'value': '${kpi.mmrRate}/LB',
        'subText': 'Target: <100 / LB',
        'emoji': '🤰',
        'colorTheme': 'red',
        'trendUp': false,
      },
      {
        'title': 'Institutional Deliveries',
        'value': '${kpi.instDeliveriesPercent.toStringAsFixed(1)}%',
        'subText': '12,847 MTD',
        'emoji': '🏥',
        'colorTheme': 'green',
        'trendUp': true,
      },
      {
        'title': 'ANC Registrations',
        'value': kpi.ancRegistrations.toString(),
        'subText': '1st Trimester: 76.4%',
        'emoji': '📋',
        'colorTheme': 'teal',
        'trendUp': true,
      },
      {
        'title': '4+ ANC Visits',
        'value': '${kpi.fourAncPercent}%',
        'subText': 'Target: ≥80%',
        'emoji': '🩺',
        'colorTheme': 'yellow',
        'trendUp': false,
      },
    ];

    final childKpis = [
      {
        'title': 'Infant Mortality Rate',
        'value': '${kpi.imrRate}/1K LB',
        'subText': 'Target: <25',
        'emoji': '👶',
        'colorTheme': 'yellow',
        'trendUp': false,
      },
      {
        'title': 'Full Immunisation',
        'value': '${kpi.fullImmunisationPercent}%',
        'subText': 'Under-2 coverage',
        'emoji': '💉',
        'colorTheme': 'green',
        'trendUp': true,
      },
      {
        'title': 'SAM Children',
        'value': kpi.samChildren.toString(),
        'subText': 'NRC Bed Utilisation: 87%',
        'emoji': '🥗',
        'colorTheme': 'red',
        'trendUp': false,
      },
      {
        'title': 'Stunting (Under-5)',
        'value': '${kpi.stuntingPercent}%',
        'subText': 'NFHS-5: 34.0% — Improving',
        'emoji': '📈',
        'colorTheme': 'blue',
        'trendUp': true,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Maternal Section
        const Text(
          'MATERNAL HEALTH INDICATORS',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: AppColors.secondaryText,
            fontFamily: AppTextStyles.fontFamily,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth > 900 ? 4 : 2;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.6,
              ),
              itemCount: maternalKpis.length,
              itemBuilder: (context, index) {
                final card = maternalKpis[index];
                return AbdmKpiCard(
                  title: card['title'] as String,
                  value: card['value'] as String,
                  subText: card['subText'] as String,
                  emoji: card['emoji'] as String,
                  colorTheme: card['colorTheme'] as String,
                  trendUp: card['trendUp'] as bool?,
                );
              },
            );
          },
        ),
        const SizedBox(height: AppSpacing.lg),

        // Child Section
        const Text(
          'CHILD HEALTH & NUTRITION INDICATORS',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: AppColors.secondaryText,
            fontFamily: AppTextStyles.fontFamily,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth > 900 ? 4 : 2;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.6,
              ),
              itemCount: childKpis.length,
              itemBuilder: (context, index) {
                final card = childKpis[index];
                return AbdmKpiCard(
                  title: card['title'] as String,
                  value: card['value'] as String,
                  subText: card['subText'] as String,
                  emoji: card['emoji'] as String,
                  colorTheme: card['colorTheme'] as String,
                  trendUp: card['trendUp'] as bool?,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
