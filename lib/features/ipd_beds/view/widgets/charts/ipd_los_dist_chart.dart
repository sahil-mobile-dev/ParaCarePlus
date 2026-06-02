import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class IpdLosDistChart extends StatelessWidget {
  const IpdLosDistChart({super.key});

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
            'LENGTH OF STAY (LOS) DISTRIBUTION',
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
                Expanded(child: CustomPaint(painter: _DoughnutChartPainter())),
                // Legend
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _legendItem('1 day (18.2%)', const Color(0xFF00B4D8)),
                    _legendItem('2-3 days (28.4%)', const Color(0xFF00C897)),
                    _legendItem('4-5 days (22.6%)', const Color(0xFFFFD166)),
                    _legendItem('6-7 days (14.3%)', const Color(0xFFF77F00)),
                    _legendItem('8-14 days (11.8%)', AppColors.error),
                    _legendItem('>14 days (4.7%)', const Color(0xFFC77DFF)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendItem(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 9.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _DoughnutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2.2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final values = [18.2, 28.4, 22.6, 14.3, 11.8, 4.7];
    final colors = [
      const Color(0xFF00B4D8),
      const Color(0xFF00C897),
      const Color(0xFFFFD166),
      const Color(0xFFF77F00),
      AppColors.error,
      const Color(0xFFC77DFF),
    ];

    double startAngle = -pi / 2;

    for (int i = 0; i < values.length; i++) {
      final sweepAngle = (values[i] / 100) * 2 * pi;

      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 24;

      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
