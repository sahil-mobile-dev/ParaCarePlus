import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class LabKpiGrid extends StatelessWidget {
  const LabKpiGrid({
    required this.samplesQueue,
    required this.urgentCount,
    required this.criticalCount,
    required this.completedCount,
    required this.avgTat,
    required this.qualityScore,
    super.key,
  });

  final int samplesQueue;
  final int urgentCount;
  final int criticalCount;
  final int completedCount;
  final String avgTat;
  final String qualityScore;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 1100
            ? 6
            : (constraints.maxWidth > 700 ? 3 : 2);

        return GridView.count(
          crossAxisCount: columns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.6,
          children: [
            _buildKpiCard(
              title: 'SAMPLES IN QUEUE',
              value: samplesQueue.toString(),
              emoji: '🧫',
              color: const Color(0xFF1565C0),
            ),
            _buildKpiCard(
              title: 'URGENT / STAT',
              value: urgentCount.toString(),
              emoji: '🚨',
              color: AppColors.error,
            ),
            _buildKpiCard(
              title: 'CRITICAL VALUES',
              value: criticalCount.toString(),
              emoji: '⚠️',
              color: AppColors.secondaryAccent,
            ),
            _buildKpiCard(
              title: 'COMPLETED TODAY',
              value: completedCount.toString(),
              emoji: '✅',
              color: AppColors.success,
            ),
            _buildKpiCard(
              title: 'AVG TAT',
              value: avgTat,
              emoji: '⏱️',
              color: const Color(0xFF00897B),
            ),
            _buildKpiCard(
              title: 'QUALITY SCORE',
              value: qualityScore,
              emoji: '📊',
              color: const Color(0xFF7B1FA2),
            ),
          ],
        );
      },
    );
  }

  Widget _buildKpiCard({
    required String title,
    required String value,
    required String emoji,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.secondaryText,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                emoji,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: AppTextStyles.titleLarge.copyWith(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
