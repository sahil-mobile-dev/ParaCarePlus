import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

// --- MAIN WRAPPER PANEL ---
class StateCommandChartPanel extends StatelessWidget {
  const StateCommandChartPanel({
    required this.title,
    required this.badgeText,
    required this.child,
    super.key,
  });

  final String title;
  final String badgeText;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Head
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0x11FFFFFF))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.labelLarge.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    badgeText.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 8.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryLight,
                      letterSpacing: 0.3,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Body
          Padding(padding: const EdgeInsets.all(16), child: child),
        ],
      ),
    );
  }
}

// --- STAFF DISTRIBUTION LIST ---
class StaffDistributionWidget extends StatelessWidget {
  const StaffDistributionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final staffData = [
      {
        'role': 'Doctors',
        'total': 3240,
        'avail': 2847,
        'color': const Color(0xFF42A5F5),
      },
      {
        'role': 'Nurses',
        'total': 8920,
        'avail': 7124,
        'color': const Color(0xFF4DB6AC),
      },
      {
        'role': 'Paramedics',
        'total': 4210,
        'avail': 3688,
        'color': const Color(0xFFFFB74D),
      },
      {
        'role': 'Lab Techs',
        'total': 1840,
        'avail': 1620,
        'color': const Color(0xFFCE93D8),
      },
      {
        'role': 'Pharmacists',
        'total': 1240,
        'avail': 1089,
        'color': const Color(0xFF80CBC4),
      },
      {
        'role': 'Ambulance Drivers',
        'total': 640,
        'avail': 524,
        'color': const Color(0xFFEF9A9A),
      },
      {
        'role': 'Admin Staff',
        'total': 2840,
        'avail': 2234,
        'color': const Color(0xFF90CAF9),
      },
    ];

