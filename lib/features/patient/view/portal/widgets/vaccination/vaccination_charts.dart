import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class VaccinationCharts extends StatelessWidget {
  const VaccinationCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth > 900;
        const spacing = AppSpacing.md;

        final charts = [
          _buildChartContainer(
            title: 'Immunization Coverage (%)',
            icon: Icons.bar_chart_rounded,
            child: const SizedBox(height: 200, child: _CoverageBarChart()),
          ),
          _buildChartContainer(
            title: 'Vaccine Status Distribution',
            icon: Icons.pie_chart_rounded,
            child: const SizedBox(height: 200, child: _StatusDoughnutChart()),
          ),
        ];

        if (isLargeScreen) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: charts[0]),
              const SizedBox(width: spacing),
              Expanded(child: charts[1]),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              charts[0],
              const SizedBox(height: spacing),
              charts[1],
            ],
          );
        }
      },
    );
  }

  Widget _buildChartContainer({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
              Icon(icon, color: AppColors.primaryLight, size: 14),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
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
}

class _CoverageBarChart extends StatelessWidget {
  const _CoverageBarChart();

  @override
  Widget build(BuildContext context) {
    final labels = [
      'COVID-19',
      'Hep B',
      'Tdap',
      'Flu',
      'MMR',
      'Typhoid',
      'Hep A',
      'Pneumo',
    ];
    final values = [100.0, 100.0, 0.0, 100.0, 100.0, 50.0, 100.0, 100.0];

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        minY: 0,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => AppColors.surface,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${labels[group.x]}: ${rod.toY.toInt()}%',
                const TextStyle(color: Colors.white, fontSize: 10),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= labels.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    labels[index],
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 8,
                    ),
                  ),
                );
              },
              reservedSize: 20,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value % 25 != 0) return const SizedBox.shrink();
                return Text(
                  '${value.toInt()}%',
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 8,
                  ),
                );
              },
              reservedSize: 28,
            ),
          ),
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
        ),
        gridData: FlGridData(
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: AppColors.border.withValues(alpha: 0.15),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(labels.length, (index) {
          final val = values[index];
          Color barColor;
          if (val == 100) {
            barColor = AppColors.success.withValues(alpha: 0.7);
          } else if (val >= 50) {
            barColor = AppColors.secondaryAccent.withValues(alpha: 0.7);
          } else {
            barColor = AppColors.error.withValues(alpha: 0.7);
          }

          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: val,
                color: barColor,
                width: 14,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: 100,
                  color: Colors.white.withValues(alpha: 0.03),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _StatusDoughnutChart extends StatelessWidget {
  const _StatusDoughnutChart();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              startDegreeOffset: -90,
              sections: [
                PieChartSectionData(
                  color: AppColors.success,
                  value: 8,
                  title: '8',
                  radius: 18,
                  titleStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: AppColors.secondaryAccent,
                  value: 2,
                  title: '2',
                  radius: 18,
                  titleStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: AppColors.error,
                  value: 1,
                  title: '1',
                  radius: 18,
                  titleStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: const Color(0xFF4A6A8A),
                  value: 1,
                  title: '1',
                  radius: 18,
                  titleStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _LegendItem(color: AppColors.success, label: 'Complete (8)'),
            SizedBox(height: 6),
            _LegendItem(
              color: AppColors.secondaryAccent,
              label: 'Due Soon (2)',
            ),
            SizedBox(height: 6),
            _LegendItem(color: AppColors.error, label: 'Overdue (1)'),
            SizedBox(height: 6),
            _LegendItem(color: Color(0xFF4A6A8A), label: 'N/A (1)'),
          ],
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 10),
        ),
      ],
    );
  }
}
