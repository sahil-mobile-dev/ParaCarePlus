import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class IpdAdmDisChart extends StatelessWidget {
  const IpdAdmDisChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ADMISSION VS DISCHARGE — DAILY (LAST 12 DAYS)',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: AppColors.secondaryText,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('4K', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('3K', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('2K', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('1K', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('0', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomPaint(
                    painter: _BarChartPainter(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(width: 10, height: 10, decoration: BoxDecoration(color: AppColors.primaryLight.withValues(alpha: 0.75), borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 4),
                  const Text('Admissions', style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  Container(width: 10, height: 10, decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.75), borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 4),
                  const Text('Discharges', style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw grid
    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.15)
      ..strokeWidth = 1.0;

    for (int i = 0; i < 5; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final admissions = [3400, 3600, 3500, 3800, 3700, 3900, 3850, 4100, 4000, 3950, 4200, 3847];
    final discharges = [3300, 3450, 3550, 3600, 3650, 3800, 3700, 3900, 3800, 3850, 4000, 3612];

    final numGroups = admissions.length;
    final groupWidth = size.width / numGroups;
    final barWidth = groupWidth * 0.35;
    final gap = groupWidth * 0.1;

    final admPaint = Paint()..color = AppColors.primaryLight.withValues(alpha: 0.75);
    final disPaint = Paint()..color = AppColors.success.withValues(alpha: 0.75);

    for (int i = 0; i < numGroups; i++) {
      final startX = i * groupWidth + gap;

      // Admissions Bar
      final admVal = admissions[i].toDouble();
      final admHeight = size.height * (admVal / 4500);
      final admRect = Rect.fromLTWH(startX, size.height - admHeight, barWidth, admHeight);
      canvas.drawRRect(RRect.fromRectAndCorners(admRect, topLeft: const Radius.circular(2), topRight: const Radius.circular(2)), admPaint);

      // Discharges Bar
      final disVal = discharges[i].toDouble();
      final disHeight = size.height * (disVal / 4500);
      final disRect = Rect.fromLTWH(startX + barWidth + gap, size.height - disHeight, barWidth, disHeight);
      canvas.drawRRect(RRect.fromRectAndCorners(disRect, topLeft: const Radius.circular(2), topRight: const Radius.circular(2)), disPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
