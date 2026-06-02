import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class ConsentAnalyticsChart extends StatelessWidget {
  const ConsentAnalyticsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGroupedBarPanel(context),
        const SizedBox(height: 16),
        _buildDonutPanel(context),
      ],
    );
  }

  Widget _buildGroupedBarPanel(BuildContext context) {
    // 12 months requested vs approved vs denied
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
    final requested = [38, 41, 39, 44, 47, 49, 53, 56, 59, 63, 68, 72];
    final approved = [
      33.0,
      35.6,
      34.0,
      38.4,
      41.1,
      42.9,
      47.2,
      49.7,
      52.0,
      55.2,
      60.2,
      62.8,
    ];
    final denied = [3.9, 4.2, 4.1, 4.4, 4.7, 4.9, 5.1, 5.4, 5.6, 5.9, 6.2, 6.5];

    final barGroups = List.generate(12, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: requested[i].toDouble(),
            color: const Color(0xFF00B4D8).withValues(alpha: 0.4),
            width: 4,
            borderRadius: BorderRadius.circular(1),
          ),
          BarChartRodData(
            toY: approved[i],
            color: const Color(0xFF00C897),
            width: 4,
            borderRadius: BorderRadius.circular(1),
          ),
          BarChartRodData(
            toY: denied[i],
            color: const Color(0xFFFF4D6D),
            width: 4,
            borderRadius: BorderRadius.circular(1),
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
              Container(
                width: MediaQuery.sizeOf(context).width * 0.55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Consent Requests vs Approved vs Denied — Monthly Trend',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '12-month consent lifecycle outcomes',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 10,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0x1F9B5DE5),
                  border: Border.all(color: const Color(0x3D9B5DE5)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  '87.3% Approval Rate',
                  style: TextStyle(
                    color: Color(0xFF9B5DE5),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendDot(
                'Requested',
                const Color(0xFF00B4D8).withValues(alpha: 0.4),
              ),
              const SizedBox(width: 14),
              _buildLegendDot('Approved', const Color(0xFF00C897)),
              const SizedBox(width: 14),
              _buildLegendDot('Denied', const Color(0xFFFF4D6D)),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 80,
                barTouchData: BarTouchData(enabled: true),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            '${value.toStringAsFixed(0)}K',
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                      reservedSize: 24,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx >= 0 && idx < months.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              months[idx],
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
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 20,
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

  Widget _buildDonutPanel(BuildContext context) {
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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Consent Status Breakdown',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppTextStyles.fontFamily,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Current distribution of consent states',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 10,
                  fontFamily: AppTextStyles.fontFamily,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 150,
            child: PieChart(
              PieChartData(
                sectionsSpace: 4,
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(
                    value: 87.3,
                    color: const Color(0xFF00C897),
                    title: '87%',
                    radius: 20,
                    titleStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    value: 8.4,
                    color: const Color(0xFFFF4D6D),
                    title: '8%',
                    radius: 20,
                    titleStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    value: 4.3,
                    color: const Color(0xFFFFD166),
                    title: '4%',
                    radius: 20,
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
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _LegendDot('Approved 87%', Color(0xFF00C897)),
              _LegendDot('Denied 8%', Color(0xFFFF4D6D)),
              _LegendDot('Pending 4%', Color(0xFFFFD166)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendDot(String title, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
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

class _LegendDot extends StatelessWidget {
  const _LegendDot(this.title, this.color);
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 9,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
