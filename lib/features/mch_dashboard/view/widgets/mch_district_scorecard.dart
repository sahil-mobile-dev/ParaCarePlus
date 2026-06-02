import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/mch_dashboard/view_model/mch_dashboard_view_model.dart';

class MchDistrictScorecard extends ConsumerWidget {
  const MchDistrictScorecard({super.key});

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
          const Row(
            children: [
              Icon(Icons.assessment_rounded, color: Color(0xFFF72585), size: 16),
              SizedBox(width: 8),
              Text(
                'DISTRICT-WISE MCH PERFORMANCE METRICS',
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
                DataColumn(label: Text('District', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('MMR (/LB)', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('IMR (/1K)', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Inst. Del %', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('4+ ANC %', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Full Immun %', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('SAM Cases', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('JSY %', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Grade', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
              ],
              rows: state.scorecards.map((score) {
                final gradeColor = _getGradeColor(score.grade);
                final mmrColor = score.mmr <= 100 ? AppColors.success : (score.mmr <= 150 ? AppColors.secondaryAccent : AppColors.error);
                final imrColor = score.imr <= 25 ? AppColors.success : (score.imr <= 35 ? AppColors.secondaryAccent : AppColors.error);

                return DataRow(
                  cells: [
                    DataCell(Text(score.district, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))),
                    DataCell(Text(score.mmr.toString(), style: TextStyle(color: mmrColor, fontSize: 11, fontWeight: FontWeight.bold))),
                    DataCell(Text(score.imr.toString(), style: TextStyle(color: imrColor, fontSize: 11))),
                    DataCell(Text('${score.instDel}%', style: const TextStyle(color: Colors.white70, fontSize: 11))),
                    DataCell(Text('${score.anc4}%', style: const TextStyle(color: Colors.white70, fontSize: 11))),
                    DataCell(Text('${score.fullImmun}%', style: const TextStyle(color: Colors.white70, fontSize: 11))),
                    DataCell(Text(score.sam.toString(), style: const TextStyle(color: Colors.white70, fontSize: 11))),
                    DataCell(Text('${score.jsy}%', style: const TextStyle(color: Colors.white70, fontSize: 11))),
                    DataCell(
                      Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: gradeColor.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                          border: Border.all(color: gradeColor.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          score.grade,
                          style: TextStyle(
                            color: gradeColor,
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
