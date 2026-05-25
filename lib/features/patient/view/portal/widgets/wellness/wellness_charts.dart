import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class WellnessCharts extends StatelessWidget {
  const WellnessCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLarge = constraints.maxWidth > 900;

        final trendCard = _buildCard(
          title: 'Wellness Score Trend (12 Months)',
          icon: Icons.show_chart_rounded,
          iconColor: AppColors.success,
          child: const _WellnessTrendLineChart(),
        );

        final stepsCard = _buildCard(
          title: 'Daily Steps — Last 30 Days',
          icon: Icons.bar_chart_rounded,
          iconColor: Colors.teal,
          child: const _DailyStepsBarChart(),
        );

        final sleepCard = _buildCard(
          title: 'Sleep Duration — Last 30 Days',
          icon: Icons.nightlight_round_rounded,
          iconColor: Colors.purpleAccent,
          child: const _SleepDurationBarChart(),
        );

        if (isLarge) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(child: trendCard),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: stepsCard),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(child: sleepCard),
                  const Expanded(child: SizedBox.shrink()),
                ],
              ),
            ],
          );
        } else {
          return Column(
            children: [
              trendCard,
              const SizedBox(height: AppSpacing.md),
              stepsCard,
              const SizedBox(height: AppSpacing.md),
              sleepCard,
            ],
          );
        }
      },
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Widget child,
  }) {
    return Container(
      height: 280,
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
              Icon(icon, color: iconColor, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _WellnessTrendLineChart extends StatelessWidget {
  const _WellnessTrendLineChart();

  @override
  Widget build(BuildContext context) {
    final months = [
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
    final scores = [82, 80, 79, 78, 77, 76, 74, 73, 74, 76, 76, 78];

    return LineChart(
      LineChartData(
        minY: 60,
        maxY: 100,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 8.5,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx >= 0 && idx < months.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      months[idx],
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 8.5,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) => AppColors.surface,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  'Score: ${spot.y.toInt()}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                );
              }).toList();
            },
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              scores.length,
              (index) => FlSpot(index.toDouble(), scores[index].toDouble()),
            ),
            isCurved: true,
            color: AppColors.success,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.success.withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyStepsBarChart extends StatelessWidget {
  const _DailyStepsBarChart();

  @override
  Widget build(BuildContext context) {
    // Generate simulated steps walk for 30 days
    final stepsData = [
      4820,
      5600,
      6100,
      4900,
      7800,
      8200,
      8500,
      7100,
      6800,
      5200,
      4300,
      3900,
      6400,
      8100,
      8300,
      7900,
      6100,
      5800,
      4900,
      3500,
      5200,
      7400,
      8100,
      8400,
      7900,
      6200,
      5400,
      4800,
      3600,
      4820,
    ];

    return BarChart(
      BarChartData(
        maxY: 10000,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                if (value % 2000 == 0) {
                  return Text(
                    '${(value / 1000).toInt()}k',
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 8.5,
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final day = value.toInt() + 1;
                if (day % 5 == 0 || day == 1) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '$day',
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 8.5,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => AppColors.surface,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                'Day ${group.x + 1}\n${rod.toY.toInt()} steps',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              );
            },
          ),
        ),
        barGroups: List.generate(stepsData.length, (idx) {
          final val = stepsData[idx];
          Color color;
          if (val >= 8000) {
            color = AppColors.success.withValues(alpha: 0.7);
          } else if (val >= 5000) {
            color = AppColors.secondaryAccent.withValues(alpha: 0.7);
          } else {
            color = AppColors.error.withValues(alpha: 0.6);
          }

          return BarChartGroupData(
            x: idx,
            barRods: [
              BarChartRodData(
                toY: val.toDouble(),
                color: color,
                width: 6,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _SleepDurationBarChart extends StatelessWidget {
  const _SleepDurationBarChart();

  @override
  Widget build(BuildContext context) {
    // Generate simulated sleep hours for 30 days
    final sleepData = [
      6.2,
      6.5,
      7.0,
      5.8,
      7.2,
      7.5,
      8.0,
      6.8,
      6.4,
      5.5,
      5.2,
      6.0,
      7.1,
      7.4,
      7.8,
      6.9,
      6.2,
      6.0,
      5.8,
      5.0,
      6.2,
      7.0,
      7.5,
      7.8,
      8.1,
      6.5,
      6.1,
      5.9,
      5.5,
      6.2,
    ];

    return BarChart(
      BarChartData(
        maxY: 10,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                if (value % 2 == 0) {
                  return Text(
                    '${value.toInt()}h',
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 8.5,
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final day = value.toInt() + 1;
                if (day % 5 == 0 || day == 1) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '$day',
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 8.5,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => AppColors.surface,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                'Day ${group.x + 1}\n${rod.toY} hrs',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              );
            },
          ),
        ),
        barGroups: List.generate(sleepData.length, (idx) {
          final val = sleepData[idx];
          Color color;
          if (val >= 7.0) {
            color = AppColors.success.withValues(alpha: 0.7);
          } else if (val >= 6.0) {
            color = AppColors.secondaryAccent.withValues(alpha: 0.7);
          } else {
            color = AppColors.error.withValues(alpha: 0.6);
          }

          return BarChartGroupData(
            x: idx,
            barRods: [
              BarChartRodData(
                toY: val,
                color: color,
                width: 6,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
