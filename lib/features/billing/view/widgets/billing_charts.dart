import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class RevenueTrendChart extends StatelessWidget {
  const RevenueTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.show_chart_rounded,
                size: 20,
                color: AppColors.success,
              ),
              SizedBox(width: 8),
              Text(
                'Revenue Trend (Last 14 Days)',
                style: AppTextStyles.titleSmall,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  horizontalInterval: 5000,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.border.withValues(alpha: 0.5),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: AppColors.border.withValues(alpha: 0.5),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10,
                        );
                        Widget text;
                        switch (value.toInt()) {
                          case 0:
                            text = const Text('Mar30', style: style);
                          case 2:
                            text = const Text('Apr1', style: style);
                          case 4:
                            text = const Text('Apr3', style: style);
                          case 6:
                            text = const Text('Apr5', style: style);
                          case 8:
                            text = const Text('Apr7', style: style);
                          case 10:
                            text = const Text('Apr9', style: style);
                          case 12:
                            text = const Text('Apr11', style: style);
                          default:
                            text = const Text('', style: style);
                        }
                        return SideTitleWidget(meta: meta, child: text);
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5000,
                      reservedSize: 42,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '₹${(value / 1000).toInt()}K',
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.right,
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 13,
                minY: 75000,
                maxY: 125000,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 88000),
                      FlSpot(1, 92000),
                      FlSpot(2, 95000),
                      FlSpot(3, 78000),
                      FlSpot(4, 105000),
                      FlSpot(5, 112000),
                      FlSpot(6, 98000),
                      FlSpot(7, 87000),
                      FlSpot(8, 102000),
                      FlSpot(9, 115000),
                      FlSpot(10, 108000),
                      FlSpot(11, 120000),
                      FlSpot(12, 118000),
                      FlSpot(13, 124000),
                    ],
                    isCurved: true,
                    color: AppColors.success,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.success.withValues(alpha: 0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RevenueByServiceChart extends StatelessWidget {
  const RevenueByServiceChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.pie_chart_outline_rounded,
                size: 20,
                color: Colors.purple,
              ),
              SizedBox(width: 8),
              Text('Revenue by Service', style: AppTextStyles.titleSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 180,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(
                    color: AppColors.primary,
                    value: 35,
                    title: '35%',
                    radius: 30,
                    titleStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.purple,
                    value: 20,
                    title: '20%',
                    radius: 30,
                    titleStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: AppColors.success,
                    value: 15,
                    title: '15%',
                    radius: 30,
                    titleStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.orange,
                    value: 10,
                    title: '10%',
                    radius: 30,
                    titleStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.teal,
                    value: 12,
                    title: '12%',
                    radius: 30,
                    titleStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: AppColors.error,
                    value: 8,
                    title: '8%',
                    radius: 30,
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
          const SizedBox(height: AppSpacing.lg),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        _legendItem(AppColors.primary, 'Consultation'),
        _legendItem(Colors.purple, 'Lab/Path'),
        _legendItem(Colors.teal, 'Radiology'),
        _legendItem(AppColors.success, 'IPD/Bed'),
        _legendItem(Colors.orange, 'Pharmacy'),
        _legendItem(AppColors.error, 'Procedures'),
      ],
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 12, height: 4, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.primaryText,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class PaymentModesChart extends StatelessWidget {
  const PaymentModesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.bar_chart_rounded,
                size: 20,
                color: AppColors.secondaryAccent,
              ),
              SizedBox(width: 8),
              Text('Payment Modes', style: AppTextStyles.titleSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 50,
                barTouchData: const BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  bottomTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 60,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10,
                        );
                        var text = '';
                        switch (value.toInt()) {
                          case 0:
                            text = 'Cash';
                          case 1:
                            text = 'UPI';
                          case 2:
                            text = 'Card';
                          case 3:
                            text = 'NEFT';
                          case 4:
                            text = 'Cheque';
                          case 5:
                            text = 'Insurance';
                        }
                        return SideTitleWidget(
                          meta: meta,
                          space: 4,
                          child: Text(
                            text,
                            style: style,
                            textAlign: TextAlign.right,
                          ),
                        );
                      },
                      interval: 1,
                    ),
                  ),
                  rightTitles: const AxisTitles(),
                ),
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: 1,
                  drawHorizontalLine: false,
                  getDrawingVerticalLine: (value) => FlLine(
                    color: AppColors.border.withValues(alpha: 0.5),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _makeBarData(0, 38, AppColors.primary),
                  _makeBarData(1, 32, AppColors.success),
                  _makeBarData(2, 22, Colors.orange),
                  _makeBarData(3, 15, Colors.purple),
                  _makeBarData(4, 8, Colors.pink),
                  _makeBarData(5, 42, Colors.teal),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _makeBarData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 12,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
        ),
      ],
    );
  }
}
