import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class FacilityDistrictCharts extends StatelessWidget {
  const FacilityDistrictCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFacilityChart(),
        const SizedBox(height: 16),
        _buildDistrictChart(context),
      ],
    );
  }

  Widget _buildFacilityChart() {
    final facilityNames = [
      'AIIMS Rishikesh',
      'Doon Hosp Ddn',
      'Dehradun Dist H',
      'Haldwani Base H',
      'Haridwar Dist H',
      'Srinagar Govt H',
      'Almora Dist H',
      'Rudrapur Dist H',
      'Pauri Dist H',
      'Tehri Dist H',
      'Champawat CHC',
      'Bageshwar CHC',
    ];
    final scores = [
      94.0,
      88.0,
      82.0,
      85.0,
      79.0,
      76.0,
      71.0,
      80.0,
      65.0,
      68.0,
      59.0,
      54.0,
    ];

    final barGroups = List.generate(facilityNames.length, (i) {
      final val = scores[i];
      Color barColor = const Color(0xFF00C897); // Green >= 85
      if (val >= 85) {
        barColor = const Color(0xFF00C897);
      } else if (val >= 70) {
        barColor = const Color(0xFF00B4D8);
      } else if (val >= 60) {
        barColor = const Color(0xFFFFD166);
      } else {
        barColor = const Color(0xFFFF4D6D);
      }

      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: val,
            color: barColor,
            width: 8,
            borderRadius: BorderRadius.circular(2),
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Facility-wise ABDM Compliance Score (Top 12)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Overall ABDM compliance % per facility',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                ],
              ),
              Text(
                'Avg: 74.8%',
                style: TextStyle(
                  color: Color(0xFF00C897),
                  fontSize: 9.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100,
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
                      interval: 25,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            '${value.toStringAsFixed(0)}%',
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
                      reservedSize: 26,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx >= 0 && idx < facilityNames.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Transform.rotate(
                              angle: -0.15,
                              child: Text(
                                facilityNames[idx],
                                style: const TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
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
                  horizontalInterval: 25,
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

  Widget _buildDistrictChart(BuildContext context) {
    final distNames = [
      'Ddn',
      'Hrd',
      'Ntl',
      'Usn',
      'Pau',
      'Teh',
      'Chm',
      'Rud',
      'Utr',
      'Alm',
      'Pit',
      'Bag',
      'Chp',
    ];
    final scores = [
      84.0,
      79.0,
      81.0,
      76.0,
      68.0,
      72.0,
      65.0,
      61.0,
      63.0,
      70.0,
      58.0,
      55.0,
      57.0,
    ];

    final barGroups = List.generate(distNames.length, (i) {
      final val = scores[i];
      Color barColor = const Color(0xFF00C897); // Green >= 80
      if (val >= 80) {
        barColor = const Color(0xFF00C897);
      } else if (val >= 70) {
        barColor = const Color(0xFF00B4D8);
      } else if (val >= 60) {
        barColor = const Color(0xFFFFD166);
      } else {
        barColor = const Color(0xFFFF4D6D);
      }

      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: val,
            color: barColor,
            width: 8,
            borderRadius: BorderRadius.circular(2),
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
                width: MediaQuery.of(context).size.width * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'District-wise ABHA Coverage % (All 13 Districts)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Digital Health ID adoption rate by district',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 10,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'State Avg: 73.4%',
                style: TextStyle(
                  color: Color(0xFF00B4D8),
                  fontSize: 9.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100,
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
                      interval: 25,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            '${value.toStringAsFixed(0)}%',
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
                      reservedSize: 24,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx >= 0 && idx < distNames.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              distNames[idx],
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
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
                  horizontalInterval: 25,
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
}
