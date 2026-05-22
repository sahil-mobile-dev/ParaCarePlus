import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class HomeAiInsights extends ConsumerWidget {
  const HomeAiInsights({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildChartCard(
      title: 'AI Health Insights',
      icon: Icons.psychology_rounded,
      color: const Color(0xFFC77DFF),
      child: Column(
        children: [
          _buildAiInsightItem(
            'BP Trend Alert',
            'Your systolic BP has increased by 8 mmHg over the last 7 days. Pattern suggests stress-related elevation. Consider relaxation and physician consultation.',
            '89%',
            AppColors.error,
          ),
          const SizedBox(height: 8),
          _buildAiInsightItem(
            'Dietary Recommendation',
            'Based on your HbA1c trend, reduce refined carbohydrate intake. Increase green leafy vegetables and add 20-min post-meal walks.',
            '92%',
            AppColors.secondaryAccent,
          ),
          const SizedBox(height: 8),
          _buildAiInsightItem(
            'Positive Signal',
            'Your medication adherence improved to 94% this week. SpO2 remains stable. Keep up the good work!',
            '97%',
            AppColors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildAiInsightItem(
    String title,
    String body,
    String conf,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tips_and_updates, color: color, size: 14),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            body,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'AI Confidence: $conf',
              style: TextStyle(
                color: color,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard({
    required String title,
    required IconData icon,
    required Widget child,
    Color color = AppColors.primaryLight,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
