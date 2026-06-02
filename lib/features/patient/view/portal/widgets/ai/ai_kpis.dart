import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AiKpis extends StatelessWidget {
  const AiKpis({super.key});

  @override
  Widget build(BuildContext context) {
    final kpis = <Map<String, dynamic>>[
      {
        'title': 'AI Conversations Today',
        'value': '24',
        'sub': '↑ 6 from yesterday · Avg 4.2 min',
        'icon': Icons.chat_bubble_outline_rounded,
        'color': Colors.purpleAccent,
      },
      {
        'title': 'Symptom Checks Done',
        'value': '7',
        'sub': '3 flagged for review · 4 reassured',
        'icon': Icons.healing_rounded,
        'color': AppColors.primaryLight,
      },
      {
        'title': 'AI Accuracy Score',
        'value': '94.2%',
        'sub': 'Validated against clinical outcomes',
        'icon': Icons.check_circle_outline_rounded,
        'color': AppColors.success,
      },
      {
        'title': 'Alerts Generated',
        'value': '3',
        'sub': '1 critical · 2 advisory · 0 dismissed',
        'icon': Icons.warning_amber_rounded,
        'color': AppColors.secondaryAccent,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: kpis.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 1.7,
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
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 3,
                    child: Container(color: color),
                  ),
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: Icon(
                      kpi['icon'] as IconData,
                      color: color.withValues(alpha: 0.15),
                      size: 40,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          kpi['title'] as String,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.secondaryText,
                            fontSize: 10,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          kpi['value'] as String,
                          style: TextStyle(
                            color: color,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          kpi['sub'] as String,
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 8.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
