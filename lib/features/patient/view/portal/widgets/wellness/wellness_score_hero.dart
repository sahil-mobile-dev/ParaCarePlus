import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';

class WellnessScoreHero extends StatelessWidget {
  const WellnessScoreHero({super.key});

  @override
  Widget build(BuildContext context) {
    final dimensions = <Map<String, dynamic>>[
      {
        'name': 'Physical',
        'val': 78,
        'color': Colors.teal,
        'icon': Icons.directions_run_rounded,
      },
      {
        'name': 'Mental',
        'val': 72,
        'color': Colors.purpleAccent,
        'icon': Icons.psychology_rounded,
      },
      {
        'name': 'Nutrition',
        'val': 70,
        'color': AppColors.success,
        'icon': Icons.apple_rounded,
      },
      {
        'name': 'Sleep',
        'val': 65,
        'color': AppColors.primaryLight,
        'icon': Icons.dark_mode_rounded,
      },
      {
        'name': 'Social',
        'val': 82,
        'color': AppColors.secondaryAccent,
        'icon': Icons.group_rounded,
      },
      {
        'name': 'Preventive',
        'val': 86,
        'color': Colors.orange,
        'icon': Icons.shield_rounded,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.success.withValues(alpha: 0.08),
            Colors.teal.withValues(alpha: 0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.2)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isLarge = constraints.maxWidth > 700;

          const ringWidget = Center(
            child: SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: Size(120, 120),
                    painter: _ScoreRingPainter(score: 78),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '78',
                        style: TextStyle(
                          color: AppColors.success,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'WELLNESS',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 9,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );

          final dimensionsWidget = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: dimensions.map((dim) {
              final color = dim['color'] as Color;
              final val = dim['val'] as int;

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(dim['icon'] as IconData, color: color, size: 14),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 80,
                      child: Text(
                        dim['name'] as String,
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: val / 100,
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 24,
                      child: Text(
                        '$val',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );

          if (isLarge) {
            return Row(
              children: [
                ringWidget,
                const SizedBox(width: 32),
                Expanded(child: dimensionsWidget),
              ],
            );
          } else {
            return Column(
              children: [
                ringWidget,
                const SizedBox(height: 20),
                dimensionsWidget,
              ],
            );
          }
        },
      ),
    );
  }
}

class _ScoreRingPainter extends CustomPainter {
  const _ScoreRingPainter({required this.score});

  final int score;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 6;

    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    canvas.drawCircle(center, radius, bgPaint);

    final rect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = -pi / 2;
    final sweepAngle = 2 * pi * (score / 100);

    final activePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.teal, AppColors.success],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweepAngle, false, activePaint);
  }

  @override
  bool shouldRepaint(covariant _ScoreRingPainter oldDelegate) {
    return oldDelegate.score != score;
  }
}
