import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/blood_bank/view_model/blood_bank_view_model.dart';
import 'package:paracareplus/features/blood_bank/view/widgets/bb_modals.dart';

class BbDonorsTab extends ConsumerStatefulWidget {
  const BbDonorsTab({super.key});

  @override
  ConsumerState<BbDonorsTab> createState() => _BbDonorsTabState();
}

class _BbDonorsTabState extends ConsumerState<BbDonorsTab> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bloodBankProvider);

    final filtered = state.donors.where((d) {
      return d.name.toLowerCase().contains(_search.toLowerCase()) ||
          d.mobile.contains(_search) ||
          d.id.toLowerCase().contains(_search.toLowerCase());
    }).toList();

    return Column(
      children: [
        // Action Bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                style: AppTextStyles.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'Search donor registry by name, ID or mobile...',
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.secondaryText),
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (val) => setState(() => _search = val),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF880E4F),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              icon: const Icon(Icons.person_add_alt_1_rounded, color: Colors.white),
              label: const Text('REGISTER DONOR', style: TextStyle(color: Colors.white)),
              onPressed: () => BbModals.showRegisterDonor(context, ref),
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
                  DataColumn(label: Text('Donor ID', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Full Name', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Age/Sex', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Blood Group', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Mobile', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Last Donation', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Total Donations', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Eligibility', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: filtered.map((d) {
                  final isEl = d.eligible.toLowerCase() == 'yes';

                  return DataRow(
                    cells: [
                      DataCell(Text(d.id, style: const TextStyle(fontFamily: 'monospace'))),
                      DataCell(Text(d.name, style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(Text(d.ageSex, style: const TextStyle(fontSize: 12, color: AppColors.secondaryText))),
                      DataCell(Text(d.bloodGroup, style: const TextStyle(color: Color(0xFFC62828), fontWeight: FontWeight.bold, fontSize: 14))),
                      DataCell(Text(d.mobile)),
                      DataCell(Text(d.lastDonation, style: const TextStyle(fontSize: 12, color: AppColors.secondaryText))),
                      DataCell(Text(d.totalDonations.toString(), style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: (isEl ? AppColors.success : AppColors.secondaryAccent).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            d.eligible.toUpperCase(),
                            style: TextStyle(
                              color: isEl ? AppColors.success : AppColors.secondaryAccent,
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
                              icon: const Icon(Icons.remove_red_eye_outlined, color: AppColors.secondaryText, size: 16),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Loading Donor Profile for ${d.name}')),
                                );
                              },
                            ),
                            if (isEl)
                              IconButton(
                                icon: const Icon(Icons.water_drop_rounded, color: Color(0xFFC62828), size: 16),
                                tooltip: 'Record donation',
                                onPressed: () => BbModals.showRecordDonation(context, ref),
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
