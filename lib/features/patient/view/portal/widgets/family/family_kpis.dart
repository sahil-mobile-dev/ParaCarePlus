import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class FamilyKpis extends StatelessWidget {
  const FamilyKpis({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 900
            ? 4
            : (constraints.maxWidth > 600 ? 2 : 2);

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: constraints.maxWidth > 900 ? 1.45 : 1.35,
          children: [
            _buildKpiCard(
              icon: Icons.people_rounded,
              value: '5 Members',
              label: 'Central Network',
              subText: 'Ramesh, Geeta + 3 relatives',
              accentColor: AppColors.primaryLight,
            ),
            _buildKpiCard(
              icon: Icons.vaccines_rounded,
              value: '94%',
              label: 'Vaccine Adherence',
              subText: 'Priya & Aryan up to date',
              accentColor: AppColors.success,
            ),
            _buildKpiCard(
              icon: Icons.notifications_active_rounded,
              value: '2 Alerts',
              label: 'Critical Actions',
              subText: 'Savitri Devi BP check overdue',
              accentColor: AppColors.error,
            ),
            _buildKpiCard(
              icon: Icons.analytics_rounded,
              value: 'High Risk',
              label: 'Hereditary Vector',
              subText: 'HTN & Type 2 Diabetes',
              accentColor: AppColors.secondaryAccent,
            ),
          ],
        );
      },
    );
  }

  Widget _buildKpiCard({
    required IconData icon,
    required String value,
    required String label,
    required String subText,
    required Color accentColor,
  }) {
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
            child: Container(color: accentColor),
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
                    color: accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: accentColor, size: 18),
                ),
                const SizedBox(height: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.secondaryText,
                        fontSize: 9.5,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      subText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: accentColor,
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
  }
}
