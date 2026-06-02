import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class IpdOccupancyTrendChart extends StatelessWidget {
  const IpdOccupancyTrendChart({super.key});

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
            'BED OCCUPANCY TREND — 30 DAYS (BY WARD)',
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
                // Y Axis Ticks
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('100%', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('80%', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('60%', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('40%', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('20%', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                  ],
                ),
                const SizedBox(width: 8),
                // Graph canvas
                Expanded(
                  child: CustomPaint(
                    painter: _LineChartPainter(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legendDot('Gen', const Color(0xFF00B4D8)),
              const SizedBox(width: 12),
              _legendDot('Surg', const Color(0xFF00C897)),
              const SizedBox(width: 12),
              _legendDot('ICU', AppColors.error),
              const SizedBox(width: 12),
              _legendDot('HDU', const Color(0xFFC77DFF)),
              const SizedBox(width: 12),
              _legendDot('NICU', AppColors.secondaryAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendDot(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
      ],
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw horizontal grid lines
    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.15)
      ..strokeWidth = 1.0;

    for (int i = 0; i < 5; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Wards trends datasets
    final gen = [72, 75, 71, 74, 76, 73, 75, 78, 77, 80, 82, 81, 79, 83, 85, 84, 82, 86, 88, 85, 87, 89, 90, 87, 89, 92, 91, 88, 93, 94];
    final surg = [80, 81, 79, 82, 84, 83, 81, 84, 86, 85, 83, 87, 89, 88, 86, 90, 92, 91, 89, 93, 95, 94, 92, 95, 97, 96, 94, 97, 98, 95];
    final icu = [85, 86, 84, 88, 90, 89, 87, 91, 93, 92, 90, 94, 96, 95, 93, 97, 99, 98, 96, 100, 98, 99, 97, 100, 99, 98, 96, 99, 100, 97];
    final hdu = [71, 73, 70, 72, 74, 73, 71, 75, 77, 76, 74, 78, 80, 79, 77, 81, 83, 82, 80, 84, 86, 85, 83, 87, 89, 88, 86, 89, 90, 87];
    final nicu = [68, 69, 67, 70, 72, 71, 69, 73, 75, 74, 72, 76, 78, 77, 75, 79, 81, 80, 78, 82, 84, 83, 81, 85, 87, 86, 84, 87, 88, 85];

    _drawTrendLine(canvas, size, gen, const Color(0xFF00B4D8));
    _drawTrendLine(canvas, size, surg, const Color(0xFF00C897));
    _drawTrendLine(canvas, size, icu, AppColors.error);
    _drawTrendLine(canvas, size, hdu, const Color(0xFFC77DFF));
    _drawTrendLine(canvas, size, nicu, AppColors.secondaryAccent);
  }

  void _drawTrendLine(Canvas canvas, Size size, List<int> data, Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final stepX = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      // Map data from 40% - 105%
      final val = data[i].toDouble();
      final y = size.height * (1.0 - (val - 40) / 65).clamp(0.0, 1.0);
      final x = i * stepX;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
