import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class RadiologyCharts extends StatelessWidget {
  const RadiologyCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildModalityChartCard()),
              const SizedBox(width: AppSpacing.lg),
              Expanded(child: _buildFindingsChartCard()),
            ],
          );
        } else {
          return Column(
            children: [
              _buildModalityChartCard(),
              const SizedBox(height: AppSpacing.lg),
              _buildFindingsChartCard(),
            ],
          );
        }
      },
    );
  }

  Widget _buildModalityChartCard() {
    return Container(
      height: 280,
      padding: const EdgeInsets.all(AppSpacing.md),
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
              const Icon(Icons.bar_chart_rounded, color: Color(0xFF00B4D8), size: 16),
              const SizedBox(width: 6),
              Text(
                'Imaging Studies by Modality (3 Years)',
                style: AppTextStyles.labelMedium.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 5,
                barTouchData: const BarTouchData(),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(color: AppColors.secondaryText, fontSize: 9);
                        String text;
                        switch (value.toInt()) {
                          case 0:
                            text = 'X-Ray';
                          case 1:
                            text = 'USG';
                          case 2:
                            text = 'CT';
                          case 3:
                            text = 'MRI';
                          case 4:
                            text = 'Echo';
                          case 5:
                            text = 'Others';
                          default:
                            text = '';
                        }
                        return SideTitleWidget(
                          meta: meta,
                          space: 4,
                          child: Text(text, style: style),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(color: AppColors.secondaryText, fontSize: 8),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppColors.border.withValues(alpha: 0.4),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _makeGroupData(0, [3, 2, 2]),
                  _makeGroupData(1, [1, 2, 1]),
                  _makeGroupData(2, [1, 1, 0]),
                  _makeGroupData(3, [0, 1, 0]),
                  _makeGroupData(4, [1, 0, 1]),
                  _makeGroupData(5, [0, 1, 0]),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildModalityLegend(),
        ],
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, List<double> values) {
    const width = 6.0;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: values[0],
          color: const Color(0xFF00B4D8).withValues(alpha: 0.7),
          width: width,
          borderRadius: BorderRadius.circular(2),
        ),
        BarChartRodData(
          toY: values[1],
          color: const Color(0xFFC77DFF).withValues(alpha: 0.7),
          width: width,
          borderRadius: BorderRadius.circular(2),
        ),
        BarChartRodData(
          toY: values[2],
          color: const Color(0xFF22C55E).withValues(alpha: 0.7),
          width: width,
          borderRadius: BorderRadius.circular(2),
        ),
      ],
    );
  }

  Widget _buildModalityLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem('2024', const Color(0xFF00B4D8).withValues(alpha: 0.7)),
        const SizedBox(width: 12),
        _buildLegendItem('2025', const Color(0xFFC77DFF).withValues(alpha: 0.7)),
        const SizedBox(width: 12),
        _buildLegendItem('2026', const Color(0xFF22C55E).withValues(alpha: 0.7)),
      ],
    );
  }

  Widget _buildFindingsChartCard() {
    return Container(
      height: 280,
      padding: const EdgeInsets.all(AppSpacing.md),
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
              const Icon(Icons.pie_chart_rounded, color: Color(0xFF00B4D8), size: 16),
              const SizedBox(width: 6),
              Text(
                'Findings Distribution',
                style: AppTextStyles.labelMedium.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: [
                        PieChartSectionData(
                          value: 11,
                          title: '11',
                          color: AppColors.success,
                          radius: 18,
                          titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        PieChartSectionData(
                          value: 2,
                          title: '2',
                          color: AppColors.secondaryAccent,
                          radius: 18,
                          titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        PieChartSectionData(
                          value: 0.001, // Avoid crash if 0
                          title: '',
                          color: AppColors.error,
                          radius: 18,
                          titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        PieChartSectionData(
                          value: 1,
                          title: '1',
                          color: AppColors.secondaryText,
                          radius: 18,
                          titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLegendItem('Normal (11)', AppColors.success),
                      const SizedBox(height: 6),
                      _buildLegendItem('Mild (2)', AppColors.secondaryAccent),
                      const SizedBox(height: 6),
                      _buildLegendItem('Significant (0)', AppColors.error),
                      const SizedBox(height: 6),
                      _buildLegendItem('Pending (1)', AppColors.secondaryText),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 9, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
