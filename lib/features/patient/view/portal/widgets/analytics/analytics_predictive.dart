import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AnalyticsPredictive extends StatelessWidget {
  const AnalyticsPredictive({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        var crossAxisCount = 1;
        if (width > 950) {
          crossAxisCount = 3;
        } else if (width > 650) {
          crossAxisCount = 2;
        }

        return GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.15,
          ),
          children: [
            _buildPredictiveCard(
              title: 'Risk Radar — Current vs 1Y Projection',
              icon: Icons.radar_rounded,
              child: const CustomRadarChart(),
            ),
            _buildPredictiveCard(
              title: 'Health Score History (12 Months)',
              icon: Icons.stacked_line_chart_rounded,
              child: const CustomScoreHistoryChart(),
            ),
            _buildPredictiveCard(
              title: 'Wellness Dimension Pie',
              icon: Icons.pie_chart_rounded,
              child: const CustomWellnessDonutChart(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPredictiveCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFC77DFF), size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.labelLarge.copyWith(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// 1. RADAR CHART
class CustomRadarChart extends StatelessWidget {
  const CustomRadarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.infinite, painter: _RadarPainter());
  }
}

class _RadarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) * 0.38;

    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.5)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // Draw concentric circles / polygons
    const concentricLevels = 4;
    for (var i = 1; i <= concentricLevels; i++) {
      final currentRadius = radius * (i / concentricLevels);
      canvas.drawCircle(center, currentRadius, gridPaint);
    }

    final indicators = [
      'CVD Risk',
      'Diabetes',
      'Hypert.',
      'Obesity',
      'Cholest.',
      'Mental',
      'Activity',
      'Sleep',
    ];
    final numPoints = indicators.length;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Draw axis lines and labels
    for (var i = 0; i < numPoints; i++) {
      final angle = (i * 2 * math.pi / numPoints) - (math.pi / 2);
      final point = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(center, point, gridPaint);

      // Labels
      final labelPoint = Offset(
        center.dx + (radius + 16) * math.cos(angle),
        center.dy + (radius + 10) * math.sin(angle),
      );
      textPainter
        ..text = TextSpan(
          text: indicators[i],
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 8),
        )
        ..layout()
        ..paint(
          canvas,
          Offset(
            labelPoint.dx - textPainter.width / 2,
            labelPoint.dy - textPainter.height / 2,
          ),
        );
    }

    // Draw Current values (CVD, Diabetes, Hypertension, Obesity, Cholesterol, Mental, Activity, Sleep)
    final currentValues = [42, 55, 60, 52, 65, 38, 60, 55];
    final projectionValues = [50, 65, 70, 56, 72, 45, 68, 60];

    _drawRadarPolygon(
      canvas,
      center,
      radius,
      currentValues,
      AppColors.error,
      numPoints,
    );
    _drawRadarPolygon(
      canvas,
      center,
      radius,
      projectionValues,
      AppColors.secondaryAccent,
      numPoints,
    );
  }

  void _drawRadarPolygon(
    Canvas canvas,
    Offset center,
    double radius,
    List<int> values,
    Color color,
    int numPoints,
  ) {
    final path = Path();
    for (var i = 0; i < numPoints; i++) {
      final angle = (i * 2 * math.pi / numPoints) - (math.pi / 2);
      final valPercent = values[i] / 100.0;
      final x = center.dx + radius * valPercent * math.cos(angle);
      final y = center.dy + radius * valPercent * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas
      ..drawPath(
        path,
        Paint()
          ..color = color.withValues(alpha: 0.15)
          ..style = PaintingStyle.fill,
      )
      ..drawPath(
        path,
        Paint()
          ..color = color
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 2. HISTORY CHART
class CustomScoreHistoryChart extends StatelessWidget {
  const CustomScoreHistoryChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.infinite, painter: _HistoryPainter());
  }
}

class _HistoryPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.5)
      ..strokeWidth = 0.5;

    // Draw horizontal grid lines
    const gridLinesCount = 3;
    for (var i = 0; i <= gridLinesCount; i++) {
      final y = size.height * (i / gridLinesCount);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final scores = [
      76.0,
      74.0,
      72.0,
      73.0,
      71.0,
      70.0,
      69.0,
      68.0,
      67.0,
      68.0,
      67.0,
      66.0,
    ];
    final months = [
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
    ];
    final pointsCount = scores.length;
    final segmentWidth = size.width / (pointsCount - 1);

    final linePaint = Paint()
      ..color = AppColors.primaryLight
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final areaPaint = Paint()
      ..color = AppColors.primaryLight.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final areaPath = Path();

    const minVal = 55;
    const maxVal = 90;

    for (var i = 0; i < pointsCount; i++) {
      final y =
          size.height -
          ((scores[i] - minVal) / (maxVal - minVal)) * size.height;
      final x = i * segmentWidth;

      if (i == 0) {
        path.moveTo(x, y);
        areaPath
          ..moveTo(x, size.height)
          ..lineTo(x, y);
      } else {
        path.lineTo(x, y);
        areaPath.lineTo(x, y);
      }

      if (i == pointsCount - 1) {
        areaPath
          ..lineTo(x, size.height)
          ..close();
      }

      // Draw point dots
      canvas.drawCircle(
        Offset(x, y),
        3,
        Paint()..color = AppColors.primaryLight,
      );
    }

    canvas
      ..drawPath(areaPath, areaPaint)
      ..drawPath(path, linePaint);

    // Draw average line
    final avgPaint = Paint()
      ..color = AppColors.secondaryAccent
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    const avgScore = 70.0;
    final avgY =
        size.height - ((avgScore - minVal) / (maxVal - minVal)) * size.height;
    canvas.drawLine(Offset(0, avgY), Offset(size.width, avgY), avgPaint);

    // Draw months label
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    for (var i = 0; i < pointsCount; i += 2) {
      final x = i * segmentWidth;
      textPainter
        ..text = TextSpan(
          text: months[i],
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 8),
        )
        ..layout()
        ..paint(
          canvas,
          Offset(x - textPainter.width / 2, size.height - 12),
        );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 3. PIE CHART
class CustomWellnessDonutChart extends StatelessWidget {
  const CustomWellnessDonutChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.infinite, painter: _PiePainter());
  }
}

