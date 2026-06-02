import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class WaterborneTrendsChart extends StatelessWidget {
  const WaterborneTrendsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final months = ['Jun', 'Aug', 'Oct', 'Dec', 'Feb', 'Apr'];
    final typhoid = [300.0, 340.0, 480.0, 310.0, 220.0, 410.0];
    final cholera = [40.0, 65.0, 92.0, 34.0, 28.0, 42.0];
    final hepA = [80.0, 110.0, 140.0, 75.0, 68.0, 98.0];

    final districts = ['D.Dun', 'H.war', 'N.tal', 'U.S.N', 'Alm', 'Teh', 'Cha'];
    final casesYtd = [148.0, 210.0, 92.0, 184.0, 76.0, 89.0, 34.0];
    final maxDistCases = casesYtd.reduce(max);

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final isMobile = w < 760;

        final trends = _buildTrendPanel(months, typhoid, cholera, hepA);
        final districtBars = _buildDistrictPanel(
          districts,
          casesYtd,
          maxDistCases,
        );

        return isMobile
            ? Column(
                children: [trends, const SizedBox(height: 16), districtBars],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: trends),
                  const SizedBox(width: 16),
                  Expanded(flex: 2, child: districtBars),
                ],
              );
      },
    );
  }

  Widget _buildTrendPanel(
    List<String> months,
    List<double> typhoid,
    List<double> cholera,
    List<double> hepA,
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
            'Water-borne Disease Trends',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Monthly Trends (Last 12 Months) Correlated with Weather',
            style: TextStyle(
              fontSize: 9.5,
              color: AppColors.secondaryText,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              _LegendDot('Typhoid', AppColors.primaryLight),
              SizedBox(width: 12),
              _LegendDot('Cholera', AppColors.secondaryAccent),
              SizedBox(width: 12),
              _LegendDot('Hepatitis A/E', Color(0xFF9B5DE5)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            width: double.infinity,
            child: CustomPaint(
              painter: _LineTrendsPainter(
                typhoid: typhoid,
                cholera: cholera,
                hepA: hepA,
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

  Widget _buildDistrictPanel(
    List<String> districts,
    List<double> casesYtd,
    double maxVal,
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
            'District-wise WBD Burden',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Total Water-borne Cases YTD',
            style: TextStyle(
              fontSize: 9.5,
              color: AppColors.secondaryText,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: List.generate(districts.length, (idx) {
              final d = districts[idx];
              final c = casesYtd[idx];
              final ratio = maxVal == 0 ? 0.0 : c / maxVal;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        d,
                        style: const TextStyle(
                          fontSize: 9.5,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.04),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: ratio,
                            child: Container(
                              height: 10,
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight.withValues(
                                  alpha: 0.8,
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 32,
                      child: Text(
                        '${c.round()}',
                        style: const TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              );
            }),
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

class _LineTrendsPainter extends CustomPainter {
  _LineTrendsPainter({
    required this.typhoid,
    required this.cholera,
    required this.hepA,
  });

  final List<double> typhoid;
  final List<double> cholera;
  final List<double> hepA;

  @override
  void paint(Canvas canvas, Size size) {
    final maxVal = [
      typhoid.reduce(max),
      cholera.reduce(max),
      hepA.reduce(max),
    ].reduce(max);
    final range = maxVal * 1.1;

    final xSteps = size.width / (typhoid.length - 1);

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

    drawLine(typhoid, AppColors.primaryLight);
    drawLine(cholera, AppColors.secondaryAccent);
    drawLine(hepA, const Color(0xFF9B5DE5));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
