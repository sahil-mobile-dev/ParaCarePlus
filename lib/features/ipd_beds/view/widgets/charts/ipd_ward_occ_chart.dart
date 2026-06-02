import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class IpdWardOccChart extends StatelessWidget {
  const IpdWardOccChart({super.key});

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
            'WARD-WISE OCCUPANCY — OCCUPIED VS AVAILABLE',
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
                // Y-Axis Wards labels
                SizedBox(
                  width: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text('Gen Medicine', style: TextStyle(color: AppColors.secondaryText, fontSize: 9), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text('Surgery', style: TextStyle(color: AppColors.secondaryText, fontSize: 9), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text('Orthopaedics', style: TextStyle(color: AppColors.secondaryText, fontSize: 9), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text('Gynaecology', style: TextStyle(color: AppColors.secondaryText, fontSize: 9), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text('Paediatrics', style: TextStyle(color: AppColors.secondaryText, fontSize: 9), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text('ICU General', style: TextStyle(color: AppColors.secondaryText, fontSize: 9), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text('HDU', style: TextStyle(color: AppColors.secondaryText, fontSize: 9), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text('NICU', style: TextStyle(color: AppColors.secondaryText, fontSize: 9), maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomPaint(
                    painter: _HorizBarPainter(),
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
                  Container(width: 10, height: 10, decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.75), borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 4),
                  const Text('Occupied', style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  Container(width: 10, height: 10, decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.35), borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 4),
                  const Text('Available', style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HorizBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final occ = [847, 624, 412, 384, 298, 418, 601, 217];
    final total = [1020, 780, 520, 480, 380, 460, 842, 318];

    final numBars = occ.length;
    final barSpacing = size.height / numBars;
    final barHeight = barSpacing * 0.5;

    final occPaint = Paint()..color = AppColors.error.withValues(alpha: 0.75);
    final avPaint = Paint()..color = AppColors.success.withValues(alpha: 0.35);

    for (int i = 0; i < numBars; i++) {
      final y = i * barSpacing + (barSpacing - barHeight) / 2;
      final maxVal = total[i].toDouble();
      final occVal = occ[i].toDouble();

      final widthScale = size.width / 1100; // max reference width

      final totalW = maxVal * widthScale;
      final occW = occVal * widthScale;
      final avW = (maxVal - occVal) * widthScale;

      // Available background
      final avRect = Rect.fromLTWH(0, y, totalW, barHeight);
      canvas.drawRRect(RRect.fromRectAndRadius(avRect, const Radius.circular(2)), avPaint);

      // Occupied overlay
      final occRect = Rect.fromLTWH(0, y, occW, barHeight);
      canvas.drawRRect(RRect.fromRectAndRadius(occRect, const Radius.circular(2)), occPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
