import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class WomensHealthTab extends StatelessWidget {
  const WomensHealthTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.female_rounded,
                    color: Color(0xFFF72585),
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Spouse Annual Women's Health Checkup — Geeta Kumar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Counters Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 900
                      ? 6
                      : (constraints.maxWidth > 600 ? 3 : 2);
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: AppSpacing.sm,
                    mainAxisSpacing: AppSpacing.sm,
                    childAspectRatio: 2.2,
                    children: [
                      _buildCheckupTile(
                        label: 'Last Pap Smear',
                        value: 'Feb 2026 — Normal',
                        valueColor: AppColors.success,
                      ),
                      _buildCheckupTile(
                        label: 'Mammography',
                        value: 'Dec 2025 — Normal',
                        valueColor: AppColors.success,
                      ),
                      _buildCheckupTile(
                        label: 'Bone Density',
                        value: 'Jan 2026 — Osteopenia',
                        valueColor: AppColors.secondaryAccent,
                      ),
                      _buildCheckupTile(
                        label: 'Thyroid',
                        value: 'Mar 2026 — Normal',
                        valueColor: AppColors.success,
                      ),
                      _buildCheckupTile(
                        label: 'Menopause Status',
                        value: 'Peri-menopausal',
                        valueColor: Colors.white,
                      ),
                      _buildCheckupTile(
                        label: 'Next Checkup',
                        value: 'Feb 2027',
                        valueColor: AppColors.secondaryAccent,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              // AI Alert Box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.secondaryAccent.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.secondaryAccent.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.insights_rounded,
                      color: AppColors.secondaryAccent,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI Alert:',
                            style: TextStyle(
                              color: AppColors.secondaryAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.5,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Osteopenia detected. Calcium + Vit D supplementation advised. Repeat DEXA scan in 2 years. Weight-bearing exercises recommended to slow bone loss progression.',
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        // Charts row
        LayoutBuilder(
          builder: (context, constraints) {
            final isLargeScreen = constraints.maxWidth > 900;
            const spacing = AppSpacing.md;

            final charts = [
              _buildChartContainer(
                title: 'Bone Density Trend (T-score)',
                icon: Icons.show_chart_rounded,
                child: const SizedBox(
                  height: 200,
                  child: _BoneDensityChart(),
                ),
              ),
              _buildChartContainer(
                title: 'Women Health Checkup Status',
                icon: Icons.donut_large_rounded,
                child: const SizedBox(
                  height: 200,
                  child: _WomenHealthStatusChart(),
                ),
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
        ),
      ],
    );
  }

  Widget _buildCheckupTile({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.secondaryText, fontSize: 9),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: valueColor,
              fontWeight: FontWeight.bold,
              fontSize: 11.5,
            ),
          ),
        ],
      ),
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
              Icon(icon, color: const Color(0xFFF72585), size: 14),
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

class _BoneDensityChart extends StatelessWidget {
  const _BoneDensityChart();

  @override
  Widget build(BuildContext context) {
    final years = ['2020', '2021', '2022', '2023', '2024', '2025', '2026'];
    final scores = [-0.5, -0.7, -0.9, -1.0, -1.1, -1.2, -1.3];

    return LineChart(
      LineChartData(
        minY: -2.5,
        maxY: 0.5,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: AppColors.border.withValues(alpha: 0.15),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value % 0.5 != 0) return const SizedBox.shrink();
                return Text(
                  value.toStringAsFixed(1),
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 8,
                  ),
                );
              },
              reservedSize: 24,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= years.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    years[idx],
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 8.5,
                    ),
                  ),
                );
              },
              reservedSize: 18,
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              scores.length,
              (i) => FlSpot(i.toDouble(), scores[i]),
            ),
            isCurved: true,
            color: const Color(0xFFF72585),
            barWidth: 2.5,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFFF72585).withValues(alpha: 0.15),
            ),
          ),
          // Osteopenia threshold line at -1.0
          LineChartBarData(
            spots: List.generate(
              years.length,
              (i) => FlSpot(i.toDouble(), -1.0),
            ),
            isCurved: false,
            color: AppColors.secondaryAccent.withValues(alpha: 0.5),
            barWidth: 1.2,
            dashArray: [5, 5],
            dotData: const FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}

class _WomenHealthStatusChart extends StatelessWidget {
  const _WomenHealthStatusChart();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: [
                PieChartSectionData(
                  color: AppColors.success,
                  value: 4,
                  title: '4',
                  radius: 18,
                  titleStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: AppColors.secondaryAccent,
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
                  color: AppColors.error,
                  value: 0,
                  title: '0',
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
            _LegendItem(color: AppColors.success, label: 'Complete (4)'),
            SizedBox(height: 6),
            _LegendItem(color: AppColors.secondaryAccent, label: 'Due Soon (1)'),
            SizedBox(height: 6),
            _LegendItem(color: AppColors.error, label: 'Overdue (0)'),
          ],
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

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
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
