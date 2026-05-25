import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class WellnessGoals extends StatelessWidget {
  const WellnessGoals({super.key});

  @override
  Widget build(BuildContext context) {
    final goals = <Map<String, dynamic>>[
      {
        'emoji': '🚶',
        'name': 'Steps',
        'current': '4,820',
        'target': 'of 8,000 target',
        'pct': 0.60,
        'color': AppColors.secondaryAccent,
      },
      {
        'emoji': '💧',
        'name': 'Water',
        'current': '1.4 L',
        'target': 'of 2.5 L target',
        'pct': 0.56,
        'color': AppColors.error,
      },
      {
        'emoji': '🔥',
        'name': 'Calories',
        'current': '1,840',
        'target': 'of 2,200 target',
        'pct': 0.84,
        'color': AppColors.success,
      },
      {
        'emoji': '🏋️',
        'name': 'Exercise',
        'current': '12 min',
        'target': 'of 30 min target',
        'pct': 0.40,
        'color': AppColors.error,
      },
      {
        'emoji': '🧘',
        'name': 'Meditation',
        'current': '0 min',
        'target': 'of 10 min target',
        'pct': 0.0,
        'color': Colors.purpleAccent,
      },
      {
        'emoji': '😴',
        'name': 'Sleep (last night)',
        'current': '6.2 hrs',
        'target': 'of 8 hr target',
        'pct': 0.77,
        'color': AppColors.secondaryAccent,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Row(
          children: [
            Icon(
              Icons.track_changes_rounded,
              color: AppColors.success,
              size: 18,
            ),
            SizedBox(width: 8),
            Text(
              'DAILY WELLNESS GOALS — TODAY',
              style: AppTextStyles.labelSmall,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final crossAxisCount = width > 900
                ? 6
                : (width > 600 ? 3 : (width > 400 ? 2 : 1));

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: goals.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.sm,
                mainAxisSpacing: AppSpacing.sm,
                childAspectRatio: 1.25,
              ),
              itemBuilder: (context, index) {
                final goal = goals[index];
                final color = goal['color'] as Color;

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        goal['emoji'] as String,
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        goal['name'] as String,
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        goal['current'] as String,
                        style: TextStyle(
                          color: color,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        goal['target'] as String,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 9.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: goal['pct'] as double,
                          backgroundColor: Colors.white.withValues(alpha: 0.08),
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                          minHeight: 5,
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
