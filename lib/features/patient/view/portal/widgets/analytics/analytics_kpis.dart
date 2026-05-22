import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AnalyticsKpiGrid extends StatelessWidget {
  const AnalyticsKpiGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        // Responsive grid column count
        var crossAxisCount = 2;
        if (width > 1200) {
          crossAxisCount = 6;
        } else if (width > 900) {
          crossAxisCount = 5;
        } else if (width > 600) {
          crossAxisCount = 3;
        }

        final kpis = _getKpiData();

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 1.25,
          ),
          itemCount: kpis.length,
          itemBuilder: (context, index) {
            final item = kpis[index];
            return _AnalyticsKpiCard(kpi: item);
          },
        );
      },
    );
  }

  List<_KpiItem> _getKpiData() {
    return [
      _KpiItem(
        title: 'BMI (kg/m²)',
        value: '26.2',
        subtext: '▲ Overweight Range',
        color: AppColors.secondaryAccent,
        icon: Icons.scale_rounded,
      ),
      _KpiItem(
        title: 'Blood Pressure',
        value: '128/82',
        subtext: '▲ Stage 1 Hypertension',
        color: AppColors.error,
        icon: Icons.favorite_rounded,
      ),
      _KpiItem(
        title: 'Fasting Sugar',
        value: '142 mg/dL',
        subtext: '▲ Pre-Diabetic',
        color: AppColors.secondaryAccent,
        icon: Icons.opacity_rounded,
      ),
      _KpiItem(
        title: 'Total Cholesterol',
        value: '218 mg/dL',
        subtext: '▲ Borderline High',
        color: AppColors.error,
        icon: Icons.biotech_rounded,
      ),
      _KpiItem(
        title: 'Heart Rate (avg)',
        value: '76 bpm',
        subtext: '✓ Normal Range',
        color: AppColors.success,
        icon: Icons.monitor_heart_rounded,
      ),
      _KpiItem(
        title: 'SpO₂ (avg)',
        value: '98%',
        subtext: '✓ Normal',
        color: AppColors.primaryLight,
        icon: Icons.air_rounded,
      ),
      _KpiItem(
        title: 'Body Weight',
        value: '72.4 kg',
        subtext: '▲ +0.8 kg this month',
        color: AppColors.primaryLight,
        icon: Icons.monitor_weight_rounded,
      ),
      _KpiItem(
        title: 'Avg Calories/Day',
        value: '1,840',
        subtext: '▼ Below Target 2,200',
        color: AppColors.secondaryAccent,
        icon: Icons.local_fire_department_rounded,
      ),
      _KpiItem(
        title: 'Avg Sleep',
        value: '6.2 hrs',
        subtext: '▼ Below 7hr target',
        color: const Color(0xFFC77DFF),
        icon: Icons.bedtime_rounded,
      ),
      _KpiItem(
        title: 'Avg Daily Steps',
        value: '4,820',
        subtext: '▼ Below 8,000 target',
        color: const Color(0xFF0D9488),
        icon: Icons.directions_walk_rounded,
      ),
      _KpiItem(
        title: 'Avg Water Intake',
        value: '1.4 L',
        subtext: '▼ Below 2.5L target',
        color: AppColors.primaryLight,
        icon: Icons.water_drop_rounded,
      ),
      _KpiItem(
        title: 'Mental Wellness',
        value: '72 / 100',
        subtext: '▼ Moderate stress noted',
        color: const Color(0xFF4361EE),
        icon: Icons.psychology_rounded,
      ),
      _KpiItem(
        title: 'Stress Index',
        value: '6.4 / 10',
        subtext: '▲ Elevated',
        color: const Color(0xFFF72585),
        icon: Icons.bolt_rounded,
      ),
      _KpiItem(
        title: 'Composite CV Risk',
        value: '42%',
        subtext: '▲ Moderate-High',
        color: AppColors.error,
        icon: Icons.shield_rounded,
      ),
    ];
  }
}

class _KpiItem {
  _KpiItem({
    required this.title,
    required this.value,
    required this.subtext,
    required this.color,
    required this.icon,
  });

  final String title;
  final String value;
  final String subtext;
  final Color color;
  final IconData icon;
}

class _AnalyticsKpiCard extends StatelessWidget {
  const _AnalyticsKpiCard({required this.kpi});
  final _KpiItem kpi;

  @override
  Widget build(BuildContext context) {
    final isPositive = kpi.subtext.startsWith('✓');

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 3,
              child: Container(color: kpi.color),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: kpi.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Icon(kpi.icon, color: kpi.color, size: 18),
                  ),
                  const Spacer(),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      kpi.value,
                      style: AppTextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    kpi.title,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.secondaryText,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      kpi.subtext,
                      style: TextStyle(
                        color: isPositive
                            ? AppColors.success
                            : kpi.color == AppColors.error
                            ? AppColors.error
                            : AppColors.secondaryAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 9,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