class _PiePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.35, size.height / 2);
    final outerRadius = math.min(size.width, size.height) * 0.35;
    final innerRadius = outerRadius * 0.55;

    final dimensions = [
      _PieSegment('Physical', 78, AppColors.primaryLight),
      _PieSegment('Mental', 72, const Color(0xFFC77DFF)),
      _PieSegment('Social', 65, AppColors.success),
      _PieSegment('Nutritional', 70, AppColors.secondaryAccent),
      _PieSegment('Sleep', 68, const Color(0xFF3A86FF)),
      _PieSegment('Preventive', 80, const Color(0xFFF77F00)),
    ];

    final totalValue = dimensions.fold(
      0,
      (sum, item) => sum + int.parse(item.value.toString()),
    );
    var startAngle = -math.pi / 2;

    for (final seg in dimensions) {
      final sweepAngle = (seg.value / totalValue) * 2 * math.pi;

      final paint = Paint()
        ..color = seg.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = outerRadius - innerRadius;

      canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: (outerRadius + innerRadius) / 2,
        ),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }

    // Draw center donut hole background
    canvas.drawCircle(center, innerRadius, Paint()..color = AppColors.card);

    // Draw Legends to the right
    final legendX = size.width * 0.70;
    var legendY = size.height * 0.15;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (final seg in dimensions) {
      // Legend color dot
      canvas.drawCircle(
        Offset(legendX - 8, legendY + 5),
        4,
        Paint()..color = seg.color,
      );

      // Legend Text
      textPainter
        ..text = TextSpan(
          text: '${seg.name} (${seg.value}%)',
          style: const TextStyle(
            color: AppColors.primaryText,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        )
        ..layout()
        ..paint(canvas, Offset(legendX, legendY));
      legendY += 20;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PieSegment {
  _PieSegment(this.name, this.value, this.color);
  final String name;
  final double value;
  final Color color;
}
