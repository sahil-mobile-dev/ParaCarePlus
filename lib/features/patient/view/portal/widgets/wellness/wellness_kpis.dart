import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class WellnessKpis extends StatelessWidget {
  const WellnessKpis({super.key});

  @override
  Widget build(BuildContext context) {
    final kpis = <Map<String, dynamic>>[
      {
        'title': 'Wellness Score',
        'value': '78 / 100',
        'sub': '↓ -2 from last month',
        'icon': Icons.favorite_rounded,
        'color': AppColors.secondaryAccent,
        'status': 'warn',
      },
      {
        'title': "Today's Steps",
        'value': '4,820',
        'sub': 'Target: 8,000',
        'icon': Icons.directions_walk_rounded,
        'color': Colors.teal,
        'status': 'warn',
      },
      {
        'title': 'Calories Consumed',
        'value': '1,840 kcal',
        'sub': 'Target: 2,200',
        'icon': Icons.local_fire_department_rounded,
        'color': AppColors.success,
        'status': 'ok',
      },
      {
        'title': 'Sleep Last Night',
        'value': '6.2 hrs',
        'sub': 'Target: 7–9 hrs',
        'icon': Icons.dark_mode_rounded,
        'color': Colors.purpleAccent,
        'status': 'bad',
      },
      {
        'title': 'Water Intake',
        'value': '1.4 L',
        'sub': 'Target: 2.5 L',
        'icon': Icons.local_drink_rounded,
        'color': AppColors.primaryLight,
        'status': 'bad',
      },
      {
        'title': 'Stress Level',
        'value': '6.4 / 10',
        'sub': 'Elevated',
        'icon': Icons.psychology_rounded,
        'color': AppColors.secondaryAccent,
        'status': 'bad',
      },
      {
        'title': 'Smoking Status',
        'value': 'Non-Smoker',
        'sub': '✓ Never smoked',
        'icon': Icons.smoke_free_rounded,
        'color': AppColors.success,
        'status': 'ok',
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = width > 1200
            ? 7
            : (width > 800 ? 4 : (width > 480 ? 2 : 1));

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: kpis.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 1.35,
          ),
          itemBuilder: (context, index) {
            final kpi = kpis[index];
            final color = kpi['color'] as Color;

            Color subColor;
            if (kpi['status'] == 'ok') {
              subColor = AppColors.success;
            } else if (kpi['status'] == 'warn') {
              subColor = AppColors.secondaryAccent;
            } else {
              subColor = AppColors.error;
            }

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
                    top: 0,
                    left: 0,
                    right: 0,
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
                        const SizedBox(height: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  kpi['value'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                kpi['title'] as String,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.secondaryText,
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.normal,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 1),
                              Text(
                                kpi['sub'] as String,
                                style: TextStyle(
                                  color: subColor,
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
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
