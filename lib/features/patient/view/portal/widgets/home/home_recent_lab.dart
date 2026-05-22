import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class HomeRecentLab extends ConsumerWidget {
  const HomeRecentLab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildChartCard(
      title: 'Recent Lab Reports',
      icon: Icons.science_rounded,
      child: Column(
        children: [
          _buildLabItem(
            'HbA1c — 7.4%',
            '12 May 2026 · Doon Diagnostics',
            'REVIEW',
            AppColors.secondaryAccent,
          ),
          const SizedBox(height: 6),
          _buildLabItem(
            'CBC + ESR — Complete Blood',
            '10 May 2026 · Doon Hospital Path',
            'NORMAL',
            AppColors.success,
          ),
          const SizedBox(height: 6),
          _buildLabItem(
            'Lipid Profile — LDL: 142',
            '10 May 2026 · Doon Hospital Path',
            'HIGH',
            AppColors.error,
          ),
          const SizedBox(height: 6),
          _buildLabItem(
            'Thyroid Panel (TSH/T3/T4)',
            '5 May 2026 · PathKind',
            'NORMAL',
            AppColors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildLabItem(String name, String date, String status, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.description,
            color: AppColors.secondaryText,
            size: 14,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  date,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 9,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
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
