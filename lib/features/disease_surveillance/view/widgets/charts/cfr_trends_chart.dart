import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class CfrTrendsChart extends StatelessWidget {
  const CfrTrendsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final months = ['Jun 24', 'Aug 24', 'Oct 24', 'Dec 24', 'Feb 25', 'Apr 25'];
    final cfr = [0.48, 0.42, 0.38, 0.35, 0.32, 0.31];
    const benchmark = 0.5;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Case Fatality Rate (CFR) Trend',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Monthly Overall CFR % YTD vs National NHM Benchmark (<0.5%)',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.secondaryText,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: AppColors.success.withValues(alpha: 0.3),
                  ),
                ),
                child: const Text(
                  'BENCHMARK MET',
                  style: TextStyle(
                    color: AppColors.success,
                    fontSize: 8.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              _LegendDot('Overall CFR %', AppColors.error),
              SizedBox(width: 16),
              Row(
                children: [
                  Text(
                    '- - - -',
                    style: TextStyle(
                      color: Color(0xFFFFD166),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'NHM Target Max (0.50%)',
                    style: TextStyle(
                      fontSize: 9.5,
                      color: AppColors.secondaryText,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            width: double.infinity,
            child: CustomPaint(
              painter: _CfrPainter(cfr: cfr, benchmark: benchmark),
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

class _CfrPainter extends CustomPainter {
  _CfrPainter({required this.cfr, required this.benchmark});

  final List<double> cfr;
  final double benchmark;

  @override
  void paint(Canvas canvas, Size size) {
    const range = 0.6; // Scale up to 0.6%

    final xSteps = size.width / (cfr.length - 1);

    double getY(double val) => size.height - (val / range * size.height);

    // Draw gridlines
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..strokeWidth = 1.0;
    for (var i = 1; i <= 3; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw benchmark line (dashed)
    final benchmarkY = getY(benchmark);
    final benchmarkPaint = Paint()
      ..color = const Color(0xFFFFD166).withValues(alpha: 0.5)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    double dx = 0;
    while (dx < size.width) {
      canvas.drawLine(
        Offset(dx, benchmarkY),
        Offset(dx + 5, benchmarkY),
        benchmarkPaint,
      );
      dx += 10;
    }

    // Draw CFR line
    final path = Path()..moveTo(0, getY(cfr[0]));
    for (var i = 1; i < cfr.length; i++) {
      path.lineTo(i * xSteps, getY(cfr[i]));
    }
    final linePaint = Paint()
      ..color = AppColors.error
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, linePaint);

    // Draw points
    final pointPaint = Paint()
      ..color = AppColors.error
      ..style = PaintingStyle.fill;
    for (var i = 0; i < cfr.length; i++) {
      canvas.drawCircle(Offset(i * xSteps, getY(cfr[i])), 3, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
