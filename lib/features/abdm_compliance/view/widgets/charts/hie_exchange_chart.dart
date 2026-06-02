import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class HieExchangeChart extends StatelessWidget {
  const HieExchangeChart({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random(42); // Seeded random for consistent layout

    // Create 30 days data. For each day, we stack 4 categories:
    // Lab (22k-48k), Prescriptions (16k-38k), Discharge (5k-14k), Imaging (3.5k-11k)
    final barGroups = List.generate(30, (i) {
      final lab = (22000 + random.nextInt(26000)).toDouble();
      final presc = (16000 + random.nextInt(22000)).toDouble();
      final discharge = (5000 + random.nextInt(9000)).toDouble();
      final imaging = (3500 + random.nextInt(7500)).toDouble();
      final total = lab + presc + discharge + imaging;

      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: total,
            width: 7,
            borderRadius: BorderRadius.circular(2),
            gradient: const LinearGradient(
              colors: [AppColors.primaryLight, Color(0xFF00B4D8)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            rodStackItems: [
              BarChartRodStackItem(0, lab, const Color(0xFF00B4D8)),
              BarChartRodStackItem(lab, lab + presc, const Color(0xFF00C897)),
              BarChartRodStackItem(
                lab + presc,
                lab + presc + discharge,
                const Color(0xFF9B5DE5),
              ),
              BarChartRodStackItem(
                lab + presc + discharge,
                total,
                const Color(0xFFFFD166),
              ),
            ],
          ),
        ],
      );
    });

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.55,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HIP ↔ HIU Data Exchanges via ABDM Gateway — Stacked by Type',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Lab reports · Prescriptions · Discharge summaries · Imaging reports exchanged daily',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 10,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
              const Row(
                children: [
                  Text(
                    '2.34L today',
                    style: TextStyle(
                      color: Color(0xFF00B4D8),
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '+31.4% YoY',
                    style: TextStyle(
                      color: Color(0xFF00C897),
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Lab Reports', const Color(0xFF00B4D8)),
              const SizedBox(width: 14),
              _buildLegendItem('Prescriptions', const Color(0xFF00C897)),
              const SizedBox(width: 14),
              _buildLegendItem('Discharge', const Color(0xFF9B5DE5)),
              const SizedBox(width: 14),
              _buildLegendItem('Imaging', const Color(0xFFFFD166)),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 110000,
                barTouchData: const BarTouchData(enabled: true),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 25000,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            '${(value / 1000).toStringAsFixed(0)}K',
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        );
                      },
                      reservedSize: 28,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 6,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < 30) {
                          final day = 30 - index;
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              '${day}d ago',
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 9,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                gridData: FlGridData(
                  drawVerticalLine: false,
                  horizontalInterval: 25000,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppColors.border.withValues(alpha: 0.2),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: barGroups,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String title, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 9.5,
            fontWeight: FontWeight.w600,
            fontFamily: AppTextStyles.fontFamily,
          ),
        ),
      ],
    );
  }
}
