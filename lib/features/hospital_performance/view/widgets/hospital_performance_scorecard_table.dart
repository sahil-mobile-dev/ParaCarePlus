import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/hospital_performance/view_model/hospital_performance_view_model.dart';

class HospitalPerformanceScorecardTable extends ConsumerWidget {
  const HospitalPerformanceScorecardTable({super.key});

  Color _getGradeColor(String grade) {
    if (grade == 'A') return AppColors.success;
    if (grade == 'B') return AppColors.primaryLight;
    if (grade == 'C') return AppColors.secondaryAccent;
    return AppColors.error;
  }

  Color _getOccupancyColor(int occ) {
    if (occ >= 100) return AppColors.error;
    if (occ >= 85) return AppColors.secondaryAccent;
    return AppColors.success;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hospitalPerformanceProvider);
    final notifier = ref.read(hospitalPerformanceProvider.notifier);

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
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: const Text(
                  'Hospital Performance Scorecard',
                  style: AppTextStyles.titleMedium,
                ),
              ),
              DropdownButton<String>(
                value: state.sortBy,
                dropdownColor: AppColors.surface,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                underline: const SizedBox(),
                items:
                    [
                      'Hospital',
                      'Beds',
                      'Occupancy',
                      'OPD',
                      'Surgeries',
                      'CSAT',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('Sort by: $value'),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    notifier.sortScorecard(newValue);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'Comparative analysis across major reporting medical centers and district hospitals',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
          ),
          const SizedBox(height: AppSpacing.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(AppColors.surface),
              dataRowMinHeight: 38,
              dataRowMaxHeight: 44,
              horizontalMargin: 12,
              columnSpacing: 16,
              columns: const [
                DataColumn(
                  label: Text(
                    'Hospital',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.5,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Type',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.5,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Beds',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.5,
                    ),
                  ),
                  numeric: true,
                ),
                DataColumn(
                  label: Text(
                    'Occupancy%',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.5,
                    ),
                  ),
                  numeric: true,
                ),
                DataColumn(
                  label: Text(
                    'OPD/Day',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.5,
                    ),
                  ),
                  numeric: true,
                ),
                DataColumn(
                  label: Text(
                    'Surgeries/Mo',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.5,
                    ),
                  ),
                  numeric: true,
                ),
                DataColumn(
                  label: Text(
                    'AvgLOS(d)',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.5,
                    ),
                  ),
                  numeric: true,
                ),
                DataColumn(
                  label: Text(
                    'CSAT',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.5,
                    ),
                  ),
                  numeric: true,
                ),
                DataColumn(
                  label: Text(
                    'Readmit%',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.5,
                    ),
                  ),
                  numeric: true,
                ),
                DataColumn(
                  label: Text(
                    'Equip%',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.5,
                    ),
                  ),
                  numeric: true,
                ),
                DataColumn(
                  label: Text(
                    'NABH',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.5,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Grade',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.5,
                    ),
                  ),
                ),
              ],
              rows: state.scorecardItems.map((item) {
                final gradeColor = _getGradeColor(item.grade);
                final occupancyColor = _getOccupancyColor(
                  item.occupancyPercent,
                );

                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        item.type,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10.5,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        item.beds.toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${item.occupancyPercent}%',
                        style: TextStyle(
                          color: occupancyColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        item.opdPerDay.toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        item.surgeriesPerMonth.toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        item.avgLos.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        item.csat.toStringAsFixed(1),
                        style: TextStyle(
                          color: item.csat >= 4.2
                              ? AppColors.success
                              : (item.csat >= 3.7
                                    ? AppColors.secondaryAccent
                                    : AppColors.error),
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${item.readmissionPercent}%',
                        style: TextStyle(
                          color: item.readmissionPercent <= 4.0
                              ? AppColors.success
                              : (item.readmissionPercent <= 5.0
                                    ? AppColors.secondaryAccent
                                    : AppColors.error),
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${item.equipmentUptimePercent}%',
                        style: TextStyle(
                          color: item.equipmentUptimePercent >= 90
                              ? AppColors.success
                              : (item.equipmentUptimePercent >= 75
                                    ? AppColors.secondaryAccent
                                    : AppColors.error),
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      item.nabhAccredited
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.success.withValues(
                                  alpha: 0.15,
                                ),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: AppColors.success.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                              ),
                              child: const Text(
                                '✔ NABH',
                                style: TextStyle(
                                  color: AppColors.success,
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : const Text(
                              '—',
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 11,
                              ),
                            ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: gradeColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: gradeColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          'Grade ${item.grade}',
                          style: TextStyle(
                            color: gradeColor,
                            fontSize: 9.5,
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
    );
  }
}
