import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class ChildGrowthTab extends StatelessWidget {
  const ChildGrowthTab({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth > 900;
        final cardCrossAxisCount = constraints.maxWidth > 600 ? 2 : 1;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Children registered cards
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: cardCrossAxisCount,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
              childAspectRatio: cardCrossAxisCount == 2 ? 1.45 : 1.7,
              children: [
                _buildChildCard(
                  avatarIcon: Icons.person_rounded,
                  avatarBg: AppColors.primaryLight.withValues(alpha: 0.15),
                  avatarColor: AppColors.primaryLight,
                  name: 'Aryan Kumar',
                  ageDetails: 'Male · 22 years · DOB: 14 Mar 2004',
                  height: '174 cm',
                  weight: '68 kg',
                  bmi: '22.5',
                  percentile: 0.82,
                  percentileText: 'Growth Percentile: 82nd — Normal range',
                  extraInfo: Row(
                    children: [
                      const Text(
                        'Vaccinations: ',
                        style: TextStyle(
                            color: AppColors.secondaryText, fontSize: 10.5),
                      ),
                      const Text(
                        '✓ All complete',
                        style:
                            TextStyle(color: AppColors.success, fontSize: 10.5),
                      ),
                      Text(
                        ' · Blood group: ',
                        style: TextStyle(
                            color: AppColors.secondaryText, fontSize: 10.5),
                      ),
                      const Text(
                        'B+',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  footerText: 'Last checkup: Feb 2026 — No concerns',
                  footerColor: AppColors.secondaryText,
                ),
                _buildChildCard(
                  avatarIcon: Icons.person_3_rounded,
                  avatarBg: const Color(0xFFF72585).withValues(alpha: 0.15),
                  avatarColor: const Color(0xFFF72585),
                  name: 'Priya Kumar',
                  ageDetails: 'Female · 18 years · DOB: 02 Sep 2007',
                  height: '162 cm',
                  weight: '54 kg',
                  bmi: '20.6',
                  percentile: 0.70,
                  percentileText: 'Growth Percentile: 70th — Normal range',
                  extraInfo: Row(
                    children: [
                      const Text(
                        'Vaccinations: ',
                        style: TextStyle(
                            color: AppColors.secondaryText, fontSize: 10.5),
                      ),
                      const Text(
                        '✓ All complete',
                        style:
                            TextStyle(color: AppColors.success, fontSize: 10.5),
                      ),
                      Text(
                        ' · Blood group: ',
                        style: TextStyle(
                            color: AppColors.secondaryText, fontSize: 10.5),
                      ),
                      const Text(
                        'O+',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  footerText: '⚠ Dental checkup pending — Due May 2026',
                  footerColor: AppColors.secondaryAccent,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Growth Charts Grid
            if (isLargeScreen)
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _GrowthChartContainer(
                      title: 'Aryan — Height Growth (0–22 yrs)',
                      child: SizedBox(
                        height: 220,
                        child: _AryanGrowthChart(),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _GrowthChartContainer(
                      title: 'Priya — Height Growth (0–18 yrs)',
                      child: SizedBox(
                        height: 220,
                        child: _PriyaGrowthChart(),
                      ),
                    ),
                  ),
                ],
              )
            else ...[
              const _GrowthChartContainer(
                title: 'Aryan — Height Growth (0–22 yrs)',
                child: SizedBox(
                  height: 220,
                  child: _AryanGrowthChart(),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const _GrowthChartContainer(
                title: 'Priya — Height Growth (0–18 yrs)',
                child: SizedBox(
                  height: 220,
                  child: _PriyaGrowthChart(),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildChildCard({
    required IconData avatarIcon,
    required Color avatarBg,
    required Color avatarColor,
    required String name,
    required String ageDetails,
    required String height,
    required String weight,
    required String bmi,
    required double percentile,
    required String percentileText,
    required Widget extraInfo,
    required String footerText,
    required Color footerColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: avatarBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(avatarIcon, color: avatarColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      ageDetails,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildMetricTile('Height', height, AppColors.success),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _buildMetricTile('Weight', weight, AppColors.primaryLight),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _buildMetricTile('BMI', bmi, AppColors.success),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: percentile,
                backgroundColor: Colors.white.withValues(alpha: 0.08),
                color: AppColors.success,
                minHeight: 5,
                borderRadius: BorderRadius.circular(3),
              ),
              const SizedBox(height: 4),
              Text(
                percentileText,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          extraInfo,
          const SizedBox(height: 4),
          Text(
            footerText,
            style: TextStyle(
              color: footerColor,
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricTile(String label, String value, Color valueColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.secondaryText, fontSize: 9),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _GrowthChartContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const _GrowthChartContainer({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
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
              const Icon(
                Icons.stacked_line_chart_rounded,
                color: Color(0xFFF72585),
                size: 14,
              ),
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

class _AryanGrowthChart extends StatelessWidget {
  const _AryanGrowthChart();

  @override
  Widget build(BuildContext context) {
    final ages = ['0', '2', '4', '6', '8', '10', '12', '14', '16', '18', '20', '22'];
    final aryanHeight = [50.0, 86.0, 103.0, 118.0, 132.0, 142.0, 153.0, 163.0, 169.0, 172.0, 173.0, 174.0];
    final whoMedian = [49.0, 86.0, 103.0, 116.0, 128.0, 138.0, 149.0, 163.0, 170.0, 172.0, 173.0, 174.0];

    return LineChart(
      LineChartData(
        minY: 40,
        maxY: 185,
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
                if (value % 30 != 0) return const SizedBox.shrink();
                return Text(
                  '${value.toInt()} cm',
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 8,
                  ),
                );
              },
              reservedSize: 32,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= ages.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'Age ${ages[idx]}',
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
              aryanHeight.length,
              (i) => FlSpot(i.toDouble(), aryanHeight[i]),
            ),
            isCurved: true,
            color: AppColors.primaryLight,
            barWidth: 2.5,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.primaryLight.withValues(alpha: 0.15),
            ),
          ),
          LineChartBarData(
            spots: List.generate(
              whoMedian.length,
              (i) => FlSpot(i.toDouble(), whoMedian[i]),
            ),
            isCurved: true,
            color: AppColors.success.withValues(alpha: 0.4),
            barWidth: 1.5,
            dashArray: [5, 5],
            dotData: const FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}

class _PriyaGrowthChart extends StatelessWidget {
  const _PriyaGrowthChart();

  @override
  Widget build(BuildContext context) {
    final ages = ['0', '2', '4', '6', '8', '10', '12', '14', '16', '18'];
    final priyaHeight = [49.0, 84.0, 100.0, 115.0, 128.0, 140.0, 151.0, 158.0, 161.0, 162.0];
    final whoMedian = [48.0, 84.0, 100.0, 114.0, 126.0, 138.0, 149.0, 157.0, 160.0, 161.0];

    return LineChart(
      LineChartData(
        minY: 40,
        maxY: 180,
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
                if (value % 30 != 0) return const SizedBox.shrink();
                return Text(
                  '${value.toInt()} cm',
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 8,
                  ),
                );
              },
              reservedSize: 32,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= ages.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'Age ${ages[idx]}',
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
              priyaHeight.length,
              (i) => FlSpot(i.toDouble(), priyaHeight[i]),
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
          LineChartBarData(
            spots: List.generate(
              whoMedian.length,
              (i) => FlSpot(i.toDouble(), whoMedian[i]),
            ),
            isCurved: true,
            color: Colors.purpleAccent.withValues(alpha: 0.4),
            barWidth: 1.5,
            dashArray: [5, 5],
            dotData: const FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
