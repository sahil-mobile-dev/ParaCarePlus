import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class EmergencyKpis extends StatelessWidget {
  const EmergencyKpis({super.key});

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
              icon: Icons.airport_shuttle_rounded,
              value: '4 min',
              label: 'Nearest Ambulance ETA',
              subText: '108 — Unit UK-AMB-04',
              accentColor: AppColors.error,
            ),
            _buildKpiCard(
              icon: Icons.local_hospital_rounded,
              value: '1.2 km',
              label: 'Nearest ER',
              subText: 'AIIMS Rishikesh',
              accentColor: AppColors.success,
            ),
            _buildKpiCard(
              icon: Icons.bed_rounded,
              value: '12',
              label: 'ICU Beds Available',
              subText: 'AIIMS Rishikesh',
              accentColor: AppColors.primaryLight,
            ),
            _buildKpiCard(
              icon: Icons.alarm_rounded,
              value: '18 min',
              label: 'ER Wait Time',
              subText: 'Moderate — walk-in',
              accentColor: AppColors.secondaryAccent,
            ),
            _buildKpiCard(
              icon: Icons.history_rounded,
              value: '2',
              label: 'Past ER Visits',
              subText: '2022 & 2024',
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
          // Accent bottom indicator
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
                        fontSize: 20,
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
