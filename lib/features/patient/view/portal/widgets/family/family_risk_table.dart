import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class FamilyRiskTable extends StatelessWidget {
  const FamilyRiskTable({super.key});

  @override
  Widget build(BuildContext context) {
    final records = <Map<String, dynamic>>[
      {
        'name': 'Ramesh Kumar',
        'relation': 'Self (48M)',
        'bp': '138/88',
        'sugar': '112 mg/dL',
        'hba1c': '6.1%',
        'cardiac': 'Moderate',
        'priority': 'Medium',
        'priorityColor': AppColors.secondaryAccent,
      },
      {
        'name': 'Geeta Kumar',
        'relation': 'Spouse (44F)',
        'bp': '118/76',
        'sugar': '94 mg/dL',
        'hba1c': '5.2%',
        'cardiac': 'Low',
        'priority': 'Normal',
        'priorityColor': AppColors.success,
      },
      {
        'name': 'Savitri Devi',
        'relation': 'Mother (72F)',
        'bp': '152/94',
        'sugar': '145 mg/dL',
        'hba1c': '7.4%',
        'cardiac': 'High Risk',
        'priority': 'Critical',
        'priorityColor': AppColors.error,
      },
      {
        'name': 'Aryan Kumar',
        'relation': 'Son (14M)',
        'bp': '110/70',
        'sugar': '88 mg/dL',
        'hba1c': '4.8%',
        'cardiac': 'Optimal',
        'priority': 'Normal',
        'priorityColor': AppColors.success,
      },
      {
        'name': 'Priya Kumar',
        'relation': 'Daughter (10F)',
        'bp': '106/68',
        'sugar': '85 mg/dL',
        'hba1c': '4.7%',
        'cardiac': 'Optimal',
        'priority': 'Normal',
        'priorityColor': AppColors.success,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Row(
          children: [
            Icon(
              Icons.table_chart_rounded,
              color: AppColors.primaryLight,
              size: 18,
            ),
            SizedBox(width: 8),
            Text('CLINICAL TELEMETRY MATRIX', style: AppTextStyles.labelSmall),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Horizontal Scrollable Table Wrapper
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: DataTable(
                  horizontalMargin: 16,
                  columnSpacing: 24,
                  headingRowColor: WidgetStateProperty.all(AppColors.surface),
                  headingRowHeight: 40,
                  dataRowMinHeight: 48,
                  dataRowMaxHeight: 48,
                  columns: const [
                    DataColumn(
                      label: Text(
                        'MEMBER',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'RELATION',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'SYS/DIA BP',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'FAST SUGAR',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'HBA1C',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'CARDIAC VECTOR',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'PRIORITY',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  rows: records.map((r) {
                    final isCritical = r['priority'] == 'Critical';

                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            r['name'] as String,
                            style: TextStyle(
                              color: isCritical
                                  ? AppColors.error
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.5,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            r['relation'] as String,
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            r['bp'] as String,
                            style: TextStyle(
                              color: (isCritical || r['bp'] == '138/88')
                                  ? AppColors.secondaryAccent
                                  : Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            r['sugar'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            r['hba1c'] as String,
                            style: TextStyle(
                              color: isCritical
                                  ? AppColors.error
                                  : Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            r['cardiac'] as String,
                            style: TextStyle(
                              color: isCritical
                                  ? AppColors.error
                                  : Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: (r['priorityColor'] as Color).withValues(
                                alpha: 0.15,
                              ),
                              border: Border.all(
                                color: r['priorityColor'] as Color,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              (r['priority'] as String).toUpperCase(),
                              style: TextStyle(
                                color: r['priorityColor'] as Color,
                                fontSize: 8.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
