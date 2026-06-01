import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class TeleCharts extends StatelessWidget {
  const TeleCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth > 900;

        final charts = [
          _buildChartCard(
            title: 'Monthly Teleconsultations (12 Months)',
            icon: Icons.bar_chart_rounded,
            child: SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 4,
                  barTouchData: const BarTouchData(),
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
                            return Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                labels[idx],
                                style: const TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 9,
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                        reservedSize: 20,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 9,
                            ),
                          );
                        },
                        reservedSize: 18,
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
                  barGroups: _buildBarGroups(),
                ),
              ),
            ),
          ),
          _buildChartCard(
            title: 'Consultations by Specialty',
            icon: Icons.pie_chart_outline_rounded,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 3,
                        centerSpaceRadius: 40,
                        sections: [
                          PieChartSectionData(
                            color: const Color(0xFFEF4444),
                            value: 5,
                            title: '5',
                            radius: 35,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PieChartSectionData(
                            color: const Color(0xFFC77DFF),
                            value: 4,
                            title: '4',
                            radius: 35,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PieChartSectionData(
                            color: AppColors.success,
                            value: 3,
                            title: '3',
                            radius: 35,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PieChartSectionData(
                            color: const Color(0xFFFFD166),
                            value: 1,
                            title: '1',
                            radius: 35,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PieChartSectionData(
                            color: AppColors.primaryLight,
                            value: 1,
                            title: '1',
                            radius: 35,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
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
                      _buildLegendItem('Cardiology', const Color(0xFFEF4444)),
                      const SizedBox(height: 6),
                      _buildLegendItem(
                        'Endocrinology',
                        const Color(0xFFC77DFF),
                      ),
                      const SizedBox(height: 6),
                      _buildLegendItem('General Medicine', AppColors.success),
                      const SizedBox(height: 6),
                      _buildLegendItem('Orthopedics', const Color(0xFFFFD166)),
                      const SizedBox(height: 6),
                      _buildLegendItem('Radiology', AppColors.primaryLight),
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

  List<BarChartGroupData> _buildBarGroups() {
    final dataset = [1, 2, 1, 1, 1, 2, 1, 1, 2, 1, 1, 2];
    return List.generate(dataset.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: dataset[index].toDouble(),
            color: const Color(0xFF00B4D8).withValues(alpha: 0.7),
            width: 14,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 4,
              color: Colors.white.withValues(alpha: 0.03),
            ),
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
              Icon(icon, color: const Color(0xFF00B4D8), size: 14),
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
