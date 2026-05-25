import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class PrescriptionCharts extends StatelessWidget {
  const PrescriptionCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildAdherenceChartCard()),
              const SizedBox(width: AppSpacing.lg),
              Expanded(child: _buildCategoryChartCard()),
            ],
          );
        } else {
          return Column(
            children: [
              _buildAdherenceChartCard(),
              const SizedBox(height: AppSpacing.lg),
              _buildCategoryChartCard(),
            ],
          );
        }
      },
    );
  }

  Widget _buildAdherenceChartCard() {
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
                'Medication Adherence (Last 30 Days)',
                style: AppTextStyles.labelMedium.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 32,
                barTouchData: const BarTouchData(),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(color: AppColors.secondaryText, fontSize: 8);
                        String text;
                        switch (value.toInt()) {
                          case 0:
                            text = 'Amlodipine';
                          case 1:
                            text = 'Metformin';
                          case 2:
                            text = 'Atorvas';
                          case 3:
                            text = 'Vit D3';
                          case 4:
                            text = 'Omepraz';
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
                      interval: 8,
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
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppColors.border.withValues(alpha: 0.4),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _makeStackedGroupData(0, 28, 2),
                  _makeStackedGroupData(1, 26, 4),
                  _makeStackedGroupData(2, 25, 5),
                  _makeStackedGroupData(3, 24, 6),
                  _makeStackedGroupData(4, 27, 3),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildAdherenceLegend(),
        ],
      ),
    );
  }

  BarChartGroupData _makeStackedGroupData(int x, double taken, double missed) {
    const width = 12.0;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: taken + missed,
          rodStackItems: [
            BarChartRodStackItem(0, taken, const Color(0xFF00C897).withValues(alpha: 0.7)),
            BarChartRodStackItem(taken, taken + missed, const Color(0xFFFF4D6D).withValues(alpha: 0.5)),
          ],
          width: width,
          borderRadius: BorderRadius.circular(2),
        ),
      ],
    );
  }

  Widget _buildAdherenceLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem('Taken', const Color(0xFF00C897).withValues(alpha: 0.7)),
        const SizedBox(width: 12),
        _buildLegendItem('Missed', const Color(0xFFFF4D6D).withValues(alpha: 0.5)),
      ],
    );
  }

  Widget _buildCategoryChartCard() {
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
                'Prescription Category Distribution',
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
                          value: 2,
                          title: '2',
                          color: const Color(0xFFFF4D6D),
                          radius: 18,
                          titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        PieChartSectionData(
                          value: 1,
                          title: '1',
                          color: const Color(0xFFF77F00),
                          radius: 18,
                          titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        PieChartSectionData(
                          value: 1,
                          title: '1',
                          color: const Color(0xFF3A86FF),
                          radius: 18,
                          titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        PieChartSectionData(
                          value: 1,
                          title: '1',
                          color: const Color(0xFF00C897),
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
                      _buildLegendItem('Cardio (2)', const Color(0xFFFF4D6D)),
                      const SizedBox(height: 6),
                      _buildLegendItem('Anti-Diab (1)', const Color(0xFFF77F00)),
                      const SizedBox(height: 6),
                      _buildLegendItem('Gastric (1)', const Color(0xFF3A86FF)),
                      const SizedBox(height: 6),
                      _buildLegendItem('Supplem (1)', const Color(0xFF00C897)),
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
