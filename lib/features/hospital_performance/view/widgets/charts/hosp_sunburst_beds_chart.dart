import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class HospSunburstBedsChart extends StatefulWidget {
  const HospSunburstBedsChart({super.key});

  @override
  State<HospSunburstBedsChart> createState() => _HospSunburstBedsChartState();
}

class _HospSunburstBedsChartState extends State<HospSunburstBedsChart> {
  final String _selectedSegment = 'General Wards (12,480)';
  final String _selectedBeds = '9,240 occupied';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hospital → Bed Type → Occupancy Status',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Bed category utilization breakdown',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: CustomPaint(painter: _SunburstPainter()),
                ),
                // Center information overlay
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedSegment,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 9.5,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _selectedBeds,
                      style: const TextStyle(
                        color: AppColors.success,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          const Center(
            child: Text(
              'Drill down to general, ICU, HDU or maternity status',
              style: TextStyle(
                color: AppColors.secondaryText,
                fontSize: 9.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SunburstPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    final paintCenterCircle = Paint()
      ..color = const Color(0xFF0C1F34)
      ..style = PaintingStyle.fill;

    // Blue/Yellow/Red colors for beds occupancy focus
    final levels = [
      {
        'colors': [
          AppColors.primaryLight,
          AppColors.secondaryAccent,
          AppColors.error,
          Colors.blueAccent,
        ],
        'radiusFactor': 0.5,
      },
      {
        'colors': [
          AppColors.primaryLight.withValues(alpha: 0.7),
          AppColors.secondaryAccent.withValues(alpha: 0.7),
          AppColors.error.withValues(alpha: 0.7),
        ],
        'radiusFactor': 0.75,
      },
      {
        'colors': [
          AppColors.primaryLight.withValues(alpha: 0.4),
          AppColors.secondaryAccent.withValues(alpha: 0.4),
          AppColors.error.withValues(alpha: 0.4),
        ],
        'radiusFactor': 0.95,
      },
    ];

    for (var l = levels.length - 1; l >= 0; l--) {
      final level = levels[l];
      final rFactor = level['radiusFactor'] as double;
      final colors = level['colors'] as List<Color>;

      final ringRadius = radius * rFactor;
      final segmentCount = 4 + (l * 4);
      final angleStep = 2 * pi / segmentCount;

      for (var s = 0; s < segmentCount; s++) {
        final startAngle = s * angleStep;
        final paint = Paint()
          ..color = colors[s % colors.length]
          ..style = PaintingStyle.fill;

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: ringRadius),
          startAngle,
          angleStep - 0.04,
          true,
          paint,
        );
      }
    }

    // Paint the inner cutout circle
    canvas
      ..drawCircle(center, radius * 0.35, paintCenterCircle)
      ..drawCircle(
        center,
        radius * 0.35,
        Paint()
          ..color = AppColors.border
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
