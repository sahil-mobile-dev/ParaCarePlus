import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class FamilyKpis extends StatelessWidget {
  const FamilyKpis({super.key});

  @override
  Widget build(BuildContext context) {
    final kpis = <Map<String, dynamic>>[
      {
        'icon': Icons.people_rounded,
        'value': '5',
        'label': 'Family Members',
        'subText': 'All linked to ABHA',
        'color': AppColors.primaryLight,
      },
      {
        'icon': Icons.vaccines_rounded,
        'value': '4 / 5',
        'label': 'Vaccinations Up-to-Date',
        'subText': '1 member overdue',
        'color': AppColors.success,
      },
      {
        'icon': Icons.warning_amber_rounded,
        'value': '3',
        'label': 'Active Health Alerts',
        'subText': 'Requires attention',
        'color': AppColors.secondaryAccent,
      },
      {
        'icon': Icons.medical_services_rounded,
        'value': '12',
        'label': 'Consultations This Year',
        'subText': 'Family combined',
        'color': Colors.blueAccent,
      },
      {
        'icon': Icons.science_rounded,
        'value': '2',
        'label': 'Hereditary Risk Flags',
        'subText': 'HTN + Diabetes genetic',
        'color': AppColors.error,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = width > 1000 ? 5 : (width > 600 ? 3 : 2);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: kpis.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: width > 1000 ? 1.35 : 1.45,
          ),
          itemBuilder: (context, index) {
            final kpi = kpis[index];
            final color = kpi['color'] as Color;

            return Container(
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 3,
                    child: Container(color: color),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            kpi['icon'] as IconData,
                            color: color,
                            size: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              kpi['value'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              kpi['label'] as String,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.secondaryText,
                                fontSize: 9.5,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              kpi['subText'] as String,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: color,
                                fontSize: 8.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
