import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class MchDeliveryTrendChart extends StatelessWidget {
  const MchDeliveryTrendChart({super.key});

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
            'INSTITUTIONAL DELIVERY & ANC COVERAGE — 12 MONTHS',
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
                    Text('100%', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('80%', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('60%', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('40%', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomPaint(
                    painter: _TrendPainter(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legendDot('Inst. Delivery %', const Color(0xFFF72585)),
              const SizedBox(width: 16),
              _legendDot('4+ ANC Visits %', AppColors.success),
              const SizedBox(width: 16),
              _legendDot('1st Trimester ANC %', AppColors.primaryLight),
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

class _TrendPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.15)
      ..strokeWidth = 1.0;

    for (int i = 0; i < 4; i++) {
      final y = size.height * i / 3;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final instDel = [92.0, 93.0, 92.5, 94.0, 93.5, 94.2, 95.0, 94.8, 95.5, 96.0, 95.2, 94.2];
    final anc4 = [70.0, 71.5, 71.0, 72.8, 72.0, 73.5, 74.0, 73.8, 74.5, 75.0, 73.2, 72.8];
    final earlyAnc = [74.0, 75.0, 74.5, 76.4, 75.5, 77.0, 78.0, 77.5, 78.5, 79.0, 77.2, 76.4];

    _drawPath(canvas, size, instDel, const Color(0xFFF72585));
    _drawPath(canvas, size, anc4, AppColors.success);
    _drawPath(canvas, size, earlyAnc, AppColors.primaryLight);
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
      // Map 40% - 100%
      final val = data[i];
      final y = size.height * (1.0 - (val - 40) / 60).clamp(0.0, 1.0);
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
