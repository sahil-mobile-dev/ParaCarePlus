import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class ChronicTrendRadar extends StatelessWidget {
  const ChronicTrendRadar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = AppSpacing.md;
        final isLargeScreen = constraints.maxWidth > 900;

        final charts = [
          _buildChartContainer(
            title: 'BP Control — 6 Month Trend',
            icon: Icons.heart_broken_outlined,
            child: SizedBox(
              height: 200,
              child: CustomPaint(painter: BpTrendPainter(), child: Container()),
            ),
          ),
          _buildChartContainer(
            title: 'Blood Sugar Control — 6 Months',
            icon: Icons.bloodtype_outlined,
            child: SizedBox(
              height: 200,
              child: CustomPaint(
                painter: BloodSugarTrendPainter(),
                child: Container(),
              ),
            ),
          ),
          _buildChartContainer(
            title: 'Multi-Condition Risk Radar',
            icon: Icons.radar_outlined,
            child: SizedBox(
              height: 200,
              child: CustomPaint(
                painter: RiskRadarPainter(),
                child: Container(),
              ),
            ),
          ),
        ];

        if (isLargeScreen) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: charts[0]),
              const SizedBox(width: spacing),
              Expanded(child: charts[1]),
              const SizedBox(width: spacing),
              Expanded(child: charts[2]),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              charts[0],
              const SizedBox(height: spacing),
              charts[1],
              const SizedBox(height: spacing),
              charts[2],
            ],
          );
        }
      },
    );
  }

  Widget _buildChartContainer({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primaryLight, size: 14),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class BpTrendPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final months = ['Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May'];
    final systolic = [132, 130, 128, 131, 129, 128];
    final diastolic = [84, 83, 82, 83, 82, 82];

    final paintGrid = Paint()
      ..color = AppColors.border.withValues(alpha: 0.3)
      ..strokeWidth = 1;

    final stepX = size.width / (months.length - 1);
    const double minY = 60;
    const double maxY = 150;
    final scaleY = size.height / (maxY - minY);

    // Draw horizontal grid lines
    for (var i = 0; i <= 4; i++) {
      final yVal = minY + (maxY - minY) * (i / 4);
      final y = size.height - (yVal - minY) * scaleY;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paintGrid);
    }

    final pathSys = Path();
    final pathDia = Path();

    for (var i = 0; i < months.length; i++) {
      final x = i * stepX;
      final ySys = size.height - (systolic[i] - minY) * scaleY;
      final yDia = size.height - (diastolic[i] - minY) * scaleY;

      if (i == 0) {
        pathSys.moveTo(x, ySys);
        pathDia.moveTo(x, yDia);
      } else {
        pathSys.lineTo(x, ySys);
        pathDia.lineTo(x, yDia);
      }
    }
    // Paint Systolic and Diastolic Lines
    canvas
      ..drawPath(
        pathSys,
        Paint()
          ..color = AppColors.error
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke,
      )
      ..drawPath(
        pathDia,
        Paint()
          ..color = AppColors.secondaryAccent
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke,
      );

    // Draw dots and text
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    for (var i = 0; i < months.length; i++) {
      final x = i * stepX;
      final ySys = size.height - (systolic[i] - minY) * scaleY;
      final yDia = size.height - (diastolic[i] - minY) * scaleY;

      canvas
        ..drawCircle(Offset(x, ySys), 3.5, Paint()..color = AppColors.error)
        ..drawCircle(
          Offset(x, yDia),
          3,
          Paint()..color = AppColors.secondaryAccent,
        );

      // Label months
      textPainter
        ..text = TextSpan(
          text: months[i],
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 8.5),
        )
        ..layout()
        ..paint(canvas, Offset(x - textPainter.width / 2, size.height - 12));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BloodSugarTrendPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final months = ['Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May'];
    final fpg = [136, 138, 140, 139, 141, 142];

    final paintGrid = Paint()
      ..color = AppColors.border.withValues(alpha: 0.3)
      ..strokeWidth = 1;

    final stepX = size.width / (months.length - 1);
    const double minY = 100;
    const double maxY = 180;
    final scaleY = size.height / (maxY - minY);

    // Draw horizontal grid lines
    for (var i = 0; i <= 4; i++) {
      final yVal = minY + (maxY - minY) * (i / 4);
      final y = size.height - (yVal - minY) * scaleY;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paintGrid);
    }

    // Target Line (Green, dashed-like)
    final yTarget = size.height - (126 - minY) * scaleY;
    canvas.drawLine(
      Offset(0, yTarget),
      Offset(size.width, yTarget),
      Paint()
        ..color = AppColors.success
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke,
    );

    final pathFpg = Path();
    for (var i = 0; i < months.length; i++) {
      final x = i * stepX;
      final yFpg = size.height - (fpg[i] - minY) * scaleY;

      if (i == 0) {
        pathFpg.moveTo(x, yFpg);
      } else {
        pathFpg.lineTo(x, yFpg);
      }
    }

    // Paint Fasting Glucose Line (Orange)
    canvas.drawPath(
      pathFpg,
      Paint()
        ..color = AppColors.secondaryAccent
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );

    // Draw dots and text
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    for (var i = 0; i < months.length; i++) {
      final x = i * stepX;
      final yFpg = size.height - (fpg[i] - minY) * scaleY;

      canvas.drawCircle(
        Offset(x, yFpg),
        3.5,
        Paint()..color = AppColors.secondaryAccent,
      );

      // Label months
      textPainter
        ..text = TextSpan(
          text: months[i],
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 8.5),
        )
        ..layout()
        ..paint(canvas, Offset(x - textPainter.width / 2, size.height - 12));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RiskRadarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final indicators = [
      'BP',
      'Diabetes',
      'Cholesterol',
      'Obesity',
      'Sleep',
      'Stress',
      'Liver',
      'Joints',
      'Mental',
    ];
    final current = [65.0, 68.0, 60.0, 45.0, 55.0, 64.0, 35.0, 20.0, 38.0];
    final past = [55.0, 50.0, 50.0, 40.0, 45.0, 50.0, 30.0, 18.0, 32.0];

    final centerX = size.width / 2;
    final centerY = size.height / 2 - 10;
    final maxRadius = math.min(size.width, size.height) * 0.38;

    final paintCircle = Paint()
      ..color = AppColors.border.withValues(alpha: 0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw circular rings
    for (var r = 1; r <= 4; r++) {
      final radius = maxRadius * (r / 4);
      canvas.drawCircle(Offset(centerX, centerY), radius, paintCircle);
    }

    final angleStep = 2 * math.pi / indicators.length;
    final paintLine = Paint()
      ..color = AppColors.border.withValues(alpha: 0.2)
      ..strokeWidth = 1;

    // Draw axis lines and text labels
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    for (var i = 0; i < indicators.length; i++) {
      final angle = i * angleStep - math.pi / 2;
      final x = centerX + maxRadius * math.cos(angle);
      final y = centerY + maxRadius * math.sin(angle);
      canvas.drawLine(Offset(centerX, centerY), Offset(x, y), paintLine);

      // Label placement
      final labelX = centerX + (maxRadius + 14) * math.cos(angle);
      final labelY = centerY + (maxRadius + 10) * math.sin(angle);

      textPainter
        ..text = TextSpan(
          text: indicators[i],
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 8),
        )
        ..layout()
        ..paint(
          canvas,
          Offset(
            labelX - textPainter.width / 2,
            labelY - textPainter.height / 2,
          ),
        );
    }

    final pathCurrent = Path();
    final pathPast = Path();

    for (var i = 0; i < indicators.length; i++) {
      final angle = i * angleStep - math.pi / 2;
      final rCurrent = maxRadius * (current[i] / 100);
      final rPast = maxRadius * (past[i] / 100);

      final xCurrent = centerX + rCurrent * math.cos(angle);
      final yCurrent = centerY + rCurrent * math.sin(angle);

      final xPast = centerX + rPast * math.cos(angle);
      final yPast = centerY + rPast * math.sin(angle);

      if (i == 0) {
        pathCurrent.moveTo(xCurrent, yCurrent);
        pathPast.moveTo(xPast, yPast);
      } else {
        pathCurrent.lineTo(xCurrent, yCurrent);
        pathPast.lineTo(xPast, yPast);
      }
    }
    pathCurrent.close();
    pathPast.close();

    // Paint risk polygons (past yellow, current red)
    canvas
      ..drawPath(
        pathPast,
        Paint()
          ..color = AppColors.secondaryAccent.withValues(alpha: 0.15)
          ..style = PaintingStyle.fill,
      )
      ..drawPath(
        pathPast,
        Paint()
          ..color = AppColors.secondaryAccent
          ..strokeWidth = 1.2
          ..style = PaintingStyle.stroke,
      )
      ..drawPath(
        pathCurrent,
        Paint()
          ..color = AppColors.error.withValues(alpha: 0.25)
          ..style = PaintingStyle.fill,
      )
      ..drawPath(
        pathCurrent,
        Paint()
          ..color = AppColors.error
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke,
      );

    // Draw little key indicator boxes at bottom
    final keyY = size.height - 10;
    canvas.drawRect(
      Rect.fromLTWH(centerX - 80, keyY, 10, 6),
      Paint()..color = AppColors.error,
    );
    textPainter
      ..text = const TextSpan(
        text: 'Current',
        style: TextStyle(color: Colors.white, fontSize: 8),
      )
      ..layout()
      ..paint(canvas, Offset(centerX - 66, keyY - 2));

    canvas.drawRect(
      Rect.fromLTWH(centerX + 10, keyY, 10, 6),
      Paint()..color = AppColors.secondaryAccent,
    );
    textPainter
      ..text = const TextSpan(
        text: '3 Months Ago',
        style: TextStyle(color: Colors.white, fontSize: 8),
      )
      ..layout()
      ..paint(canvas, Offset(centerX + 24, keyY - 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
