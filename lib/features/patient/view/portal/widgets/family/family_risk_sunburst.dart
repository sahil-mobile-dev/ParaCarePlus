import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class FamilyRiskSunburst extends StatelessWidget {
  const FamilyRiskSunburst({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Row(
          children: [
            Icon(
              Icons.circle_notifications_rounded,
              color: AppColors.primaryLight,
              size: 18,
            ),
            SizedBox(width: 8),
            Text('FAMILY HEALTH COMPOSITION', style: AppTextStyles.labelSmall),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        LayoutBuilder(
          builder: (context, constraints) {
            final isLarge = constraints.maxWidth > 900;

            final chart1 = _buildChartCard(
              title: 'Family Wellness Score Distribution',
              accentColor: AppColors.success,
              child: const _WellnessSunburstChart(),
            );

            final chart2 = _buildChartCard(
              title: 'Family Hereditary Risk Map',
              accentColor: Colors.purpleAccent,
              child: const _HereditarySunburstChart(),
            );

            if (isLarge) {
              return Row(
                children: [
                  Expanded(child: chart1),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: chart2),
                ],
              );
            } else {
              return Column(
                children: [
                  chart1,
                  const SizedBox(height: AppSpacing.md),
                  chart2,
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildChartCard({
    required String title,
    required Color accentColor,
    required Widget child,
  }) {
    return Container(
      height: 360,
      padding: const EdgeInsets.all(16),
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
              Icon(Icons.pie_chart_rounded, color: accentColor, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _WellnessSunburstChart extends StatelessWidget {
  const _WellnessSunburstChart();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          child: CustomPaint(
            size: Size.infinite,
            painter: _WellnessSunburstPainter(),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem('RK', AppColors.secondaryAccent),
            const SizedBox(width: 10),
            _buildLegendItem('GK', AppColors.success),
            const SizedBox(width: 10),
            _buildLegendItem('AK', AppColors.primaryLight),
            const SizedBox(width: 10),
            _buildLegendItem('PK', Colors.orange),
            const SizedBox(width: 10),
            _buildLegendItem('SD', AppColors.error),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
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
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 9.5),
        ),
      ],
    );
  }
}

class _HereditarySunburstChart extends StatelessWidget {
  const _HereditarySunburstChart();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          child: CustomPaint(
            size: Size.infinite,
            painter: _HereditarySunburstPainter(),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem('HTN', AppColors.error),
            const SizedBox(width: 12),
            _buildLegendItem('T2D', Colors.orange),
            const SizedBox(width: 12),
            _buildLegendItem('Heart', Colors.pinkAccent),
            const SizedBox(width: 12),
            _buildLegendItem('Osteo', Colors.purpleAccent),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
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
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 9.5),
        ),
      ],
    );
  }
}

class _WellnessSunburstPainter extends CustomPainter {
  const _WellnessSunburstPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = min(cx, cy);

    final rectInner = Rect.fromCircle(
      center: Offset(cx, cy),
      radius: radius * 0.4,
    );
    final rectOuter = Rect.fromCircle(
      center: Offset(cx, cy),
      radius: radius * 0.7,
    );

    // Inner Core Center Label
    final paintCore = Paint()
      ..color = AppColors.surface
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx, cy), radius * 0.18, paintCore);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Inner Ring: Ramesh, Geeta, Aryan, Priya, Savitri
    final members = [
      {'name': 'Ramesh', 'val': 78.0, 'color': AppColors.secondaryAccent},
      {'name': 'Geeta', 'val': 84.0, 'color': AppColors.success},
      {'name': 'Aryan', 'val': 92.0, 'color': AppColors.primaryLight},
      {'name': 'Priya', 'val': 88.0, 'color': Colors.orange},
      {'name': 'Savitri', 'val': 68.0, 'color': AppColors.error},
    ];

    final totalVal = members.fold<double>(
      0,
      (sum, m) => sum + (m['val'] as double? ?? 0.0),
    );
    var startAngle = -pi / 2;

    for (final m in members) {
      final val = m['val'] as double? ?? 0.0;
      final sweepAngle = 2 * pi * (val / totalVal);
      final color = m['color'] as Color? ?? Colors.grey;

      _drawSlice(
        canvas: canvas,
        rect: rectInner,
        startAngle: startAngle,
        sweepAngle: sweepAngle,
        color: color.withValues(alpha: 0.7),
        strokeWidth: radius * 0.22,
      );

      // Draw outer layer slices for this member (representing Physical & Mental & Social details)
      _drawSlice(
        canvas: canvas,
        rect: rectOuter,
        startAngle: startAngle,
        sweepAngle: sweepAngle * 0.5,
        color: color.withValues(alpha: 0.9),
        strokeWidth: radius * 0.25,
      );

      _drawSlice(
        canvas: canvas,
        rect: rectOuter,
        startAngle: startAngle + sweepAngle * 0.5,
        sweepAngle: sweepAngle * 0.5,
        color: color.withValues(alpha: 0.5),
        strokeWidth: radius * 0.25,
      );

      startAngle += sweepAngle;
    }

    // Outer circular divider
    final strokePaint = Paint()
      ..color = AppColors.card
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas
      ..drawCircle(Offset(cx, cy), radius * 0.29, strokePaint)
      ..drawCircle(Offset(cx, cy), radius * 0.51, strokePaint)
      ..drawCircle(Offset(cx, cy), radius * 0.825, strokePaint);

    // Draw central text label
    textPainter
      ..text = const TextSpan(
        text: 'WELLNESS',
        style: TextStyle(
          color: AppColors.secondaryText,
          fontSize: 7.5,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      )
      ..layout()
      ..paint(
        canvas,
        Offset(cx - textPainter.width / 2, cy - textPainter.height / 2),
      );
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

class _HereditarySunburstPainter extends CustomPainter {
  const _HereditarySunburstPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = min(cx, cy);

    final rectInner = Rect.fromCircle(
      center: Offset(cx, cy),
      radius: radius * 0.4,
    );
    final rectOuter = Rect.fromCircle(
      center: Offset(cx, cy),
      radius: radius * 0.7,
    );

    // Center Core Center Label
    final paintCore = Paint()
      ..color = AppColors.surface
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx, cy), radius * 0.18, paintCore);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Inner Ring: HTN, Diabetes, Heart Disease, Osteoarthritis
    final categories = [
      {'name': 'Hypertension', 'weight': 3.0, 'color': AppColors.error},
      {'name': 'Diabetes', 'weight': 2.0, 'color': Colors.orange},
      {'name': 'Heart', 'weight': 1.0, 'color': Colors.pinkAccent},
      {'name': 'Osteo', 'weight': 2.0, 'color': Colors.purpleAccent},
    ];

    final totalWeight = categories.fold<double>(
      0,
      (sum, c) => sum + (c['weight'] as double? ?? 0.0),
    );
    var startAngle = -pi / 2;

    for (final c in categories) {
      final weight = c['weight'] as double? ?? 0.0;
      final sweepAngle = 2 * pi * (weight / totalWeight);
      final color = c['color'] as Color? ?? Colors.grey;

      _drawSlice(
        canvas: canvas,
        rect: rectInner,
        startAngle: startAngle,
        sweepAngle: sweepAngle,
        color: color.withValues(alpha: 0.65),
        strokeWidth: radius * 0.22,
      );

      // Outer rings details
      _drawSlice(
        canvas: canvas,
        rect: rectOuter,
        startAngle: startAngle,
        sweepAngle: sweepAngle * 0.6,
        color: color.withValues(alpha: 0.85),
        strokeWidth: radius * 0.25,
      );

      _drawSlice(
        canvas: canvas,
        rect: rectOuter,
        startAngle: startAngle + sweepAngle * 0.6,
        sweepAngle: sweepAngle * 0.4,
        color: color.withValues(alpha: 0.4),
        strokeWidth: radius * 0.25,
      );

      startAngle += sweepAngle;
    }

    final strokePaint = Paint()
      ..color = AppColors.card
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas
      ..drawCircle(Offset(cx, cy), radius * 0.29, strokePaint)
      ..drawCircle(Offset(cx, cy), radius * 0.51, strokePaint)
      ..drawCircle(Offset(cx, cy), radius * 0.825, strokePaint);

    textPainter
      ..text = const TextSpan(
        text: 'GENETIC',
        style: TextStyle(
          color: AppColors.secondaryText,
          fontSize: 7.5,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      )
      ..layout()
      ..paint(
        canvas,
        Offset(cx - textPainter.width / 2, cy - textPainter.height / 2),
      );
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
