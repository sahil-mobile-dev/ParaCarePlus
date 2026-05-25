import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AiInsights extends StatelessWidget {
  const AiInsights({super.key});

  @override
  Widget build(BuildContext context) {
    final insights = <Map<String, dynamic>>[
      {
        'title': 'Diet AI Recommendation',
        'desc': 'Your sodium intake (est. 3,800 mg/day) exceeds the 2,300 mg target. AI suggests the DASH diet tailored for North Indian cuisine — dal, lauki sabzi, curd over salt-rich pickles.',
        'icon': Icons.restaurant_menu_rounded,
        'color': AppColors.success,
        'actionLabel': 'View 7-day meal plan',
        'actionMsg': 'Diet plan details sent to your phone!',
      },
      {
        'title': 'Activity AI Coaching',
        'desc': 'Step count 3,240 today — 35% of 10K target. Based on your knee OA, AI recommends swimming/aqua-aerobics 3×/week + 30 min zone-2 walking daily. Avoid HIIT until ortho review.',
        'icon': Icons.directions_run_rounded,
        'color': AppColors.primaryLight,
        'actionLabel': 'Get exercise plan',
        'actionMsg': 'Activity plan sent to your phone!',
      },
      {
        'title': 'Sleep AI Analysis',
        'desc': 'Avg sleep 5.8 hrs vs. 7–8 hr target. AI detects irregular bedtimes (10 PM–1 AM range). Sleep debt accumulated: 8.2 hrs this week. Melatonin circadian reset protocol suggested.',
        'icon': Icons.nightlight_round_rounded,
        'color': Colors.purpleAccent,
        'actionLabel': 'Sleep protocol',
        'actionMsg': 'Sleep improvement plan activated!',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Row(
          children: [
            Icon(
              Icons.tips_and_updates_rounded,
              color: AppColors.success,
              size: 18,
            ),
            SizedBox(width: 8),
            Text(
              'PERSONALISED AI HEALTH INSIGHTS',
              style: AppTextStyles.labelSmall,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final crossAxisCount = width > 900 ? 3 : 1;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: insights.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: AppSpacing.sm,
                mainAxisSpacing: AppSpacing.sm,
                childAspectRatio: width > 900 ? 1.45 : 2.4,
              ),
              itemBuilder: (context, index) {
                final ins = insights[index];
                final color = ins['color'] as Color;

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          ins['icon'] as IconData,
                          color: color,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ins['title'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Expanded(
                              child: Text(
                                ins['desc'] as String,
                                style: const TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 9.5,
                                  height: 1.3,
                                ),
                                maxLines: width > 900 ? 4 : 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 6),
                            GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(ins['actionMsg'] as String),
                                    backgroundColor: color,
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    ins['actionLabel'] as String,
                                    style: TextStyle(
                                      color: color,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    color: color,
                                    size: 10,
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
        ),
      ],
    );
  }
}
