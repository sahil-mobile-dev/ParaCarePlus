import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/blood_bank/view_model/blood_bank_view_model.dart';
import 'package:paracareplus/features/blood_bank/view/widgets/bb_modals.dart';

class BbDonationsTab extends ConsumerWidget {
  const BbDonationsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bloodBankProvider);

    return Column(
      children: [
        // Action Bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '🤝 Blood Donation Sessions Log',
              style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF880E4F),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              icon: const Icon(Icons.add_rounded, color: Colors.white),
              label: const Text('RECORD DONATION', style: TextStyle(color: Colors.white)),
              onPressed: () => BbModals.showRecordDonation(context, ref),
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
                  DataColumn(label: Text('Donor', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Blood Group', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Donation Date', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Volume', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Screening Results', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Camp / Walk-in', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Component Type', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: state.donations.map((d) {
                  final isAvail = d.status == 'Available';

                  return DataRow(
                    cells: [
                      DataCell(Text(d.bagId, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold))),
                      DataCell(Text(d.donorName, style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(Text(d.bloodGroup, style: const TextStyle(color: Color(0xFFC62828), fontWeight: FontWeight.bold, fontSize: 14))),
                      DataCell(Text(d.date, style: const TextStyle(fontSize: 12, color: AppColors.secondaryText))),
                      DataCell(Text(d.volume)),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            d.screening.toUpperCase(),
                            style: const TextStyle(
                              color: AppColors.success,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            d.campType.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      DataCell(Text(d.component)),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: (isAvail ? AppColors.success : AppColors.secondaryText).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            d.status.toUpperCase(),
                            style: TextStyle(
                              color: isAvail ? AppColors.success : AppColors.secondaryText,
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
          ),
        ),
      ],
    );
  }
}