    return Column(
      children: staffData.map((s) {
        final total = s['total']! as int;
        final avail = s['avail']! as int;
        final ratio = (avail / total).clamp(0.0, 1.0);
        final color = s['color']! as Color;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  s['role']! as String,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppTextStyles.fontFamily,
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    // Total background bar
                    Container(
                      height: 16,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    // Available bar
                    FractionallySizedBox(
                      widthFactor: ratio,
                      child: Container(
                        height: 16,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 85,
                child: Text(
                  '$avail / $total',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppTextStyles.fontFamily,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// --- DISEASE BURDEN LEGEND LIST ---
class DiseaseBurdenWidget extends StatelessWidget {
  const DiseaseBurdenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final diseases = [
      {'label': 'Respiratory', 'pct': 18, 'color': const Color(0xFF42A5F5)},
      {'label': 'Cardiovascular', 'pct': 22, 'color': const Color(0xFFEF5350)},
      {'label': 'Dengue/Malaria', 'pct': 12, 'color': const Color(0xFFFF7043)},
      {'label': 'Tuberculosis', 'pct': 8, 'color': const Color(0xFFAB47BC)},
      {'label': 'Diabetes', 'pct': 14, 'color': const Color(0xFF26C6DA)},
      {'label': 'Hypertension', 'pct': 10, 'color': const Color(0xFF66BB6A)},
      {'label': 'Cancer', 'pct': 6, 'color': const Color(0xFFEC407A)},
      {'label': 'Mental Health', 'pct': 5, 'color': const Color(0xFFFFA726)},
      {'label': 'Others', 'pct': 5, 'color': const Color(0xFF78909C)},
    ];

    return Row(
      children: [
        // Simulated Doughnut graphic
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border, width: 12),
          ),
          alignment: Alignment.center,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '100%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontFamily: AppTextStyles.fontFamily,
                ),
              ),
              Text(
                'BURDEN',
                style: TextStyle(
                  fontSize: 7.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryText,
                  fontFamily: AppTextStyles.fontFamily,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        // Legend list
        Expanded(
          child: Column(
            children: diseases.map((d) {
              final color = d['color']! as Color;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.5),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        d['label']! as String,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white70,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${d['pct']}%',
                      style: TextStyle(
                        fontSize: 11,
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

// --- CUSTOM LINE CHART ---
class CustomLineChart extends StatelessWidget {
  const CustomLineChart({
    required this.values,
    required this.lineColor,
    required this.labels,
    this.targetValue,
    this.fillColor,
    super.key,
  });

  final List<double> values;
  final List<String> labels;
  final Color lineColor;
  final Color? fillColor;
  final double? targetValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 130,
          width: double.infinity,
          child: CustomPaint(
            painter: _LineChartPainter(
              values: values,
              lineColor: lineColor,
              fillColor: fillColor,
              targetValue: targetValue,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: labels
              .map(
                (lbl) => Text(
                  lbl,
                  style: const TextStyle(
                    fontSize: 8.5,
                    color: AppColors.secondaryText,
                    fontFamily: AppTextStyles.fontFamily,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _LineChartPainter extends CustomPainter {
  _LineChartPainter({
    required this.values,
    required this.lineColor,
    this.fillColor,
    this.targetValue,
  });

  final List<double> values;
  final Color lineColor;
  final Color? fillColor;
  final double? targetValue;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final maxVal = values.reduce(max);
    final minVal = values.reduce(min);
    final range = (maxVal - minVal) == 0 ? 1.0 : (maxVal - minVal) * 1.15;
    final baseline = minVal - (range * 0.05);

    final xSteps = size.width / (values.length - 1);
    final path = Path();
    final fillPath = Path();

    // Start coordinates
    double getX(int idx) => idx * xSteps;
    double getY(double val) {
      final ratio = (val - baseline) / range;
      return size.height - (ratio * size.height * 0.9).clamp(0.0, size.height);
    }

    path.moveTo(getX(0), getY(values[0]));
    fillPath.moveTo(getX(0), size.height);

    for (var i = 1; i < values.length; i++) {
      final x = getX(i);
      final y = getY(values[i]);
      path.lineTo(x, y);
      fillPath.lineTo(x, y);
    }

    fillPath.lineTo(getX(values.length - 1), size.height);

    // Draw grid background line
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (var i = 1; i <= 3; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw Target baseline if specified
    if (targetValue != null) {
      final targetY = getY(targetValue!);
      final targetPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.15)
        ..strokeWidth = 1.2
        ..style = PaintingStyle.stroke;

      // Draw dashed line
      double dx = 0;
      while (dx < size.width) {
        canvas.drawLine(
          Offset(dx, targetY),
          Offset(dx + 5, targetY),
          targetPaint,
        );
        dx += 10;
      }
    }

    // Draw fill gradient
    if (fillColor != null) {
      final gradPaint = Paint()
        ..shader = LinearGradient(
          colors: [fillColor!, fillColor!.withValues(alpha: 0.2)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
        ..style = PaintingStyle.fill;
      canvas.drawPath(fillPath, gradPaint);
    }

    // Draw line
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) => true;
}

// --- CUSTOM BAR CHART ---
class CustomBarChart extends StatelessWidget {
  const CustomBarChart({
    required this.values,
    required this.labels,
    this.barColor = AppColors.primaryLight,
    this.suffix = '',
    super.key,
  });

  final List<double> values;
  final List<String> labels;
  final Color barColor;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) return const SizedBox();
    final maxVal = values.reduce(max);

    return Column(
      children: [
        SizedBox(
          height: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(values.length, (index) {
              final val = values[index];
              final pct = maxVal == 0 ? 0.0 : val / maxVal;

              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${val.round()}$suffix',
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: barColor.withValues(alpha: 0.9),
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                    const SizedBox(height: 2),
                    FractionallySizedBox(
                      widthFactor: 0.65,
                      child: Container(
                        height: (pct * 95).clamp(4.0, 100.0),
                        decoration: BoxDecoration(
                          color: barColor.withValues(alpha: 0.7),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(3),
                            topRight: Radius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: labels
              .map(
                (lbl) => Expanded(
                  child: Text(
                    lbl,
                    style: const TextStyle(
                      fontSize: 8.5,
                      color: AppColors.secondaryText,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
