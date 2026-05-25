import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class VaccinationKpiGrid extends StatelessWidget {
  const VaccinationKpiGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 900
            ? 5
            : (constraints.maxWidth > 600 ? 3 : 2);

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: constraints.maxWidth > 900 ? 1.25 : 1.45,
          children: [
            _buildKpiCard(
              icon: Icons.shield_outlined,
              value: '12 / 14',
              label: 'Vaccines Completed',
              subText: '86% immunized',
              accentColor: AppColors.success,
            ),
            _buildKpiCard(
              icon: Icons.access_time_rounded,
              value: '2',
              label: 'Due / Overdue',
              subText: 'Booster needed',
              accentColor: AppColors.secondaryAccent,
            ),
            _buildKpiCard(
              icon: Icons.calendar_today_rounded,
              value: 'Jun 2026',
              label: 'Next Scheduled',
              subText: 'Tdap Booster',
              accentColor: AppColors.primaryLight,
            ),
            _buildKpiCard(
              icon: Icons.badge_outlined,
              value: '3',
              label: 'Certificates',
              subText: 'COWIN, ABHA linked',
              accentColor: Colors.purpleAccent,
            ),
            _buildKpiCard(
              icon: Icons.people_outline_rounded,
              value: '4 / 5',
              label: 'Family Members',
              subText: '1 member pending',
              accentColor: Colors.orangeAccent,
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
          // Top accent border bar
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 3,
            child: Container(color: accentColor),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                  child: Icon(icon, color: accentColor, size: 16),
                ),
                const SizedBox(height: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.secondaryText,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      subText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 9,
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
