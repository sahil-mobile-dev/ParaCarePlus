import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/model/dashboard_models.dart';

class CriticalPatientsTable extends StatelessWidget {
  final List<CriticalPatient> patients;

  const CriticalPatientsTable({super.key, required this.patients});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.monitor_heart_rounded,
                    color: AppColors.error,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Text('Critical Patients', style: AppTextStyles.titleSmall),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text('View All', style: AppTextStyles.labelSmall),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 24,
              headingRowHeight: 40,
              dataRowHeight: 56,
              headingRowColor: WidgetStateProperty.all(AppColors.background),
              columns: const [
                DataColumn(
                  label: Text('PATIENT', style: AppTextStyles.labelSmall),
                ),
                DataColumn(
                  label: Text('WARD', style: AppTextStyles.labelSmall),
                ),
                DataColumn(
                  label: Text('CONDITION', style: AppTextStyles.labelSmall),
                ),
                DataColumn(
                  label: Text('ASSIGNED TO', style: AppTextStyles.labelSmall),
                ),
                DataColumn(
                  label: Text('ACTION', style: AppTextStyles.labelSmall),
                ),
              ],
              rows: patients.map((p) => _buildRow(p)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(CriticalPatient p) {
    return DataRow(
      cells: [
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                p.name,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                p.id,
                style: AppTextStyles.labelSmall.copyWith(fontSize: 10),
              ),
            ],
          ),
        ),
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(p.ward, style: AppTextStyles.bodySmall),
              Text(
                p.bed,
                style: AppTextStyles.labelSmall.copyWith(fontSize: 9),
              ),
            ],
          ),
        ),
        DataCell(
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: p.severity == PatientSeverity.critical
                      ? AppColors.error
                      : AppColors.secondaryAccent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(p.condition, style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        DataCell(Text(p.assignedTo, style: AppTextStyles.bodySmall)),
        DataCell(
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              foregroundColor: AppColors.primary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              minimumSize: Size.zero,
            ),
            child: const Text('View', style: TextStyle(fontSize: 12)),
          ),
        ),
      ],
    );
  }
}
