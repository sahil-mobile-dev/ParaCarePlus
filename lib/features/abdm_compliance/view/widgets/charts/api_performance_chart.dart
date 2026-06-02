import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class ApiPerformanceChart extends StatelessWidget {
  const ApiPerformanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    // 24 hourly points for latency (fluctuating around 180 to 250) and success rate (99.0 to 99.8)
    final latencyPoints = [
      210.0,
      214.0,
      220.0,
      198.0,
      205.0,
      212.0,
      230.0,
      245.0,
      250.0,
      222.0,
      218.0,
      209.0,
      201.0,
      215.0,
      224.0,
      235.0,
      214.0,
      208.0,
      210.0,
      218.0,
      222.0,
      234.0,
      228.0,
      214.0,
    ];
    final successPoints = [
      99.2,
      99.3,
      99.4,
      99.3,
      99.5,
      99.4,
      99.3,
      99.1,
      99.0,
      99.2,
      99.4,
      99.5,
      99.6,
      99.5,
      99.4,
      99.2,
      99.3,
      99.4,
      99.5,
      99.6,
      99.4,
      99.3,
      99.2,
      99.3,
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ABDM Gateway Response Latency (ms) vs API Success Rate (%)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Dual-axis chart: Line = Latency (ms) · Success Rate = % (right axis)',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 10,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
              const Column(
                children: [
                  Text(
                    'Avg 214ms',
                    style: TextStyle(
                      color: Color(0xFF00B4D8),
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '99.3% Success',
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
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  drawVerticalLine: false,
                  horizontalInterval: 50,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppColors.border.withValues(alpha: 0.2),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 100, // Dummy interval
                      getTitlesWidget: (value, meta) {
                        // Display some success rates on the right
                        if (value == 100) {
                          return const Text(
                            '99.0%',
                            style: TextStyle(
                              color: Color(0xFF00C897),
                              fontSize: 8,
                            ),
                          );
                        }
                        if (value == 200) {
                          return const Text(
                            '99.4%',
                            style: TextStyle(
                              color: Color(0xFF00C897),
                              fontSize: 8,
                            ),
                          );
                        }
                        if (value == 300) {
                          return const Text(
                            '99.8%',
                            style: TextStyle(
                              color: Color(0xFF00C897),
                              fontSize: 8,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      reservedSize: 28,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 100,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            '${value.toStringAsFixed(0)}ms',
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                      reservedSize: 32,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 4,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx >= 0 && idx < 24) {
                          final h = (DateTime.now().hour - 23 + idx + 24) % 24;
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              '${h.toString().padLeft(2, '0')}:00',
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 8.5,
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
                maxX: 23,
                minY: 100,
                maxY: 400,
                lineBarsData: [
                  // Latency Line
                  LineChartBarData(
                    spots: List.generate(
                      24,
                      (i) => FlSpot(i.toDouble(), latencyPoints[i]),
                    ),
                    isCurved: true,
                    color: const Color(0xFF00B4D8),
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF00B4D8).withValues(alpha: 0.1),
                    ),
                  ),
                  // Success Rate mapped onto left scale dynamically for rendering
                  LineChartBarData(
                    spots: List.generate(24, (i) {
                      // Map success rate (99.0 to 99.8) to (100 to 300)
                      final mapped = 100 + (successPoints[i] - 99.0) * 250;
                      return FlSpot(i.toDouble(), mapped);
                    }),
                    isCurved: true,
                    color: const Color(0xFF00C897),
                    barWidth: 1.5,
                    dashArray: [4, 4],
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
