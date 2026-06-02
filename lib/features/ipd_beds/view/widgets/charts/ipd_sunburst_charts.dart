import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class IpdSunburstCharts extends StatefulWidget {
  const IpdSunburstCharts({super.key});

  @override
  State<IpdSunburstCharts> createState() => _IpdSunburstChartsState();
}

class _IpdSunburstChartsState extends State<IpdSunburstCharts> {
  String _hoveredItem = 'Hover over segments for hierarchy details';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        final charts = [
          // Bed Allocation Sunburst
          Expanded(
            flex: isWide ? 1 : 0,
            child: Container(
              height: 340,
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
                    'BED ALLOCATION SUNBURST — DISTRICT → WARD',
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
                    child: Center(
                      child: GestureDetector(
                        onPanUpdate: (_) {
                          setState(() {
                            _hoveredItem = 'Dehradun → Doon Medical College → General Medicine (847 Beds)';
                          });
                        },
                        child: CustomPaint(
                          size: const Size(200, 200),
                          painter: _SunburstPainter(
                            colors: const [
                              Color(0xFF00B4D8),
                              Color(0xFF00C897),
                              Color(0xFFFFD166),
                              Color(0xFFFF4D6D),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isWide) const SizedBox(width: 14) else const SizedBox(height: 14),
          // Trauma Load Sunburst
          Expanded(
            flex: isWide ? 1 : 0,
            child: Container(
              height: 340,
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
                    'TRAUMA LOAD SUNBURST — DISTRICT → CASE TYPE',
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
                    child: Center(
                      child: GestureDetector(
                        onPanUpdate: (_) {
                          setState(() {
                            _hoveredItem = 'Haridwar → District Hospital → Road Accident (142 cases MTD)';
                          });
                        },
                        child: CustomPaint(
                          size: const Size(200, 200),
                          painter: _SunburstPainter(
                            colors: const [
                              Color(0xFFFF7F00),
                              Color(0xFFC77DFF),
                              Color(0xFF4361EE),
                              Color(0xFFF72585),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ];

        return Column(
          children: [
            isWide
                ? Row(children: charts)
                : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: charts),
            const SizedBox(height: 10),
            // Hierarchy Info Bar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
              ),
              child: Text(
                _hoveredItem,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  fontFamily: AppTextStyles.fontFamily,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SunburstPainter extends CustomPainter {
  _SunburstPainter({required this.colors});

  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = min(size.width, size.height) / 2;

    // Draw concentric rings representing hierarchy levels
    // Level 1: Inner District (0 to radius/3)
    final paint1 = Paint()..style = PaintingStyle.fill;
    double startAngle = 0;
    for (int i = 0; i < 4; i++) {
      paint1.color = colors[i].withValues(alpha: 0.85);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: maxRadius * 0.4),
        startAngle,
        pi / 2,
        true,
        paint1,
      );
      startAngle += pi / 2;
    }

    // Border separation ring
    final separatorPaint = Paint()
      ..color = AppColors.surface
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(center, maxRadius * 0.4, separatorPaint);

    // Level 2: Middle Facilities (radius/3 to 2*radius/3)
    final paint2 = Paint()..style = PaintingStyle.stroke..strokeWidth = maxRadius * 0.3;
    startAngle = 0;
    for (int i = 0; i < 8; i++) {
      paint2.color = colors[i % 4].withValues(alpha: 0.6);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: maxRadius * 0.55),
        startAngle,
        pi / 4,
        false,
        paint2,
      );
      startAngle += pi / 4;
    }

    canvas.drawCircle(center, maxRadius * 0.7, separatorPaint);

    // Level 3: Outer Wards (2*radius/3 to radius)
    final paint3 = Paint()..style = PaintingStyle.stroke..strokeWidth = maxRadius * 0.3;
    startAngle = 0;
    for (int i = 0; i < 16; i++) {
      paint3.color = colors[i % 4].withValues(alpha: 0.4);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: maxRadius * 0.85),
        startAngle,
        pi / 8,
        false,
        paint3,
      );
      startAngle += pi / 8;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
