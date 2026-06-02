import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/blood_bank/view_model/blood_bank_view_model.dart';

class BbExpiryTab extends ConsumerWidget {
  const BbExpiryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bloodBankProvider);

    final expiring = state.stock.where((s) => s.daysLeft <= 10).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '⚠️ Stock Expiry & Quarantine Tracker',
              style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondaryAccent),
              icon: const Icon(Icons.picture_as_pdf_rounded, color: Colors.white, size: 16),
              label: const Text('GENERATE EXPIRY REPORT', style: TextStyle(color: Colors.white)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Downloading PDF report of quarantined stock...')),
                );
              },
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
                  DataColumn(label: Text('Bag ID', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Group', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Component', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Collected', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Expiry', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Days Left', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Alert Severity', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: expiring.map((s) {
                  final isCritical = s.daysLeft <= 5;
                  final alertColor = isCritical ? const Color(0xFFC62828) : const Color(0xFFE65100);

                  return DataRow(
                    cells: [
                      DataCell(Text(s.bagId, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace'))),
                      DataCell(Text(s.group, style: const TextStyle(color: Color(0xFFC62828), fontWeight: FontWeight.bold, fontSize: 14))),
                      DataCell(Text(s.component)),
                      DataCell(Text(s.collected, style: const TextStyle(fontSize: 12, color: AppColors.secondaryText))),
                      DataCell(Text(s.expiry, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                      DataCell(
                        Text(
                          '${s.daysLeft} days',
                          style: TextStyle(
                            color: alertColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: alertColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            isCritical ? '🚨 CRITICAL' : '⚠️ LOW',
                            style: TextStyle(
                              color: alertColor,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add_alert_rounded, color: Colors.blueAccent, size: 16),
                              tooltip: 'Send alert notification',
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Dispatched quarantine warning for bag ${s.bagId} to nurses.')),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error, size: 16),
                              tooltip: 'Mark as waste/disposed',
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Bag ${s.bagId} marked for biological hazard disposal.'),
                                    backgroundColor: AppColors.error,
                                  ),
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
