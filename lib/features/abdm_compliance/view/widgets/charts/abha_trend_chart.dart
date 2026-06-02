import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AbhaTrendChart extends StatelessWidget {
  const AbhaTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock 30-day data points fluctuating around 10k to 14k
    final abhaData = [
      9800.0,
      10200.0,
      11500.0,
      10900.0,
      12100.0,
      11400.0,
      12600.0,
      13100.0,
      11800.0,
      12900.0,
      13400.0,
      12200.0,
      11900.0,
      12800.0,
      13500.0,
      14200.0,
      13000.0,
      13900.0,
      14400.0,
      13200.0,
      12700.0,
      13600.0,
      14100.0,
      14900.0,
      13800.0,
      14300.0,
      14800.0,
      13400.0,
      13100.0,
      12340.0,
    ];

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
              Container(
                width: MediaQuery.sizeOf(context).width * 0.55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily New ABHA IDs Generated Across Uttarakhand',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'New ABHA registrations per day vs daily target line',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 10,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x1F00C897),
                      border: Border.all(color: const Color(0x3D00C897)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      '+12,340 today',
                      style: TextStyle(
                        color: Color(0xFF00C897),
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Target: 11,000/day',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 2000,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppColors.border.withValues(alpha: 0.2),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 4000,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
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
                      reservedSize: 22,
                      interval: 6,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < 30) {
                          // Display select dates
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
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 29,
                minY: 6000,
                maxY: 16000,
                lineBarsData: [
                  // Actual ABHA creation line
                  LineChartBarData(
                    spots: List.generate(
                      abhaData.length,
                      (i) => FlSpot(i.toDouble(), abhaData[i]),
                    ),
                    isCurved: true,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0D9488), Color(0xFF06D6A0)],
                    ),
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF0D9488).withValues(alpha: 0.15),
                          const Color(0xFF06D6A0).withValues(alpha: 0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // Daily Target line
                  LineChartBarData(
                    spots: List.generate(
                      30,
                      (i) => FlSpot(i.toDouble(), 11000),
                    ),
                    isCurved: false,
                    color: const Color(0x7DFFD166),
                    barWidth: 1.5,
                    dashArray: [6, 4],
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
