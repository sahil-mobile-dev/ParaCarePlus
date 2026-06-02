import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/ipd_beds/view_model/ipd_beds_view_model.dart';

class IpdScorecardTable extends ConsumerWidget {
  const IpdScorecardTable({super.key});

  Color _getGradeColor(String grade) {
    switch (grade.toUpperCase()) {
      case 'A':
        return AppColors.success;
      case 'B':
        return AppColors.primaryLight;
      case 'C':
        return AppColors.secondaryAccent;
      case 'D':
      default:
        return AppColors.error;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ipdBedsProvider);

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
          const Row(
            children: [
              Icon(Icons.assessment_rounded, color: AppColors.success, size: 16),
              SizedBox(width: 8),
              Text(
                'DISTRICT HOSPITAL BED & ER PERFORMANCE SCORECARD',
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
          const SizedBox(height: AppSpacing.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowHeight: 34,
              dataRowMinHeight: 34,
              dataRowMaxHeight: 40,
              horizontalMargin: 8,
              columnSpacing: 24,
              columns: const [
                DataColumn(label: Text('Facility Name', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('District', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Total Beds', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Occupancy %', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Daily Admissions', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Daily Discharges', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Grade', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
              ],
              rows: state.scorecards.map((score) {
                final color = _getGradeColor(score.grade);
                return DataRow(
                  cells: [
                    DataCell(Text(score.name, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))),
                    DataCell(Text(score.district, style: const TextStyle(color: Colors.white70, fontSize: 11))),
                    DataCell(Text(score.beds.toString(), style: const TextStyle(color: Colors.white70, fontSize: 11))),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 60,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: LinearProgressIndicator(
                                value: score.occupancyPercent / 100,
                                minHeight: 6,
                                backgroundColor: Colors.white.withValues(alpha: 0.07),
                                valueColor: AlwaysStoppedAnimation<Color>(color),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text('${score.occupancyPercent}%', style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    DataCell(Text(score.admissions.toString(), style: const TextStyle(color: Colors.white70, fontSize: 11))),
                    DataCell(Text(score.discharges.toString(), style: const TextStyle(color: Colors.white70, fontSize: 11))),
                    DataCell(
                      Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                          border: Border.all(color: color.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          score.grade,
                          style: TextStyle(
                            color: color,
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppTextStyles.fontFamily,
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
