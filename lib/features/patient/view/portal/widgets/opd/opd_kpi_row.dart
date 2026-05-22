import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class OpdKpiRow extends StatelessWidget {
  const OpdKpiRow({super.key});

  Widget buildKpiCard({
    required BuildContext context,
    required IconData icon,
    required Color accentColor,
    required String value,
    required String label,
    required String subtext,
    required String badgeText,
    required Color badgeBg,
    required Color badgeTextCol,
  }) {
    return Container(
      width: 170,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          // Accent top border line
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 3,
            child: Container(
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
            ),
          ),
          // Badge
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: badgeBg,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                badgeText,
                style: TextStyle(
                  color: badgeTextCol,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Icon(icon, color: accentColor, size: 20),
                const SizedBox(height: 12),
                Text(
                  value,
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtext,
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        children: [
          buildKpiCard(
            context: context,
            icon: Icons.calendar_today_rounded,
            accentColor: AppColors.primaryLight,
            value: '3',
            label: 'Upcoming Visits',
            subtext: 'Next: 20 May, Cardio',
            badgeText: 'SCHEDULED',
            badgeBg: AppColors.primary.withValues(alpha: 0.12),
            badgeTextCol: AppColors.primaryLight,
          ),
          buildKpiCard(
            context: context,
            icon: Icons.tag_rounded,
            accentColor: AppColors.success,
            value: '47',
            label: 'My Queue Number',
            subtext: 'Serving: 38 (Room 4)',
            badgeText: '9 AHEAD',
            badgeBg: AppColors.secondaryAccent.withValues(alpha: 0.12),
            badgeTextCol: AppColors.secondaryAccent,
          ),
          buildKpiCard(
            context: context,
            icon: Icons.timer_outlined,
            accentColor: AppColors.secondaryAccent,
            value: '~27',
            label: 'AI Wait Time (min)',
            subtext: 'AI prediction ±5 min',
            badgeText: 'LIVE',
            badgeBg: AppColors.secondaryAccent.withValues(alpha: 0.12),
            badgeTextCol: AppColors.secondaryAccent,
          ),
          buildKpiCard(
            context: context,
            icon: Icons.video_call_rounded,
            accentColor: Colors.blueAccent,
            value: '2',
            label: 'Telehealth Online',
            subtext: 'Today · 3 PM – 6 PM',
            badgeText: 'ONLINE',
            badgeBg: AppColors.success.withValues(alpha: 0.12),
            badgeTextCol: AppColors.success,
          ),
          buildKpiCard(
            context: context,
            icon: Icons.check_circle_rounded,
            accentColor: Colors.tealAccent,
            value: '18',
            label: 'Completed Visits',
            subtext: 'Since 2018 · Recorded',
            badgeText: 'EMR LINKED',
            badgeBg: AppColors.success.withValues(alpha: 0.12),
            badgeTextCol: AppColors.success,
          ),
        ],
      ),
    );
  }
}
