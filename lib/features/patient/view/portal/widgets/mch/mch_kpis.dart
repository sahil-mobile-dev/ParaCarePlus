import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class MchKpis extends StatelessWidget {
  const MchKpis({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 900
            ? 6
            : (constraints.maxWidth > 600 ? 3 : 2);

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: constraints.maxWidth > 900 ? 1.15 : 1.45,
          children: [
            _buildKpiCard(
              icon: Icons.child_care_rounded,
              value: '2',
              label: 'Children Registered',
              subText: 'Active health cards',
              accentColor: const Color(0xFFF72585), // Pink
            ),
            _buildKpiCard(
              icon: Icons.vaccines_rounded,
              value: '100%',
              label: 'Child Immunization',
              subText: 'Up to date',
              accentColor: AppColors.success,
            ),
            _buildKpiCard(
              icon: Icons.scale_rounded,
              value: 'Normal',
              label: 'Growth Status',
              subText: 'Both kids on track',
              accentColor: AppColors.secondaryAccent,
            ),
            _buildKpiCard(
              icon: Icons.baby_changing_station_rounded,
              value: '4',
              label: 'Well-Baby Visits',
              subText: 'Next: Jun 2026',
              accentColor: Colors.purpleAccent,
            ),
            _buildKpiCard(
              icon: Icons.health_and_safety_rounded,
              value: 'Normal',
              label: 'Spouse Health Status',
              subText: 'Geeta — Annual OK',
              accentColor: Colors.tealAccent,
            ),
            _buildKpiCard(
              icon: Icons.warning_amber_rounded,
              value: '1',
              label: 'Pending Checkup',
              subText: 'Daughter — dental due',
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
                        fontSize: 18,
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
