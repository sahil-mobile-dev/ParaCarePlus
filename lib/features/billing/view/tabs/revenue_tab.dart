import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class RevenueTab extends StatelessWidget {
  const RevenueTab({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;

        return Column(
          children: [
            _buildTopMetrics(isWide),
            const SizedBox(height: AppSpacing.lg),
            if (isWide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: _buildRevenueBreakdownChart()),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(flex: 1, child: _buildDeptWiseTable()),
                ],
              )
            else
              Column(
                children: [
                  _buildRevenueBreakdownChart(),
                  const SizedBox(height: AppSpacing.lg),
                  _buildDeptWiseTable(),
                ],
              ),
          ],
        );
      },
    );
  }

  Widget _buildTopMetrics(bool isWide) {
    if (isWide) {
      return Row(
        children: [
          Expanded(
            child: _buildMetricCard(
              title: 'Monthly Revenue',
              value: '₹38.6L',
              subtitle: '↑ 8.4% vs last month',
              subtitleColor: AppColors.success,
              icon: Icons.currency_rupee_rounded,
              iconColor: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: _buildMetricCard(
              title: 'Annual (YTD)',
              value: '₹4,44,500',
              subtitle: 'Target: ₹5.4Cr',
              subtitleColor: AppColors.primary,
              icon: Icons.calendar_month_rounded,
              iconColor: Colors.purple,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: _buildMetricCard(
              title: 'Outstanding Dues',
              value: '₹2.1L',
              subtitle: '22 bills pending',
              subtitleColor: Colors.orange,
              icon: Icons.warning_amber_rounded,
              iconColor: Colors.orange,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          _buildMetricCard(
            title: 'Monthly Revenue',
            value: '₹38.6L',
            subtitle: '↑ 8.4% vs last month',
            subtitleColor: AppColors.success,
            icon: Icons.currency_rupee_rounded,
            iconColor: AppColors.primary,
          ),
          const SizedBox(height: AppSpacing.md),
          _buildMetricCard(
            title: 'Annual (YTD)',
            value: '₹4,44,500',
            subtitle: 'Target: ₹5.4Cr',
            subtitleColor: AppColors.primary,
            icon: Icons.calendar_month_rounded,
            iconColor: Colors.purple,
          ),
          const SizedBox(height: AppSpacing.md),
          _buildMetricCard(
            title: 'Outstanding Dues',
            value: '₹2.1L',
            subtitle: '22 bills pending',
            subtitleColor: Colors.orange,
            icon: Icons.warning_amber_rounded,
            iconColor: Colors.orange,
          ),
        ],
      );
    }
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required Color subtitleColor,
    required IconData icon,
    required Color iconColor,
  }) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(value, style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(
            subtitle,
            style: AppTextStyles.labelSmall.copyWith(
              color: subtitleColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueBreakdownChart() {
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
          Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Monthly Revenue Breakdown',
                    style: AppTextStyles.titleSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Text('April 2025', style: AppTextStyles.bodyMedium),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 20,
                          color: AppColors.secondaryText,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.download_rounded,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    tooltip: 'Download Report',
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxxl),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100,
                barTouchData: const BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10,
                        );
                        String text;
                        switch (value.toInt()) {
                          case 0:
                            text = 'W1';
                          case 1:
                            text = 'W2';
                          case 2:
                            text = 'W3';
                          case 3:
                            text = 'W4';
                          default:
                            text = '';
                        }
                        return SideTitleWidget(
                          meta: meta,
                          space: 8,
                          child: Text(text, style: style),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 42,
                      interval: 25,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          meta: meta,
                          space: 8,
                          child: Text(
                            '₹${value.toInt()}K',
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 25,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppColors.border.withValues(alpha: 0.5),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _createStackedBar(0, 30, 20, 10, 15),
                  _createStackedBar(1, 40, 25, 15, 20),
                  _createStackedBar(2, 35, 20, 12, 18),
                  _createStackedBar(3, 45, 30, 20, 25),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildChartLegend(),
        ],
      ),
    );
  }

  BarChartGroupData _createStackedBar(
    int x,
    double opd,
    double ipd,
    double radiology,
    double pharmacy,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: opd + ipd + radiology + pharmacy,
          width: 24,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
          rodStackItems: [
            BarChartRodStackItem(0, opd, AppColors.primary),
            BarChartRodStackItem(opd, opd + ipd, Colors.purple),
            BarChartRodStackItem(opd + ipd, opd + ipd + radiology, Colors.teal),
            BarChartRodStackItem(
              opd + ipd + radiology,
              opd + ipd + radiology + pharmacy,
              Colors.orange,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChartLegend() {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        _legendItem(AppColors.primary, 'OPD'),
        _legendItem(Colors.purple, 'IPD'),
        _legendItem(Colors.teal, 'Radiology'),
        _legendItem(Colors.orange, 'Pharmacy'),
      ],
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildDeptWiseTable() {
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
          const Text('Dept-wise Revenue', style: AppTextStyles.titleSmall),
          const SizedBox(height: AppSpacing.lg),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(6),
                ),
                children: [
                  _headerCell('Department'),
                  _headerCell('Revenue'),
                  _headerCell('%'),
                ],
              ),
              _buildDeptRow('General Medicine', '₹12.4L', '32%'),
              _buildDeptRow('Orthopedics', '₹8.2L', '21%'),
              _buildDeptRow('Cardiology', '₹6.5L', '17%'),
              _buildDeptRow('Pathology', '₹4.8L', '12%'),
              _buildDeptRow('Radiology', '₹3.9L', '10%'),
              _buildDeptRow('Others', '₹2.8L', '8%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        text,
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.secondaryText,
        ),
      ),
    );
  }

  TableRow _buildDeptRow(String dept, String revenue, String percentage) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Text(dept, style: AppTextStyles.bodyMedium),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Text(
            revenue,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Text(
            percentage,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
