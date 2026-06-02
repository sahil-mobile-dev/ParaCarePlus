import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class MchMortalityTrendChart extends StatelessWidget {
  const MchMortalityTrendChart({super.key});

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
            'MMR / IMR / NMR TREND — 5 YEARS',
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
                    Text('200', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('150', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('100', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('50', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('0', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomPaint(
                    painter: _MortalityPainter(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legendDot('MMR (/LB)', AppColors.error),
              const SizedBox(width: 16),
              _legendDot('IMR (/1K LB)', AppColors.secondaryAccent),
              const SizedBox(width: 16),
              _legendDot('NMR (/1K LB)', const Color(0xFFC77DFF)),
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

class _MortalityPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.15)
      ..strokeWidth = 1.0;

    for (int i = 0; i < 5; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final mmr = [148.0, 138.0, 128.0, 120.0, 112.0];
    // Map IMR and NMR to same chart height scale by multiplying by 3 to overlap cleanly
    final imr = [38.0 * 3, 36.0 * 3, 34.0 * 3, 32.0 * 3, 28.0 * 3];
    final nmr = [24.0 * 3, 23.0 * 3, 22.0 * 3, 21.0 * 3, 18.0 * 3];

    _drawPath(canvas, size, mmr, AppColors.error);
    _drawPath(canvas, size, imr, AppColors.secondaryAccent);
    _drawPath(canvas, size, nmr, const Color(0xFFC77DFF));
  }

  void _drawPath(Canvas canvas, Size size, List<double> data, Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final stepX = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      // Map 0 to 200
      final val = data[i];
      final y = size.height * (1.0 - val / 200).clamp(0.0, 1.0);
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
