import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/radiology_imaging/view_model/radiology_imaging_view_model.dart';

class RadiologyAiFindingsTab extends ConsumerWidget {
  const RadiologyAiFindingsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(radiologyImagingProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        final aiContent = [
          // AI Findings
          Expanded(
            flex: isWide ? 1 : 0,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(
                  color: AppColors.border.withValues(alpha: 0.4),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.psychology_rounded,
                        color: Color(0xFFC77DFF),
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'AI-ASSISTED DIAGNOSIS FINDINGS',
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
                  ...state.aiFindings.map((finding) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.15),
                        border: Border.all(
                          color: AppColors.border.withValues(alpha: 0.2),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                finding.patient,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${finding.confidence}% Conf.',
                                style: const TextStyle(
                                  color: AppColors.success,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            finding.study,
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            finding.finding,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          if (isWide) const SizedBox(width: 14) else const SizedBox(height: 14),
          // AI Audit Log
          Expanded(
            flex: isWide ? 1 : 0,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(
                  color: AppColors.border.withValues(alpha: 0.4),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.history_toggle_off_rounded,
                        color: AppColors.primaryLight,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'AI ENGINE AUDIT LOG',
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
                      dataRowMinHeight: 32,
                      dataRowMaxHeight: 38,
                      horizontalMargin: 8,
                      columnSpacing: 14,
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Patient',
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Study',
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Finding',
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
                      rows: state.aiFindings.map((finding) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                finding.patient,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                finding.study,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                finding.finding,
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 10,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.success.withValues(
                                    alpha: 0.15,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  finding.status,
                                  style: const TextStyle(
                                    color: AppColors.success,
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
            ),
          ),
        ];

        return isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: aiContent,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: aiContent,
              );
      },
    );
  }
}
