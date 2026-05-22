import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AnalyticsReferenceTable extends StatelessWidget {
  const AnalyticsReferenceTable({super.key});

  @override
  Widget build(BuildContext context) {
    final rows = _getRefRows();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.table_rows_rounded,
                color: AppColors.primaryLight,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Health Parameter Reference Ranges',
                style: AppTextStyles.labelLarge.copyWith(fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 24,
              horizontalMargin: 4,
              headingRowHeight: 36,
              dataRowMinHeight: 36,
              dataRowMaxHeight: 44,
              columns: const [
                DataColumn(
                  label: Text('Parameter', style: AppTextStyles.labelSmall),
                ),
                DataColumn(
                  label: Text('Current Value', style: AppTextStyles.labelSmall),
                ),
                DataColumn(
                  label: Text('Normal Range', style: AppTextStyles.labelSmall),
                ),
                DataColumn(
                  label: Text('Status', style: AppTextStyles.labelSmall),
                ),
                DataColumn(
                  label: Text('Last Checked', style: AppTextStyles.labelSmall),
                ),
                DataColumn(
                  label: Text('Trend', style: AppTextStyles.labelSmall),
                ),
              ],
              rows: rows.map((r) {
                final statusColor = r.statusColor;
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        r.parameter,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        r.current,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(r.normalRange, style: AppTextStyles.bodySmall),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: statusColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          r.status,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(r.lastChecked, style: AppTextStyles.bodySmall),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            r.trend.contains('▲')
                                ? Icons.arrow_drop_up_rounded
                                : r.trend.contains('▼')
                                ? Icons.arrow_drop_down_rounded
                                : Icons.remove_rounded,
                            color: r.trendColor,
                            size: 14,
                          ),
                          Text(
                            r.trend,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: r.trendColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<_RefRow> _getRefRows() {
    return [
      _RefRow(
        parameter: 'BMI',
        current: '26.2 kg/m²',
        normalRange: '18.5 – 24.9',
        status: 'Overweight',
        statusColor: AppColors.secondaryAccent,
        lastChecked: '12 May 2026',
        trend: '▲ +0.3',
        trendColor: AppColors.secondaryAccent,
      ),
      _RefRow(
        parameter: 'Systolic BP',
        current: '128 mmHg',
        normalRange: '90 – 120',
        status: 'Elevated',
        statusColor: AppColors.secondaryAccent,
        lastChecked: '13 May 2026',
        trend: '▲ +3',
        trendColor: AppColors.secondaryAccent,
      ),
      _RefRow(
        parameter: 'Diastolic BP',
        current: '82 mmHg',
        normalRange: '60 – 80',
        status: 'Elevated',
        statusColor: AppColors.secondaryAccent,
        lastChecked: '13 May 2026',
        trend: 'Stable',
        trendColor: AppColors.secondaryAccent,
      ),
      _RefRow(
        parameter: 'Fasting Glucose',
        current: '142 mg/dL',
        normalRange: '70 – 99',
        status: 'Pre-Diabetic',
        statusColor: AppColors.error,
        lastChecked: '10 May 2026',
        trend: '▲ +8',
        trendColor: AppColors.error,
      ),
      _RefRow(
        parameter: 'HbA1c',
        current: '6.2%',
        normalRange: '< 5.7%',
        status: 'Borderline',
        statusColor: AppColors.error,
        lastChecked: '01 May 2026',
        trend: '▲ +0.2',
        trendColor: AppColors.error,
      ),
      _RefRow(
        parameter: 'Total Cholesterol',
        current: '218 mg/dL',
        normalRange: '< 200',
        status: 'Borderline High',
        statusColor: AppColors.secondaryAccent,
        lastChecked: '01 May 2026',
        trend: '▲ +12',
        trendColor: AppColors.secondaryAccent,
      ),
      _RefRow(
        parameter: 'LDL Cholesterol',
        current: '138 mg/dL',
        normalRange: '< 100',
        status: 'High',
        statusColor: AppColors.error,
        lastChecked: '01 May 2026',
        trend: '▲ +9',
        trendColor: AppColors.error,
      ),
      _RefRow(
        parameter: 'HDL Cholesterol',
        current: '42 mg/dL',
        normalRange: '> 40',
        status: 'Normal',
        statusColor: AppColors.success,
        lastChecked: '01 May 2026',
        trend: 'Stable',
        trendColor: AppColors.success,
      ),
      _RefRow(
        parameter: 'SpO₂',
        current: '98%',
        normalRange: '95 – 100%',
        status: 'Normal',
        statusColor: AppColors.success,
        lastChecked: '13 May 2026',
        trend: 'Stable',
        trendColor: AppColors.success,
      ),
      _RefRow(
        parameter: 'Resting Heart Rate',
        current: '76 bpm',
        normalRange: '60 – 100',
        status: 'Normal',
        statusColor: AppColors.success,
        lastChecked: '13 May 2026',
        trend: '▼ -2',
        trendColor: AppColors.success,
      ),
    ];
  }
}

class _RefRow {
  _RefRow({
    required this.parameter,
    required this.current,
    required this.normalRange,
    required this.status,
    required this.statusColor,
    required this.lastChecked,
    required this.trend,
    required this.trendColor,
  });

  final String parameter;
  final String current;
  final String normalRange;
  final String status;
  final Color statusColor;
  final String lastChecked;
  final String trend;
  final Color trendColor;
}
