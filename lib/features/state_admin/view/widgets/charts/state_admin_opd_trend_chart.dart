import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class StateAdminOpdTrendChart extends StatelessWidget {
  const StateAdminOpdTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    final months = ['Jun', 'Aug', 'Oct', 'Dec', 'Feb', 'Apr'];
    final visits = [52000.0, 58000.0, 64000.0, 68241.0, 61000.0, 55000.0];

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
          const Text(
            'State OPD Trend (12 Months)',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Total Outpatient Visits Across All Connected Facilities',
            style: TextStyle(
              fontSize: 9.5,
              color: AppColors.secondaryText,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 140,
            width: double.infinity,
            child: CustomPaint(painter: _VisitsPainter(visits: visits)),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: months
                .map(
                  (m) => Text(
                    m,
                    style: const TextStyle(
                      fontSize: 8.5,
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

class _VisitsPainter extends CustomPainter {
  _VisitsPainter({required this.visits});

  final List<double> visits;

  @override
  void paint(Canvas canvas, Size size) {
    final maxVal = visits.reduce(max);
    final range = maxVal * 1.1;

    final xSteps = size.width / (visits.length - 1);

    double getY(double val) => size.height - (val / range * size.height);

    // Draw gridlines
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..strokeWidth = 1.0;
    for (var i = 1; i <= 3; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw visits line
    final path = Path()..moveTo(0, getY(visits[0]));
    for (var i = 1; i < visits.length; i++) {
      path.lineTo(i * xSteps, getY(visits[i]));
    }

    final linePaint = Paint()
      ..color = const Color(0xFF60A5FA)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, linePaint);

    final fillPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, getY(visits[0]));
    for (var i = 1; i < visits.length; i++) {
      fillPath.lineTo(i * xSteps, getY(visits[i]));
    }
    fillPath.lineTo(size.width, size.height);

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF60A5FA).withValues(alpha: 0.15),
          Colors.transparent,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
