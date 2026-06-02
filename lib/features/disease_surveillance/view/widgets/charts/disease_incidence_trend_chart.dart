import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class DiseaseIncidenceTrendChart extends StatelessWidget {
  const DiseaseIncidenceTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    final months = ['Jun 24', 'Aug 24', 'Oct 24', 'Dec 24', 'Feb 25', 'Apr 25'];
    final vbd = [2800.0, 3100.0, 4200.0, 3600.0, 2100.0, 1800.0];
    final respiratory = [8000.0, 9200.0, 11500.0, 14200.0, 12800.0, 9800.0];
    final wbd = [900.0, 1100.0, 1400.0, 850.0, 780.0, 1050.0];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notifiable Disease Incidence Trends',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Monthly Case Count by Disease Category (Last 12 Months)',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.secondaryText,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Legend
          const Row(
            children: [
              _LegendDot('Vector-borne (VBD)', Color(0xFFFFD166)),
              SizedBox(width: 12),
              _LegendDot('Respiratory (ILI)', AppColors.secondaryAccent),
              SizedBox(width: 12),
              _LegendDot('Water-borne (WBD)', AppColors.primaryLight),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            width: double.infinity,
            child: CustomPaint(
              painter: _IncidencePainter(
                vbd: vbd,
                respiratory: respiratory,
                wbd: wbd,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: months
                .map(
                  (m) => Text(
                    m,
                    style: const TextStyle(
                      fontSize: 9,
                      color: AppColors.secondaryText,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot(this.label, this.color);
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 9.5,
            color: AppColors.secondaryText,
            fontFamily: AppTextStyles.fontFamily,
          ),
        ),
      ],
    );
  }
}

class _IncidencePainter extends CustomPainter {
  _IncidencePainter({
    required this.vbd,
    required this.respiratory,
    required this.wbd,
  });

  final List<double> vbd;
  final List<double> respiratory;
  final List<double> wbd;

  @override
  void paint(Canvas canvas, Size size) {
    final maxVal = [
      vbd.reduce(max),
      respiratory.reduce(max),
      wbd.reduce(max),
    ].reduce(max);
    final range = maxVal * 1.1;

    final xSteps = size.width / (vbd.length - 1);

    double getY(double val) => size.height - (val / range * size.height);

    void drawLine(List<double> values, Color color) {
      final path = Path()..moveTo(0, getY(values[0]));
      for (var i = 1; i < values.length; i++) {
        path.lineTo(i * xSteps, getY(values[i]));
      }
      final paint = Paint()
        ..color = color
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(path, paint);
    }

    // Gridlines
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..strokeWidth = 1.0;
    for (var i = 1; i <= 3; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw lines
    drawLine(vbd, const Color(0xFFFFD166));
    drawLine(respiratory, AppColors.secondaryAccent);
    drawLine(wbd, AppColors.primaryLight);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
