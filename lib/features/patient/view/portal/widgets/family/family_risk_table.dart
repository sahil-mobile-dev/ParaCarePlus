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
        'name': 'Ramesh',
        'age': '48M',
        'wellness': '78/100',
        'wellnessColor': AppColors.secondaryAccent,
        'cvRisk': 0.42,
        'cvRiskColor': Colors.orange,
        'dbRisk': 0.68,
        'dbRiskColor': AppColors.error,
        'htn': 'Stage 1',
        'htnColor': AppColors.secondaryAccent,
        'cancer': 'Done 2026',
        'cancerColor': AppColors.success,
        'due': 'Jun 2026',
        'dueColor': AppColors.secondaryAccent,
      },
      {
        'name': 'Geeta',
        'age': '46F',
        'wellness': '84/100',
        'wellnessColor': AppColors.success,
        'cvRisk': 0.22,
        'cvRiskColor': AppColors.success,
        'dbRisk': 0.30,
        'dbRiskColor': AppColors.secondaryAccent,
        'htn': 'Normal',
        'htnColor': AppColors.success,
        'cancer': 'Done 2026',
        'cancerColor': AppColors.success,
        'due': 'Feb 2027',
        'dueColor': AppColors.success,
      },
      {
        'name': 'Aryan',
        'age': '22M',
        'wellness': '92/100',
        'wellnessColor': AppColors.success,
        'cvRisk': 0.05,
        'cvRiskColor': AppColors.success,
        'dbRisk': 0.15,
        'dbRiskColor': AppColors.success,
        'htn': 'Normal',
        'htnColor': AppColors.success,
        'cancer': 'N/A at age',
        'cancerColor': AppColors.secondaryText,
        'due': 'Annual 2027',
        'dueColor': AppColors.success,
      },
      {
        'name': 'Priya',
        'age': '18F',
        'wellness': '88/100',
        'wellnessColor': AppColors.primaryLight,
        'cvRisk': 0.04,
        'cvRiskColor': AppColors.success,
        'dbRisk': 0.18,
        'dbRiskColor': AppColors.success,
        'htn': 'Normal',
        'htnColor': AppColors.success,
        'cancer': 'N/A at age',
        'cancerColor': AppColors.secondaryText,
        'due': 'Dental May 2026',
        'dueColor': AppColors.secondaryAccent,
      },
      {
        'name': 'Savitri',
        'age': '74F',
        'wellness': '68/100',
        'wellnessColor': AppColors.secondaryAccent,
        'cvRisk': 0.72,
        'cvRiskColor': AppColors.error,
        'dbRisk': 0.80,
        'dbRiskColor': AppColors.error,
        'htn': 'Stage 2',
        'htnColor': AppColors.error,
        'cancer': 'Due 2026',
        'cancerColor': AppColors.secondaryAccent,
        'due': 'Urgent consult',
        'dueColor': AppColors.error,
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
            Text('FAMILY RISK OVERVIEW', style: AppTextStyles.labelSmall),
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
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: DataTable(
              horizontalMargin: 16,
              columnSpacing: 20,
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
                    'AGE',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'WELLNESS',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'CV RISK',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'DIABETES RISK',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'HYPERTENSION',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'CANCER SCREEN',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'NEXT DUE',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              rows: records.map((r) {
                final cvRisk = r['cvRisk'] as double;
                final dbRisk = r['dbRisk'] as double;

                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        r['name'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        r['age'] as String,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        r['wellness'] as String,
                        style: TextStyle(
                          color: r['wellnessColor'] as Color,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 60,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 60 * cvRisk,
                              height: 6,
                              decoration: BoxDecoration(
                                color: r['cvRiskColor'] as Color,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${(cvRisk * 100).toInt()}%',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 60,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 60 * dbRisk,
                              height: 6,
                              decoration: BoxDecoration(
                                color: r['dbRiskColor'] as Color,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${(dbRisk * 100).toInt()}%',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Text(
                        r['htn'] as String,
                        style: TextStyle(
                          color: r['htnColor'] as Color,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        r['cancer'] as String,
                        style: TextStyle(
                          color: r['cancerColor'] as Color,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        r['due'] as String,
                        style: TextStyle(
                          color: r['dueColor'] as Color,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
