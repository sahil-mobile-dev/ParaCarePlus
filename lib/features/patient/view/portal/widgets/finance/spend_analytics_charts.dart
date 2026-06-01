import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class SpendAnalyticsCharts extends StatelessWidget {
  const SpendAnalyticsCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth > 900;

        final charts = [
          _buildChartCard(
            title: 'Monthly Health Spend (12 Months)',
            icon: Icons.bar_chart_rounded,
            child: SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 11000,
                  barTouchData: const BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const labels = [
                            'Jun',
                            'Jul',
                            'Aug',
                            'Sep',
                            'Oct',
                            'Nov',
                            'Dec',
                            'Jan',
                            'Feb',
                            'Mar',
                            'Apr',
                            'May',
                          ];
                          final idx = value.toInt();
                          if (idx >= 0 && idx < labels.length) {
                            return Text(
                              labels[idx],
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 9,
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                        reservedSize: 18,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 3000,
                        getTitlesWidget: (value, meta) {
                          if (value == 0) {
                            return const Text(
                              '0',
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 8.5,
                              ),
                            );
                          }
                          return Text(
                            '₹${(value / 1000).toStringAsFixed(0)}K',
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 8.5,
                            ),
                          );
                        },
                        reservedSize: 32,
                      ),
                    ),
                    topTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                  ),
                  gridData: FlGridData(
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: AppColors.border.withValues(alpha: 0.15),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: _buildStackedBarGroups(),
                ),
              ),
            ),
          ),
          _buildChartCard(
            title: 'Spend by Category',
            icon: Icons.pie_chart_outline_rounded,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: [
                          PieChartSectionData(
                            color: const Color(0xFF00B4D8), // Lab Tests
                            value: 28,
                            title: '28%',
                            radius: 35,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PieChartSectionData(
                            color: const Color(0xFF00C897), // OPD
                            value: 22,
                            title: '22%',
                            radius: 35,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PieChartSectionData(
                            color: const Color(0xFFC77DFF), // Radiology
                            value: 18,
                            title: '18%',
                            radius: 35,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PieChartSectionData(
                            color: const Color(0xFFFFD166), // Medicines
                            value: 16,
                            title: '16%',
                            radius: 35,
                            titleStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PieChartSectionData(
                            color: const Color(0xFFF77F00), // Procedures
                            value: 10,
                            title: '10%',
                            radius: 35,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PieChartSectionData(
                            color: const Color(0xFF7A9BBF), // Others
                            value: 6,
                            title: '6%',
                            radius: 35,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLegendItem('Lab Tests', const Color(0xFF00B4D8)),
                      const SizedBox(height: 5),
                      _buildLegendItem('OPD Consult', const Color(0xFF00C897)),
                      const SizedBox(height: 5),
                      _buildLegendItem('Radiology', const Color(0xFFC77DFF)),
                      const SizedBox(height: 5),
                      _buildLegendItem('Medicines', const Color(0xFFFFD166)),
                      const SizedBox(height: 5),
                      _buildLegendItem('Procedures', const Color(0xFFF77F00)),
                      const SizedBox(height: 5),
                      _buildLegendItem('Others', const Color(0xFF7A9BBF)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ];

        if (isLargeScreen) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: charts[0]),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: charts[1]),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              charts[0],
              const SizedBox(height: AppSpacing.md),
              charts[1],
            ],
          );
        }
      },
    );
  }

  List<BarChartGroupData> _buildStackedBarGroups() {
    final insured = [
      8200,
      4200,
      3200,
      6800,
      9200,
      4800,
      5600,
      7200,
      3400,
      6800,
      8200,
      4200,
    ];
    final oop = [600, 400, 800, 1200, 800, 600, 1000, 400, 600, 1200, 600, 600];

    return List.generate(12, (index) {
      final insuredValue = insured[index].toDouble();
      final oopValue = oop[index].toDouble();

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: insuredValue + oopValue,
            rodStackItems: [
              BarChartRodStackItem(
                0,
                insuredValue,
                const Color(0xFF00B4D8).withValues(alpha: 0.6),
              ),
              BarChartRodStackItem(
                insuredValue,
                insuredValue + oopValue,
                const Color(0xFFFFD166).withValues(alpha: 0.6),
              ),
            ],
            width: 14,
            borderRadius: const BorderRadius.all(Radius.circular(3)),
          ),
        ],
      );
    });
  }

  Widget _buildChartCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF00C897), size: 14),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildLegendItem(String name, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 9.5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
