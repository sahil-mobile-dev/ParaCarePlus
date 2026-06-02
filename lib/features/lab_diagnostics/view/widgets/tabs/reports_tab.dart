import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/lab_diagnostics/model/lab_diagnostics_model.dart';
import 'package:paracareplus/features/lab_diagnostics/view_model/lab_diagnostics_view_model.dart';

class ReportsTab extends ConsumerWidget {
  const ReportsTab({super.key});

  void _showReportPdf(BuildContext context, LabReportItem r) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        'DISTRICT HOSPITAL DEHRADUN',
                        style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.w900, color: AppColors.primaryLight),
                      ),
                      const Text(
                        'Pathology Department — Laboratory Report',
                        style: TextStyle(fontSize: 11, color: AppColors.secondaryText),
                      ),
                      const SizedBox(height: 8),
                      Container(height: 2, color: AppColors.primary),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Meta grid
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1.5),
                  },
                  children: [
                    TableRow(children: [
                      const Text('Patient Name:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      Text(r.patientName, style: const TextStyle(fontSize: 12)),
                    ]),
                    TableRow(children: [
                      const Text('Sample ID:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      Text(r.id, style: const TextStyle(fontSize: 12)),
                    ]),
                    TableRow(children: [
                      const Text('Tests Ordered:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      Text(r.tests, style: const TextStyle(fontSize: 12)),
                    ]),
                    TableRow(children: [
                      const Text('Report Time:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      Text(r.time, style: const TextStyle(fontSize: 12)),
                    ]),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('TEST RESULTS SUMMARY', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.secondaryText)),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    r.keyResult,
                    style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(color: AppColors.border),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pathologist: Dr. Pooja Lab', style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic)),
                    Text('Verified Digital Copy ✅', style: TextStyle(fontSize: 11, color: AppColors.success, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('CLOSE'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                      icon: const Icon(Icons.print, color: Colors.white, size: 16),
                      label: const Text('PRINT', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Dispatching report to local laser printer...')),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(labDiagnosticsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '📄 Lab Reports — Completed Today',
              style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.card),
                  icon: const Icon(Icons.filter_alt_outlined, size: 16),
                  label: const Text('DATE FILTER'),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2025),
                      lastDate: DateTime(2027),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(AppColors.border.withValues(alpha: 0.2)),
                columns: const [
                  DataColumn(label: Text('Sample ID', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Patient', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Tests', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Key Result Findings', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Time Dispatched', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: state.reports.map((r) {
                  return DataRow(
                    cells: [
                      DataCell(Text(r.id, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryLight))),
                      DataCell(Text(r.patientName, style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(Text(r.tests)),
                      DataCell(Text(r.keyResult, style: const TextStyle(fontSize: 12))),
                      DataCell(Text(r.time, style: const TextStyle(color: AppColors.secondaryText))),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            r.status.toUpperCase(),
                            style: const TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            TextButton.icon(
                              style: TextButton.styleFrom(foregroundColor: AppColors.primaryLight),
                              icon: const Icon(Icons.remove_red_eye_outlined, size: 14),
                              label: const Text('View', style: TextStyle(fontSize: 12)),
                              onPressed: () => _showReportPdf(context, r),
                            ),
                            IconButton(
                              icon: const Icon(Icons.print_rounded, size: 16, color: AppColors.secondaryText),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Printing report ${r.id}')),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.send_rounded, size: 16, color: AppColors.success),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Report ${r.id} pushed to client doctor portal.')),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
