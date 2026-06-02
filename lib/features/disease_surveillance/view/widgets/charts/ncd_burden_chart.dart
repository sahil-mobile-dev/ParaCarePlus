import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class NcdBurdenChart extends StatelessWidget {
  const NcdBurdenChart({super.key});

  @override
  Widget build(BuildContext context) {
    final months = ['Jun', 'Aug', 'Oct', 'Dec', 'Feb', 'Apr'];
    final hypertension = [18000.0, 21000.0, 24000.0, 21000.0, 19000.0, 26000.0];
    final diabetes = [12000.0, 14000.0, 16000.0, 13000.0, 11000.0, 18000.0];

    final categories = [
      {'label': 'Hypertension', 'pct': 38, 'color': AppColors.error},
      {'label': 'Diabetes', 'pct': 28, 'color': AppColors.secondaryAccent},
      {'label': 'COPD / Asthma', 'pct': 14, 'color': const Color(0xFFFFD166)},
      {'label': 'Oral Cancer', 'pct': 8, 'color': const Color(0xFF9B5DE5)},
      {'label': 'CKD', 'pct': 6, 'color': AppColors.primaryLight},
      {'label': 'Others', 'pct': 6, 'color': AppColors.success},
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final isMobile = w < 760;

        final screeningPanel = _buildScreeningPanel(
          months,
          hypertension,
          diabetes,
        );
        final breakdownPanel = _buildBreakdownPanel(categories);

        return isMobile
            ? Column(
                children: [
                  screeningPanel,
                  const SizedBox(height: 16),
                  breakdownPanel,
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: screeningPanel),
                  const SizedBox(width: 16),
                  Expanded(flex: 2, child: breakdownPanel),
                ],
              );
      },
    );
  }

  Widget _buildScreeningPanel(
    List<String> months,
    List<double> hypertension,
    List<double> diabetes,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'NCD Screening Trend',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'NPCDCS Programme — Population 30+ Screened Monthly',
            style: TextStyle(
              fontSize: 9.5,
              color: AppColors.secondaryText,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              _LegendDot('Hypertension', AppColors.error),
              SizedBox(width: 12),
              _LegendDot('Diabetes', AppColors.secondaryAccent),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            width: double.infinity,
            child: CustomPaint(
              painter: _NcdScreeningPainter(
                hypertension: hypertension,
                diabetes: diabetes,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: months
                .map(
                  (m) => Text(
                    m,
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
      ),
    );
  }

  Widget _buildBreakdownPanel(List<Map<String, dynamic>> categories) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'NCD Burden Distribution',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Proportion of Confirmed Cases YTD',
            style: TextStyle(
              fontSize: 9.5,
              color: AppColors.secondaryText,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: categories.map((cat) {
              final col = cat['color'] as Color;
              final pct = cat['pct'] as int;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.5),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: col,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        cat['label']! as String,
                        style: const TextStyle(
                          fontSize: 9.5,
                          color: Colors.white70,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                      ),
                    ),
                    Text(
                      '$pct%',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: col,
                        fontFamily: AppTextStyles.fontFamily,
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
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot(this.label, this.color);
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
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
          style: const TextStyle(
            fontSize: 9.5,
            color: AppColors.secondaryText,
            fontFamily: AppTextStyles.fontFamily,
          ),
        ),
      ],
    );
  }
}

class _NcdScreeningPainter extends CustomPainter {
  _NcdScreeningPainter({required this.hypertension, required this.diabetes});

  final List<double> hypertension;
  final List<double> diabetes;

  @override
  void paint(Canvas canvas, Size size) {
    final maxVal = [hypertension.reduce(max), diabetes.reduce(max)].reduce(max);
    final range = maxVal * 1.1;

    final xSteps = size.width / (hypertension.length - 1);

    double getY(double val) => size.height - (val / range * size.height);

    void drawLine(List<double> values, Color color) {
      final path = Path()..moveTo(0, getY(values[0]));
      for (var i = 1; i < values.length; i++) {
        path.lineTo(i * xSteps, getY(values[i]));
      }
      final paint = Paint()
        ..color = color
        ..strokeWidth = 1.8
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(path, paint);
    }

    // Gridlines
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..strokeWidth = 1.0;
    for (var i = 1; i <= 3; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    drawLine(hypertension, AppColors.error);
    drawLine(diabetes, AppColors.secondaryAccent);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
