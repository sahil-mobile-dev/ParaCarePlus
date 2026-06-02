import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/opd_analytics/view_model/opd_analytics_view_model.dart';

class OpdAnalyticsDoctorTable extends ConsumerWidget {
  const OpdAnalyticsDoctorTable({super.key});

  Color _getCSATColor(double csat) {
    if (csat >= 4.4) return AppColors.success;
    if (csat >= 4.0) return Colors.tealAccent;
    if (csat >= 3.7) return AppColors.secondaryAccent;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(opdAnalyticsProvider);
    final notifier = ref.read(opdAnalyticsProvider.notifier);

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
              const Text(
                'Doctor OPD Performance Scorecard — Today',
                style: AppTextStyles.titleMedium,
              ),
              DropdownButton<String>(
                value: state.sortBy,
                dropdownColor: AppColors.surface,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                underline: const SizedBox(),
                items: ['Doctor', 'Seen', 'ConsultTime', 'ABHA', 'CSAT']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text('Sort by: $value'),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    notifier.sortDoctorPerformance(newValue);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'Daily workload, digital compliance, and patient satisfaction metrics per active consulting specialist',
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
              columnSpacing: 18,
              columns: const [
                DataColumn(label: Text('Doctor', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.bold, fontSize: 10.5))),
                DataColumn(label: Text('Specialty', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.bold, fontSize: 10.5))),
                DataColumn(label: Text('Patients Seen', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.bold, fontSize: 10.5)), numeric: true),
                DataColumn(label: Text('Target', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.bold, fontSize: 10.5)), numeric: true),
                DataColumn(label: Text('% Achievement', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.bold, fontSize: 10.5))),
                DataColumn(label: Text('Avg Consult (min)', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.bold, fontSize: 10.5)), numeric: true),
                DataColumn(label: Text('ABHA Scan %', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.bold, fontSize: 10.5)), numeric: true),
                DataColumn(label: Text('ePrescription %', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.bold, fontSize: 10.5)), numeric: true),
                DataColumn(label: Text('CSAT', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.bold, fontSize: 10.5)), numeric: true),
                DataColumn(label: Text('Status', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.bold, fontSize: 10.5))),
              ],
              rows: state.doctorPerformance.map((item) {
                final pct = (item.patientsSeen / item.target * 100).round();
                final pctColor = pct >= 100 ? AppColors.success : (pct >= 90 ? AppColors.secondaryAccent : AppColors.error);
                final csatColor = _getCSATColor(item.csat);

                return DataRow(
                  cells: [
                    DataCell(Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white))),
                    DataCell(Text(item.specialty, style: const TextStyle(color: AppColors.secondaryText, fontSize: 10.5))),
                    DataCell(Text(item.patientsSeen.toString(), style: const TextStyle(fontSize: 11, color: Colors.white))),
                    DataCell(Text(item.target.toString(), style: const TextStyle(fontSize: 11, color: Colors.white))),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('$pct%', style: TextStyle(color: pctColor, fontWeight: FontWeight.bold, fontSize: 11)),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 60,
                            height: 5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: LinearProgressIndicator(
                                value: (pct / 100.0).clamp(0.0, 1.0),
                                backgroundColor: Colors.white.withValues(alpha: 0.05),
                                valueColor: AlwaysStoppedAnimation<Color>(pctColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(Text(item.avgConsultTime.toStringAsFixed(1), style: const TextStyle(fontSize: 11, color: Colors.white))),
                    DataCell(
                      Text(
                        '${item.abhaScanPercent.round()}%',
                        style: TextStyle(
                          color: item.abhaScanPercent >= 80 ? AppColors.success : AppColors.secondaryAccent,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${item.ePrescriptionPercent.round()}%',
                        style: TextStyle(
                          color: item.ePrescriptionPercent >= 75 ? AppColors.success : AppColors.secondaryAccent,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        item.csat.toStringAsFixed(1),
                        style: TextStyle(
                          color: csatColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: pctColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: pctColor.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          pct >= 100 ? 'On Target' : (pct >= 90 ? 'Near Target' : 'Below Target'),
                          style: TextStyle(color: pctColor, fontSize: 9, fontWeight: FontWeight.bold),
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
