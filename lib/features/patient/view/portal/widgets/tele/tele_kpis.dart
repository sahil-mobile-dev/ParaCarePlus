import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class TeleKpis extends StatelessWidget {
  const TeleKpis({super.key});

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
          childAspectRatio: constraints.maxWidth > 900 ? 1.3 : 1.45,
          children: [
            _buildKpiCard(
              icon: Icons.video_call_rounded,
              value: '14',
              label: 'Total Consultations',
              subText: 'Last 12 months',
              accentColor: const Color(0xFF00B4D8), // Accent blue
            ),
            _buildKpiCard(
              icon: Icons.calendar_today_rounded,
              value: '2',
              label: 'Upcoming Sessions',
              subText: 'Next: 18 May',
              accentColor: AppColors.success,
            ),
            _buildKpiCard(
              icon: Icons.star_rounded,
              value: '4.7 / 5',
              label: 'Avg Rating Given',
              subText: 'High satisfaction',
              accentColor: const Color(0xFFFFD166), // Yellow
            ),
            _buildKpiCard(
              icon: Icons.access_time_rounded,
              value: '18 min',
              label: 'Avg Session Duration',
              subText: 'Efficient consultations',
              accentColor: AppColors.primaryLight,
            ),
            _buildKpiCard(
              icon: Icons.currency_rupee_rounded,
              value: '₹4,200',
              label: 'Total Tele-Cost Saved',
              subText: 'vs in-person travel',
              accentColor: const Color(0xFFC77DFF), // Purple
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
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Top accent strip
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 3,
            child: Container(color: accentColor),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 15, 12, 12),
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
                    const SizedBox(height: 2),
                    Text(
                      subText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.success == accentColor
                            ? AppColors.success
                            : accentColor,
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
