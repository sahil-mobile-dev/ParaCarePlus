import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class HomeDiseaseRisk extends ConsumerWidget {
  const HomeDiseaseRisk({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildChartCard(
      title: 'Disease Risk Assessment',
      icon: Icons.pie_chart_rounded,
      child: Column(
        children: [
          _buildRiskBarItem('Cardiovascular', 0.42, AppColors.error),
          const SizedBox(height: 8),
          _buildRiskBarItem(
            'Diabetes Complication',
            0.38,
            AppColors.secondaryAccent,
          ),
          const SizedBox(height: 8),
          _buildRiskBarItem('Kidney Disease', 0.18, AppColors.primaryLight),
          const SizedBox(height: 8),
          _buildRiskBarItem(
            'Diabetic Retinopathy',
            0.22,
            const Color(0xFFC77DFF),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskBarItem(String name, double val, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(color: Colors.white70, fontSize: 10),
            ),
            Text(
              '${(val * 100).round()}%',
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: val,
            color: color,
            backgroundColor: AppColors.border,
            minHeight: 4,
          ),
        ),
      ],
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
