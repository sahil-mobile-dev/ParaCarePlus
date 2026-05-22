import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AnalyticsTrends extends StatelessWidget {
  const AnalyticsTrends({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        var crossAxisCount = 1;
        if (width > 900) {
          crossAxisCount = 2;
        }

        final trends = _getTrendsData();

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.6,
          ),
          itemCount: trends.length,
          itemBuilder: (context, index) {
            final t = trends[index];
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
                      Icon(t.icon, color: AppColors.primaryLight, size: 16),
                      const SizedBox(width: 8),
                      Text(t.title, style: AppTextStyles.labelLarge),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Expanded(
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: _TrendChartPainter(trend: t),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: t.legends.entries.map((e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: e.value,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              e.key,
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<_TrendItem> _getTrendsData() {
    return [
      _TrendItem(
        title: 'Blood Pressure Trend',
        icon: Icons.favorite_rounded,
        type: 'bp',
        legends: {
          'Systolic': AppColors.error,
          'Diastolic': AppColors.secondaryAccent,
        },
        series1: [122, 124, 128, 126, 129, 131, 128],
        series2: [80, 81, 83, 82, 84, 85, 82],
      ),
      _TrendItem(
        title: 'Blood Sugar Trend',
        icon: Icons.opacity_rounded,
        type: 'sugar',
        legends: {'Fasting Sugar': AppColors.secondaryAccent},
        series1: [136, 138, 142, 139, 141, 144, 142],
      ),
      _TrendItem(
        title: 'Cholesterol Panel Trend',
        icon: Icons.biotech_rounded,
        type: 'cholesterol',
        legends: {
          'LDL': AppColors.error,
          'HDL': AppColors.success,
          'Triglycerides': AppColors.secondaryAccent,
        },
        series1: [132, 134, 136, 135, 138],
        series2: [44, 43, 42, 42, 42],
        series3: [160, 162, 158, 164, 160],
      ),
      _TrendItem(
        title: 'Heart Rate & SpO₂',
        icon: Icons.monitor_heart_rounded,
        type: 'hr_spo2',
        legends: {
          'Heart Rate (bpm)': const Color(0xFFF72585),
          'SpO₂ (%)': AppColors.primaryLight,
        },
        series1: [74, 76, 78, 75, 77, 79, 76],
        series2: [98, 97, 98, 98, 99, 98, 98],
      ),
      _TrendItem(
        title: 'Weight & BMI',
        icon: Icons.scale_rounded,
        type: 'weight',
        legends: {
          'Weight (kg)': const Color(0xFF4361EE),
          'BMI': AppColors.secondaryAccent,
        },
        series1: [71.8, 72.1, 72.4, 72.2, 72.3, 72.5, 72.4],
        series2: [26.0, 26.1, 26.2, 26.1, 26.2, 26.3, 26.2],
      ),
      _TrendItem(
        title: 'Sleep Duration',
        icon: Icons.bedtime_rounded,
        type: 'sleep',
        legends: {'Sleep (hrs)': const Color(0xFFC77DFF)},
        series1: [6.4, 5.8, 7.2, 6.0, 5.5, 6.8, 6.2],
      ),
      _TrendItem(
        title: 'Steps & Calories',
        icon: Icons.directions_walk_rounded,
        type: 'steps',
        legends: {
          'Steps': const Color(0xFF0D9488),
          'Calories': AppColors.secondaryAccent,
        },
        series1: [4500, 4800, 5200, 4700, 4300, 5100, 4820],
        series2: [1800, 1850, 1900, 1820, 1780, 1880, 1840],
      ),
      _TrendItem(
        title: 'Mental Wellness & Stress',
        icon: Icons.psychology_rounded,
        type: 'wellness',
        legends: {
          'Wellness Score': const Color(0xFFC77DFF),
          'Stress Index': AppColors.error,
        },
        series1: [75, 73, 70, 72, 71, 69, 72],
        series2: [5.8, 6.0, 6.5, 6.2, 6.3, 6.6, 6.4],
      ),
    ];
  }
}

class _TrendItem {
  _TrendItem({
    required this.title,
    required this.icon,
    required this.type,
    required this.legends,
    required this.series1,
    this.series2,
    this.series3,
  });

  final String title;
  final IconData icon;
  final String type;
  final Map<String, Color> legends;
  final List<double> series1;
  final List<double>? series2;
  final List<double>? series3;
}

class _TrendChartPainter extends CustomPainter {
  _TrendChartPainter({required this.trend});
  final _TrendItem trend;

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.5)
      ..strokeWidth = 0.5;

    // Draw background horizontal grid lines
    const gridLinesCount = 3;
    for (var i = 0; i <= gridLinesCount; i++) {
      final y = size.height * (i / gridLinesCount);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final pointsCount = trend.series1.length;
    final segmentWidth = size.width / (pointsCount - 1);

    if (trend.type == 'bp' && trend.series2 != null) {
      // Draw Systolic & Diastolic BP
      _drawAreaLine(
        canvas,
        size,
        trend.series1,
        AppColors.error,
        100,
        150,
        segmentWidth,
      );
      _drawAreaLine(
        canvas,
        size,
        trend.series2!,
        AppColors.secondaryAccent,
        50,
        100,
        segmentWidth,
      );
    } else if (trend.type == 'sugar') {
      _drawAreaLine(
        canvas,
        size,
        trend.series1,
        AppColors.secondaryAccent,
        80,
        180,
        segmentWidth,
      );
    } else if (trend.type == 'cholesterol' &&
        trend.series2 != null &&
        trend.series3 != null) {
      // Stacked bar chart drawing
      final barWidth = size.width / (pointsCount * 2);
      for (var i = 0; i < pointsCount; i++) {
        final x = i * (size.width / pointsCount) + barWidth / 2;

        final ldlHeight = (trend.series1[i] / 250) * size.height;
        final hdlHeight = (trend.series2![i] / 250) * size.height;

        // Draw LDL and HDL bars
        canvas
          ..drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(x, size.height - ldlHeight, barWidth, ldlHeight),
              const Radius.circular(2),
            ),
            Paint()..color = AppColors.error,
          )
          ..drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(
                x + barWidth,
                size.height - hdlHeight,
                barWidth,
                hdlHeight,
              ),
              const Radius.circular(2),
            ),
            Paint()..color = AppColors.success,
          );
      }
    } else if (trend.type == 'hr_spo2' && trend.series2 != null) {
      // HR line & SpO2 area
      _drawAreaLine(
        canvas,
        size,
        trend.series2!,
        AppColors.primaryLight.withValues(alpha: 0.8),
        90,
        100,
        segmentWidth,
      );
      _drawSimpleLine(
        canvas,
        size,
        trend.series1,
        const Color(0xFFF72585),
        60,
        100,
        segmentWidth,
      );
    } else if (trend.type == 'weight' && trend.series2 != null) {
      _drawAreaLine(
        canvas,
        size,
        trend.series1,
        const Color(0xFF4361EE),
        70,
        75,
        segmentWidth,
      );
      _drawSimpleLine(
        canvas,
        size,
        trend.series2!,
        AppColors.secondaryAccent,
        24,
        28,
        segmentWidth,
      );
    } else if (trend.type == 'sleep') {
      // Categorized bar colors
      final barWidth = size.width / (pointsCount * 1.5);
      for (var i = 0; i < pointsCount; i++) {
        final x = i * (size.width / pointsCount) + barWidth / 4;
        final val = trend.series1[i];
        final h = (val / 10) * size.height;

        var barColor = AppColors.error;
        if (val >= 7.0) {
          barColor = AppColors.success;
        } else if (val >= 6.0) {
          barColor = AppColors.secondaryAccent;
        }

        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x, size.height - h, barWidth, h),
            const Radius.circular(4),
          ),
          Paint()..color = barColor,
        );
      }
    } else if (trend.type == 'steps' && trend.series2 != null) {
      // Steps bar & Calories line
      final barWidth = size.width / (pointsCount * 1.5);
      for (var i = 0; i < pointsCount; i++) {
        final x = i * (size.width / pointsCount) + barWidth / 4;
        final h = (trend.series1[i] / 8000) * size.height;
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x, size.height - h, barWidth, h),
            const Radius.circular(4),
          ),
          Paint()..color = const Color(0xFF0D9488),
        );
      }
      _drawSimpleLine(
        canvas,
        size,
        trend.series2!,
        AppColors.secondaryAccent,
        1200,
        2400,
        segmentWidth,
      );
    } else if (trend.type == 'wellness' && trend.series2 != null) {
      _drawAreaLine(
        canvas,
        size,
        trend.series1,
        const Color(0xFFC77DFF),
        50,
        100,
        segmentWidth,
      );
      _drawSimpleLine(
        canvas,
        size,
        trend.series2!,
        AppColors.error,
        3,
        9,
        segmentWidth,
      );
    }
  }

  void _drawSimpleLine(
    Canvas canvas,
    Size size,
    List<double> series,
    Color color,
    double minVal,
    double maxVal,
    double segmentWidth,
  ) {
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    for (var i = 0; i < series.length; i++) {
      final y =
          size.height -
          ((series[i] - minVal) / (maxVal - minVal)) * size.height;
      final x = i * segmentWidth;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, linePaint);
  }

  void _drawAreaLine(
    Canvas canvas,
    Size size,
    List<double> series,
    Color color,
    double minVal,
    double maxVal,
    double segmentWidth,
  ) {
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final areaPaint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final areaPath = Path();

    for (var i = 0; i < series.length; i++) {
      final y =
          size.height -
          ((series[i] - minVal) / (maxVal - minVal)) * size.height;
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

      if (i == series.length - 1) {
        areaPath
          ..lineTo(x, size.height)
          ..close();
      }
    }

    canvas
      ..drawPath(areaPath, areaPaint)
      ..drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
