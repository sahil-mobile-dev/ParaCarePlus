import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class QuickStatsStrip extends StatelessWidget {
  const QuickStatsStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 760;
    final isTablet = screenWidth >= 760 && screenWidth < 1100;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isMobile ? 2 : (isTablet ? 4 : 8),
      crossAxisSpacing: AppSpacing.sm,
      mainAxisSpacing: AppSpacing.sm,
      childAspectRatio: isMobile ? 1.6 : 1.3,
      children: const [
        _QuickStatCard(
          val: '1,847',
          lbl: 'Active Facilities',
          delta: '↑ 12 new this month',
          isUp: true,
          accentColors: [AppColors.primaryLight, AppColors.primary],
        ),
        _QuickStatCard(
          val: '14,823',
          lbl: 'OPD Today',
          delta: '↑ 5.2%',
          isUp: true,
          accentColors: [Color(0xFF00695C), Color(0xFF00897B)],
        ),
        _QuickStatCard(
          val: '3,241',
          lbl: 'IPD Admissions',
          delta: '↓ 1.3%',
          isUp: false,
          accentColors: [Color(0xFFE65100), Color(0xFFF9A825)],
        ),
        _QuickStatCard(
          val: '87.4%',
          lbl: 'Bed Occupancy',
          delta: '↑ Critical',
          isUp: true,
          accentColors: [AppColors.success, Color(0xFF388E3C)],
        ),
        _QuickStatCard(
          val: '₹18.4Cr',
          lbl: 'AB Claims Today',
          delta: '94.2% approved',
          isUp: true,
          accentColors: [Color(0xFF4527A0), Color(0xFF5E35B1)],
        ),
        _QuickStatCard(
          val: '1,247',
          lbl: 'Telemedicine',
          delta: 'Record High',
          isUp: true,
          accentColors: [Color(0xFF00838F), Color(0xFF0097A7)],
        ),
        _QuickStatCard(
          val: '42',
          lbl: 'Critical Alerts',
          delta: '↑ 8 new',
          isUp: false,
          accentColors: [Color(0xFFC62828), Color(0xFFD32F2F)],
        ),
        _QuickStatCard(
          val: '96.8%',
          lbl: 'ABDM API Uptime',
          delta: 'Good',
          isUp: true,
          accentColors: [Color(0xFF4A148C), Color(0xFF6A1B9A)],
        ),
      ],
    );
  }
}

class _QuickStatCard extends StatelessWidget {
  const _QuickStatCard({
    required this.val,
    required this.lbl,
    required this.delta,
    required this.isUp,
    required this.accentColors,
  });
  final String val;
  final String lbl;
  final String delta;
  final bool isUp;
  final List<Color> accentColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.md,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  val,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryText,
                    fontFamily: AppTextStyles.fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                Text(
                  lbl.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 9,
                    color: AppColors.secondaryText,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                    fontFamily: AppTextStyles.fontFamily,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  delta,
                  style: TextStyle(
                    fontSize: 10,
                    color: isUp ? AppColors.success : AppColors.error,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppTextStyles.fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 3,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: accentColors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
