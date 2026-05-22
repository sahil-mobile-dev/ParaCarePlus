import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class FamilyRiskSunburst extends StatelessWidget {
  const FamilyRiskSunburst({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.radar_rounded,
                    color: AppColors.secondaryAccent,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'GENETIC SUNBURST DECODER',
                    style: AppTextStyles.labelSmall,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.secondaryAccent.withValues(alpha: 0.1),
                  border: Border.all(
                    color: AppColors.secondaryAccent,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'HIMS GENOME V1.2',
                  style: TextStyle(
                    color: AppColors.secondaryAccent,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Interactive multi-tiered genetic risk model. Slices depict familial disease transmission rates mapped to generational lineages.',
            style: TextStyle(
              color: AppColors.secondaryText,
              fontSize: 11,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final diagramSize = constraints.maxWidth > 600 ? 260.0 : 200.0;
              final isLarge = constraints.maxWidth > 700;

              final sunburstDiagram = Center(
                child: SizedBox(
                  width: diagramSize,
                  height: diagramSize,
                  child: CustomPaint(painter: SunburstPainter()),
                ),
              );

              final legendPanel = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendHeader('PRIMARY LINEAGES (INNER TIER)'),
                  const SizedBox(height: 8),
                  _buildLegendItem(
                    'Maternal Vector (SD)',
                    'Dominant Risk (68% index)',
                    AppColors.error,
                  ),
                  _buildLegendItem(
                    'Direct Descendants',
                    'Optimal (95% index)',
                    AppColors.success,
                  ),
                  _buildLegendItem(
                    'Paternal / Self (RK)',
                    'Mild Pre-DM (82% index)',
                    AppColors.primaryLight,
                  ),
                  const SizedBox(height: 16),
                  _buildLegendHeader('RISK SECTORS (OUTER TIER)'),
                  const SizedBox(height: 8),
                  _buildLegendItem(
                    'Cardio-Vascular',
                    'High Transmission (Savitri/Ramesh)',
                    AppColors.error,
                  ),
                  _buildLegendItem(
                    'Metabolic Syndrome',
                    'Pre-Diabetic markers',
                    AppColors.secondaryAccent,
                  ),
                  _buildLegendItem(
                    'Allergen Vulnerability',
                    'Seasonal - Low priority',
                    Colors.teal,
                  ),
                ],
              );

              if (isLarge) {
                return Row(
                  children: [
                    Expanded(flex: 4, child: sunburstDiagram),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(flex: 5, child: legendPanel),
                  ],
                );
              } else {
                return Column(
                  children: [
                    sunburstDiagram,
                    const SizedBox(height: 24),
                    legendPanel,
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLegendHeader(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 8.5,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1,
      ),
    );
  }

  Widget _buildLegendItem(String title, String desc, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 9.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SunburstPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final double radius = min(cx, cy);

    final rectInner = Rect.fromCircle(
      center: Offset(cx, cy),
      radius: radius * 0.45,
    );
    final rectMid = Rect.fromCircle(
      center: Offset(cx, cy),
      radius: radius * 0.75,
    );
    final rectOuter = Rect.fromCircle(
      center: Offset(cx, cy),
      radius: radius * 1.0,
    );

    // 1. Central Core Center Dot
    final paintCore = Paint()
      ..color = AppColors.surface
      ..style = PaintingStyle.fill;
    canvas
      ..drawCircle(Offset(cx, cy), radius * 0.2, paintCore)
      ..drawCircle(
        Offset(cx, cy),
        radius * 0.2,
        Paint()
          ..color = AppColors.border
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );

    // 2. INNER TIER RINGS (3 lineages: Maternal, Direct, Paternal)
    // Slices are drawn using drawArc. Angle is in radians (0 to 2*pi).
    _drawSlice(
      canvas: canvas,
      rect: rectInner,
      startAngle: -pi / 2, // Maternal
      sweepAngle: 2 * pi * 0.35,
      color: AppColors.error.withValues(alpha: 0.8),
      strokeWidth: radius * 0.25,
    );

    _drawSlice(
      canvas: canvas,
      rect: rectInner,
      startAngle: -pi / 2 + 2 * pi * 0.35, // Paternal
      sweepAngle: 2 * pi * 0.35,
      color: AppColors.primaryLight.withValues(alpha: 0.8),
      strokeWidth: radius * 0.25,
    );

    _drawSlice(
      canvas: canvas,
      rect: rectInner,
      startAngle: -pi / 2 + 2 * pi * 0.70, // Direct
      sweepAngle: 2 * pi * 0.30,
      color: AppColors.success.withValues(alpha: 0.8),
      strokeWidth: radius * 0.25,
    );

    // 3. MIDDLE TIER RINGS (Finer divisions)
    _drawSlice(
      canvas: canvas,
      rect: rectMid,
      startAngle: -pi / 2, // Maternal Cardiovascular
      sweepAngle: 2 * pi * 0.20,
      color: AppColors.error,
      strokeWidth: radius * 0.20,
    );

    _drawSlice(
      canvas: canvas,
      rect: rectMid,
      startAngle: -pi / 2 + 2 * pi * 0.20, // Maternal Arthritis
      sweepAngle: 2 * pi * 0.15,
      color: AppColors.secondaryAccent,
      strokeWidth: radius * 0.20,
    );

    _drawSlice(
      canvas: canvas,
      rect: rectMid,
      startAngle: -pi / 2 + 2 * pi * 0.35, // Paternal Hypertension
      sweepAngle: 2 * pi * 0.18,
      color: AppColors.secondaryAccent,
      strokeWidth: radius * 0.20,
    );

    _drawSlice(
      canvas: canvas,
      rect: rectMid,
      startAngle: -pi / 2 + 2 * pi * 0.53, // Paternal Lipids
      sweepAngle: 2 * pi * 0.17,
      color: AppColors.primaryLight,
      strokeWidth: radius * 0.20,
    );

    _drawSlice(
      canvas: canvas,
      rect: rectMid,
      startAngle: -pi / 2 + 2 * pi * 0.70, // Direct Offspring 1
      sweepAngle: 2 * pi * 0.15,
      color: AppColors.success,
      strokeWidth: radius * 0.20,
    );

    _drawSlice(
      canvas: canvas,
      rect: rectMid,
      startAngle: -pi / 2 + 2 * pi * 0.85, // Direct Offspring 2
      sweepAngle: 2 * pi * 0.15,
      color: Colors.teal,
      strokeWidth: radius * 0.20,
    );

    // 4. OUTER TIER SLICES
    _drawSlice(
      canvas: canvas,
      rect: rectOuter,
      startAngle: -pi / 2,
      sweepAngle: 2 * pi * 0.10,
      color: AppColors.error.withValues(alpha: 0.65),
      strokeWidth: radius * 0.20,
    );
    _drawSlice(
      canvas: canvas,
      rect: rectOuter,
      startAngle: -pi / 2 + 2 * pi * 0.10,
      sweepAngle: 2 * pi * 0.10,
      color: AppColors.secondaryAccent.withValues(alpha: 0.65),
      strokeWidth: radius * 0.20,
    );
    _drawSlice(
      canvas: canvas,
      rect: rectOuter,
      startAngle: -pi / 2 + 2 * pi * 0.20,
      sweepAngle: 2 * pi * 0.15,
      color: Colors.purple.withValues(alpha: 0.65),
      strokeWidth: radius * 0.20,
    );
    _drawSlice(
      canvas: canvas,
      rect: rectOuter,
      startAngle: -pi / 2 + 2 * pi * 0.35,
      sweepAngle: 2 * pi * 0.35,
      color: AppColors.primaryLight.withValues(alpha: 0.65),
      strokeWidth: radius * 0.20,
    );
    _drawSlice(
      canvas: canvas,
      rect: rectOuter,
      startAngle: -pi / 2 + 2 * pi * 0.70,
      sweepAngle: 2 * pi * 0.30,
      color: AppColors.success.withValues(alpha: 0.65),
      strokeWidth: radius * 0.20,
    );

    // Draw circular boundary separations
    final strokePaint = Paint()
      ..color = AppColors.card
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    canvas
      ..drawCircle(Offset(cx, cy), radius * 0.325, strokePaint)
      ..drawCircle(Offset(cx, cy), radius * 0.575, strokePaint)
      ..drawCircle(Offset(cx, cy), radius * 0.850, strokePaint);
  }

  void _drawSlice({
    required Canvas canvas,
    required Rect rect,
    required double startAngle,
    required double sweepAngle,
    required Color color,
    required double strokeWidth,
  }) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
