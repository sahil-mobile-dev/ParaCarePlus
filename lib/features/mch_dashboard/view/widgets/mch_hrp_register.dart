import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/mch_dashboard/view_model/mch_dashboard_view_model.dart';

class MchHrpRegister extends ConsumerWidget {
  const MchHrpRegister({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mchDashboardProvider);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.warning_rounded, color: AppColors.error, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'HIGH-RISK PREGNANCY REGISTER — ACTIVE CASES',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: AppColors.secondaryText,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowHeight: 34,
              dataRowMinHeight: 34,
              dataRowMaxHeight: 42,
              horizontalMargin: 8,
              columnSpacing: 24,
              columns: const [
                DataColumn(
                  label: Text(
                    'Patient Name',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Age',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Gestational Weeks',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Risk Factors',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'District',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Facility',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Status',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              rows: state.hrpRegister.map((patient) {
                final isCrit =
                    patient.status.contains('CRITICAL') ||
                    patient.status.contains('IMMEDIATE');
                final statusColor = isCrit
                    ? AppColors.error
                    : AppColors.secondaryAccent;

                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        patient.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        patient.age.toString(),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${patient.weeks} wks',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        patient.riskFactor,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        patient.district,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        patient.facility,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: statusColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          patient.status,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 9,
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
