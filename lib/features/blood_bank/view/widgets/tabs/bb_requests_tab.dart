import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/blood_bank/view/widgets/bb_modals.dart';
import 'package:paracareplus/features/blood_bank/view_model/blood_bank_view_model.dart';

class BbRequestsTab extends ConsumerWidget {
  const BbRequestsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bloodBankProvider);
    final notifier = ref.read(bloodBankProvider.notifier);

    return Column(
      children: [
        // Action Bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '📋 Patient Blood Requests Queue',
              style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC62828),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              icon: const Icon(Icons.add_rounded, color: Colors.white),
              label: const Text('SUBMIT REQUEST', style: TextStyle(color: Colors.white)),
              onPressed: () => BbModals.showBloodRequest(context, ref),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        // Data table
        Container(
          width: double.infinity,
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
                headingRowColor: WidgetStateProperty.all(AppColors.border.withValues(alpha: 0.15)),
                columns: const [
                  DataColumn(label: Text('Req No', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Patient Name', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Ward / Dept', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Group', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Component', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Units', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Urgency', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Requested By', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: state.requests.map((r) {
                  final isEmergency = r.urgency.toLowerCase() == 'emergency';
                  final isUrgent = r.urgency.toLowerCase() == 'urgent';

                  var urgBg = Colors.grey.withValues(alpha: 0.15);
                  Color urgTxt = Colors.grey;
                  if (isEmergency) {
                    urgBg = AppColors.error.withValues(alpha: 0.15);
                    urgTxt = AppColors.error;
                  } else if (isUrgent) {
                    urgBg = AppColors.secondaryAccent.withValues(alpha: 0.15);
                    urgTxt = AppColors.secondaryAccent;
                  }

                  var statBg = AppColors.secondaryAccent.withValues(alpha: 0.15);
                  var statTxt = AppColors.secondaryAccent;
                  if (r.status == 'Issued') {
                    statBg = AppColors.success.withValues(alpha: 0.15);
                    statTxt = AppColors.success;
                  } else if (r.status == 'Cross-Matching') {
                    statBg = Colors.blue.withValues(alpha: 0.15);
                    statTxt = Colors.blue;
                  }

                  return DataRow(
                    cells: [
                      DataCell(Text(r.reqNo, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace'))),
                      DataCell(Text(r.patientName, style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(Text(r.ward)),
                      DataCell(Text(r.bloodGroup, style: const TextStyle(color: Color(0xFFC62828), fontWeight: FontWeight.bold, fontSize: 14))),
                      DataCell(Text(r.component)),
                      DataCell(Text(r.units.toString(), style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: urgBg, borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            r.urgency.toUpperCase(),
                            style: TextStyle(color: urgTxt, fontSize: 9, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataCell(Text(r.requestedBy, style: const TextStyle(fontSize: 12, color: AppColors.secondaryText))),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: statBg, borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            r.status.toUpperCase(),
                            style: TextStyle(color: statTxt, fontSize: 9, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            if (r.status == 'Pending')
                              IconButton(
                                icon: const Icon(Icons.science_rounded, color: Colors.blueAccent, size: 18),
                                tooltip: 'Initiate Cross-match testing',
                                onPressed: () => notifier.selectRequestForCrossmatch(r),
                              ),
                            if (r.status == 'Cross-Matching' || r.status == 'Pending')
                              IconButton(
                                icon: const Icon(Icons.send_rounded, color: AppColors.success, size: 18),
                                tooltip: 'Issue Blood bag',
                                onPressed: () {
                                  notifier.setTab('Issue');
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
