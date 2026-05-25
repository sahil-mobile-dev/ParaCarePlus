import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class AiCharts extends StatelessWidget {
  const AiCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLarge = constraints.maxWidth > 900;

        final card1 = _buildCard(
          title: 'AI Interactions — 30 Days',
          icon: Icons.chat_bubble_rounded,
          iconColor: Colors.purpleAccent,
          child: const _AiInteractionsBarChart(),
        );

        final card2 = _buildCard(
          title: 'AI Confidence by Module',
          icon: Icons.radar_rounded,
          iconColor: AppColors.primaryLight,
          child: const CustomPaint(
            size: Size.infinite,
            painter: _AiRadarPainter(),
          ),
        );

        final card3 = _buildCard(
          title: 'Health Goal Adherence',
          icon: Icons.check_circle_rounded,
          iconColor: AppColors.success,
          child: const _AdherenceLineChart(),
        );

        if (isLarge) {
          return Row(
            children: [
              Expanded(child: card1),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: card2),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: card3),
            ],
          );
        } else {
          return Column(
            children: [
              card1,
              const SizedBox(height: AppSpacing.md),
              card2,
              const SizedBox(height: AppSpacing.md),
              card3,
            ],
          );
        }
      },
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Widget child,
  }) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(12),
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
              Icon(icon, color: iconColor, size: 14),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _AiInteractionsBarChart extends StatelessWidget {
  const _AiInteractionsBarChart();

  @override
  Widget build(BuildContext context) {
    // 30 days data representation
    return BarChart(
      BarChartData(
        maxY: 10,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 20,
              getTitlesWidget: (value, meta) {
                if (value % 2 == 0) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 8,
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final day = value.toInt() + 1;
                if (day % 10 == 0 || day == 1) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'd$day',
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 8,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
        ),
        barGroups: List.generate(30, (idx) {
          // generate stacked bar heights representing Symptom (red), Medication (yellow), CBT (purple)
          final sym = 2.0 + (idx % 3);
          final med = 1.0 + (idx % 2);
          final cbt = 1.0 + (idx % 4);

          return BarChartGroupData(
            x: idx,
            barRods: [
              BarChartRodData(
                toY: sym + med + cbt,
                rodStackItems: [
                  BarChartRodStackItem(0, sym, AppColors.error),
                  BarChartRodStackItem(sym, sym + med, AppColors.secondaryAccent),
                  BarChartRodStackItem(sym + med, sym + med + cbt, Colors.purpleAccent),
                ],
                width: 6,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _AdherenceLineChart extends StatelessWidget {
  const _AdherenceLineChart();

  @override
  Widget build(BuildContext context) {
    // 30 days adherence percentages
    final adherence = [
      80,
      82,
      85,
      78,
      90,
      92,
      94,
      85,
      88,
      79,
      82,
      75,
      88,
      91,
      93,
      89,
      84,
      82,
      80,
      72,
      85,
      89,
      92,
      94,
      95,
      88,
      85,
      80,
      78,
      84,
    ];

    return LineChart(
      LineChartData(
        minY: 60,
        maxY: 100,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              getTitlesWidget: (value, meta) {
                if (value % 10 == 0) {
                  return Text(
                    '${value.toInt()}%',
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 8,
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final day = value.toInt() + 1;
                if (day % 10 == 0 || day == 1) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'd$day',
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 8,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              adherence.length,
              (idx) => FlSpot(idx.toDouble(), adherence[idx].toDouble()),
            ),
            isCurved: true,
            color: AppColors.success,
            barWidth: 1.5,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.success.withValues(alpha: 0.08),
            ),
          ),
        ],
      ),
    );
  }
}

class _AiRadarPainter extends CustomPainter {
  const _AiRadarPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = min(cx, cy) - 15;

    final axisLabels = ['Symptom', 'Drug Safety', 'Lab Triage', 'Radiology', 'CBT', 'Wellness'];
    final dataValues = [0.95, 0.92, 0.89, 0.85, 0.88, 0.91];

    final paintLine = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Draw concentric polygons (Radar grid: 4 levels)
    for (var step = 1; step <= 4; step++) {
      final r = radius * (step / 4);
      final path = Path();
      for (var i = 0; i < axisLabels.length; i++) {
        final angle = -pi / 2 + (2 * pi * i / axisLabels.length);
        final x = cx + r * cos(angle);
        final y = cy + r * sin(angle);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas.drawPath(path, paintLine);
    }

    // Draw axes lines & labels
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (var i = 0; i < axisLabels.length; i++) {
      final angle = -pi / 2 + (2 * pi * i / axisLabels.length);
      final ax = cx + radius * cos(angle);
      final ay = cy + radius * sin(angle);
      canvas.drawLine(Offset(cx, cy), Offset(ax, ay), paintLine);

      // Label positioning
      textPainter
        ..text = TextSpan(
          text: axisLabels[i],
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 7.5,
            fontWeight: FontWeight.bold,
          ),
        )
        ..layout();

      // Align label offset
      final lx = cx + (radius + 12) * cos(angle) - textPainter.width / 2;
      final ly = cy + (radius + 10) * sin(angle) - textPainter.height / 2;
      textPainter.paint(canvas, Offset(lx, ly));
    }

    // Draw data polygon
    final pathData = Path();
    final fillPaint = Paint()
      ..color = AppColors.primaryLight.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = AppColors.primaryLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (var i = 0; i < axisLabels.length; i++) {
      final val = dataValues[i];
      final angle = -pi / 2 + (2 * pi * i / axisLabels.length);
      final dx = cx + (radius * val) * cos(angle);
      final dy = cy + (radius * val) * sin(angle);

      if (i == 0) {
        pathData.moveTo(dx, dy);
      } else {
        pathData.lineTo(dx, dy);
      }
    }
    pathData.close();
    canvas
      ..drawPath(pathData, fillPaint)
      ..drawPath(pathData, borderPaint);

    // Draw data dots
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final outerDotPaint = Paint()
      ..color = AppColors.primaryLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (var i = 0; i < axisLabels.length; i++) {
      final val = dataValues[i];
      final angle = -pi / 2 + (2 * pi * i / axisLabels.length);
      final dx = cx + (radius * val) * cos(angle);
      final dy = cy + (radius * val) * sin(angle);

      canvas
        ..drawCircle(Offset(dx, dy), 3, dotPaint)
        ..drawCircle(Offset(dx, dy), 3, outerDotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
