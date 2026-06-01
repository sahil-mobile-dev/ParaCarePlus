import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/state_command/view_model/state_command_view_model.dart';

class StateCommandDistrictTable extends ConsumerWidget {
  const StateCommandDistrictTable({super.key});

  Color _getPerformanceBadgeBg(String perf) {
    if (perf == 'Good') return AppColors.success.withValues(alpha: 0.12);
    if (perf == 'Average') return AppColors.secondaryAccent.withValues(alpha: 0.12);
    return AppColors.error.withValues(alpha: 0.12);
  }

  Color _getPerformanceBadgeText(String perf) {
    if (perf == 'Good') return AppColors.success;
    if (perf == 'Average') return AppColors.secondaryAccent;
    return AppColors.error;
  }

  Color _getOccColor(int pct) {
    if (pct > 90) return AppColors.error;
    if (pct > 80) return AppColors.secondaryAccent;
    return AppColors.success;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commandState = ref.watch(stateCommandProvider);
    final districts = commandState.districts;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.4),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0x11FFFFFF)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '🏆 District Health Performance Scorecard',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
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
                      value: commandState.sortBy,
                      dropdownColor: AppColors.surface,
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.white70, size: 18),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                      items: ['Score', 'OPD', 'AB Claims', 'MMR'].map((val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text('Sort by $val'),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        if (newVal != null) {
                          ref.read(stateCommandProvider.notifier).sortDistricts(newVal);
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
              columnSpacing: 22,
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
                DataColumn(label: Text('FACILITIES')),
                DataColumn(label: Text('OPD/DAY')),
                DataColumn(label: Text('BED OCC%')),
                DataColumn(label: Text('ICU OCC%')),
                DataColumn(label: Text('MMR')),
                DataColumn(label: Text('AB CLAIMS')),
                DataColumn(label: Text('MED AVAIL')),
                DataColumn(label: Text('PERFORMANCE')),
                DataColumn(label: Text('SCORE')),
              ],
              rows: List.generate(districts.length, (idx) {
                final d = districts[idx];
                final badgeBg = _getPerformanceBadgeBg(d.performance);
                final badgeText = _getPerformanceBadgeText(d.performance);

                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        '${idx + 1}',
                        style: const TextStyle(color: Colors.white30, fontSize: 11),
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
                        '${d.facilitiesCount}',
                        style: const TextStyle(color: Colors.white70, fontSize: 11.5),
                      ),
                    ),
                    DataCell(
                      Text(
                        d.dailyOpd.toString().replaceAllMapped(
                              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},',
                            ),
                        style: const TextStyle(color: Colors.white70, fontSize: 11.5),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${d.bedOccupancyPercent}%',
                        style: TextStyle(
                          color: _getOccColor(d.bedOccupancyPercent),
                          fontWeight: FontWeight.bold,
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${d.icuOccupancyPercent}%',
                        style: TextStyle(
                          color: _getOccColor(d.icuOccupancyPercent),
                          fontWeight: FontWeight.bold,
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${d.mmr}',
                        style: const TextStyle(color: Colors.white70, fontSize: 11.5),
                      ),
                    ),
                    DataCell(
                      Text(
                        d.abClaimsCount.toString().replaceAllMapped(
                              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},',
                            ),
                        style: const TextStyle(color: Colors.white70, fontSize: 11.5),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${d.medicineAvailabilityPercent}%',
                        style: const TextStyle(color: Colors.white70, fontSize: 11.5),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: badgeBg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          d.performance,
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
                            width: 80,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 80 * (d.score / 100),
                              height: 6,
                              decoration: BoxDecoration(
                                color: d.score > 70
                                    ? AppColors.success
                                    : (d.score > 55
                                        ? AppColors.secondaryAccent
                                        : AppColors.error),
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
