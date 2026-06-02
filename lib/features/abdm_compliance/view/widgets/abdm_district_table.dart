import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/abdm_compliance/view_model/abdm_compliance_view_model.dart';

class AbdmDistrictTable extends ConsumerWidget {
  const AbdmDistrictTable({super.key});

  Color _getGradeBadgeBg(String grade) {
    if (grade == 'A') return AppColors.success.withValues(alpha: 0.12);
    if (grade == 'B') return AppColors.primaryLight.withValues(alpha: 0.12);
    if (grade == 'C') return AppColors.secondaryAccent.withValues(alpha: 0.12);
    return AppColors.error.withValues(alpha: 0.12);
  }

  Color _getGradeBadgeText(String grade) {
    if (grade == 'A') return AppColors.success;
    if (grade == 'B') return AppColors.primaryLight;
    if (grade == 'C') return AppColors.secondaryAccent;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(abdmComplianceProvider);
    final districts = state.districts;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0x11FFFFFF))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '🏆 District-wise ABDM Compliance Scorecard',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                // Sort Dropdown
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.border.withValues(alpha: 0.5),
                    ),
                  ),
                  height: 30,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: state.sortBy,
                      dropdownColor: AppColors.surface,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white70,
                        size: 18,
                      ),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                      items: [
                        'Score',
                        'District',
                        'ABHA',
                        'EMR',
                        'Consent',
                        'HIP',
                        'HIU',
                        'Uptime',
                        'ePresc',
                        'S&S',
                        'AB+ABDM'
                      ].map((val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text('Sort by $val'),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        if (newVal != null) {
                          ref
                              .read(abdmComplianceProvider.notifier)
                              .sortDistricts(newVal);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Scrollable Table Body
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 18,
              headingRowHeight: 38,
              dataRowMinHeight: 40,
              dataRowMaxHeight: 40,
              headingTextStyle: const TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                color: AppColors.secondaryText,
                letterSpacing: 0.4,
              ),
              columns: const [
                DataColumn(label: Text('#')),
                DataColumn(label: Text('DISTRICT')),
                DataColumn(label: Text('ABHA COV%')),
                DataColumn(label: Text('EMR LINK%')),
                DataColumn(label: Text('CONSENT%')),
                DataColumn(label: Text('HIPs')),
                DataColumn(label: Text('HIU TXNS')),
                DataColumn(label: Text('UPTIME%')),
                DataColumn(label: Text('ePRESC%')),
                DataColumn(label: Text('S&S%')),
                DataColumn(label: Text('AB+ABDM%')),
                DataColumn(label: Text('GRADE')),
                DataColumn(label: Text('SCORE')),
              ],
              rows: List.generate(districts.length, (idx) {
                final d = districts[idx];
                final badgeBg = _getGradeBadgeBg(d.grade);
                final badgeText = _getGradeBadgeText(d.grade);

                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        '${idx + 1}',
                        style: const TextStyle(
                          color: Colors.white30,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        d.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${d.abhaCoveragePercent.toStringAsFixed(1)}%',
                        style: const TextStyle(color: Colors.white70, fontSize: 11.5),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${d.emrLinkedPercent.toStringAsFixed(1)}%',
                        style: const TextStyle(color: Colors.white70, fontSize: 11.5),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${d.consentRatePercent.toStringAsFixed(1)}%',
                        style: const TextStyle(color: Colors.white70, fontSize: 11.5),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${d.hipFacilitiesCount}',
                        style: const TextStyle(color: Colors.white70, fontSize: 11.5),
                      ),
                    ),
                    DataCell(
                      Text(
                        d.hiuTxnsCount.toString().replaceAllMapped(
                              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},',
                            ),
                        style: const TextStyle(color: Colors.white70, fontSize: 11.5),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${d.apiUptimePercent.toStringAsFixed(1)}%',
                        style: TextStyle(
                          color: d.apiUptimePercent >= 98
                              ? AppColors.success
                              : (d.apiUptimePercent >= 95
                                  ? AppColors.secondaryAccent
                                  : AppColors.error),
                          fontWeight: FontWeight.bold,
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${d.ePrescriptionPercent.toStringAsFixed(1)}%',
                        style: const TextStyle(color: Colors.white70, fontSize: 11.5),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${d.scanAndSharePercent.toStringAsFixed(1)}%',
                        style: const TextStyle(color: Colors.white70, fontSize: 11.5),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${d.abAbdmPercent.toStringAsFixed(1)}%',
                        style: const TextStyle(color: Colors.white70, fontSize: 11.5),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 2.5,
                        ),
                        decoration: BoxDecoration(
                          color: badgeBg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          d.grade,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: badgeText,
                            fontFamily: AppTextStyles.fontFamily,
                          ),
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
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 60 * (d.score / 100),
                              height: 6,
                              decoration: BoxDecoration(
                                color: d.score >= 80
                                    ? AppColors.success
                                    : (d.score >= 70
                                        ? AppColors.primaryLight
                                        : (d.score >= 60
                                            ? AppColors.secondaryAccent
                                            : AppColors.error)),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${d.score}',
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
