import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/state_admin/view_model/state_admin_view_model.dart';

class StateAdminDistrictTable extends ConsumerWidget {
  const StateAdminDistrictTable({super.key});

  Color _getPerformanceColor(String perf) {
    switch (perf) {
      case 'Good':
        return AppColors.success;
      case 'Average':
        return const Color(0xFFFFD166);
      case 'Critical':
        return AppColors.error;
      default:
        return AppColors.secondaryText;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final districts = ref.watch(stateAdminProvider.select((s) => s.districts));
    final currentSort = ref.watch(stateAdminProvider.select((s) => s.sortBy));

    Widget buildSortableHeader(String label, String sortKey) {
      final isSorted = currentSort == sortKey;
      return InkWell(
        onTap: () => ref.read(stateAdminProvider.notifier).sortDistricts(sortKey),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: _headerStyle),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_downward,
              size: 10,
              color: isSorted ? AppColors.primaryLight : Colors.white30,
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0x11FFFFFF))),
            ),
            child: const Row(
              children: [
                Text('🏛️', style: TextStyle(fontSize: 16)),
                SizedBox(width: 8),
                Text(
                  'District Scorecard Matrix — Live Ranks',
                  style: AppTextStyles.labelLarge,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(
                Colors.white.withValues(alpha: 0.02),
              ),
              columnSpacing: 24,
              horizontalMargin: 16,
              columns: [
                const DataColumn(label: Text('District', style: _headerStyle)),
                const DataColumn(label: Text('Facilities', style: _headerStyle)),
                DataColumn(label: buildSortableHeader('OPD / Day', 'OPD')),
                const DataColumn(label: Text('Bed Occ %', style: _headerStyle)),
                DataColumn(label: buildSortableHeader('MMR', 'MMR')),
                DataColumn(label: buildSortableHeader('AB Claims', 'AB Claims')),
                DataColumn(label: buildSortableHeader('Score', 'Score')),
                const DataColumn(label: Text('Grade', style: _headerStyle)),
              ],
              rows: List.generate(districts.length, (idx) {
                final d = districts[idx];
                final perfCol = _getPerformanceColor(d.performance);

                return DataRow(
                  cells: [
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
                    DataCell(Text('${d.facilitiesCount}', style: _cellStyle)),
                    DataCell(
                      Text(
                        '${d.dailyOpd}',
                        style: const TextStyle(
                          color: Color(0xFF60A5FA),
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${d.bedOccupancyPercent}%',
                        style: TextStyle(
                          color: d.bedOccupancyPercent > 85 ? AppColors.error : Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${d.mmr}',
                        style: TextStyle(
                          color: d.mmr > 90 ? AppColors.error : AppColors.success,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(Text('${d.abClaimsCount}', style: _cellStyle)),
                    DataCell(
                      Text(
                        '${d.score}',
                        style: const TextStyle(
                          color: Color(0xFFFFCA28),
                          fontWeight: FontWeight.bold,
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: perfCol.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: perfCol.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          d.performance.toUpperCase(),
                          style: TextStyle(
                            color: perfCol,
                            fontWeight: FontWeight.w800,
                            fontSize: 8.5,
                            letterSpacing: 0.3,
                          ),
                        ),
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

const TextStyle _headerStyle = TextStyle(
  color: AppColors.secondaryText,
  fontWeight: FontWeight.bold,
  fontSize: 10,
  letterSpacing: 0.5,
  fontFamily: AppTextStyles.fontFamily,
);

const TextStyle _cellStyle = TextStyle(
  color: Colors.white70,
  fontSize: 11.5,
  fontFamily: AppTextStyles.fontFamily,
);
