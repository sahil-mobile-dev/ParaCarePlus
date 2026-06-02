import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/lab_diagnostics/model/lab_diagnostics_model.dart';
import 'package:paracareplus/features/lab_diagnostics/view_model/lab_diagnostics_view_model.dart';
import 'package:paracareplus/features/lab_diagnostics/view/widgets/lab_modals.dart';

class SampleQueueTab extends ConsumerWidget {
  const SampleQueueTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(labDiagnosticsProvider);
    final notifier = ref.read(labDiagnosticsProvider.notifier);

    // Apply client filters
    final filtered = state.samples.where((s) {
      final matchesSearch = s.patientName.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          s.id.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          s.mrn.toLowerCase().contains(state.searchQuery.toLowerCase());

      final matchesCat = state.categoryFilter == 'All Categories' || s.category == state.categoryFilter;
      
      final matchesStatus = state.statusFilter == 'All Status' || s.status == state.statusFilter.toLowerCase();

      return matchesSearch && matchesCat && matchesStatus;
    }).toList();

    return Column(
      children: [
        // Filters Row
        Row(
          children: [
            Expanded(
              child: TextField(
                style: AppTextStyles.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'Search patient, specimen ID or MRN...',
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.secondaryText),
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (val) => notifier.setSearchQuery(val),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            _buildDropdown(
              value: state.categoryFilter,
              items: const ['All Categories', 'Haematology', 'Biochemistry', 'Microbiology', 'Serology', 'Endocrinology'],
              onChanged: (val) {
                if (val != null) notifier.setCategoryFilter(val);
              },
            ),
            const SizedBox(width: AppSpacing.md),
            _buildDropdown(
              value: state.statusFilter,
              items: const ['All Status', 'Ordered', 'Collected', 'Processing', 'Completed'],
              onChanged: (val) {
                if (val != null) notifier.setStatusFilter(val);
              },
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        // Data table
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
                dataRowMinHeight: 52,
                dataRowMaxHeight: 64,
                columns: const [
                  DataColumn(label: Text('Specimen ID', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Patient Details', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Tests Prescribed', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Category', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Priority', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Ordered By', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Collected', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: filtered.map((s) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          s.id,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primaryLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(s.patientName, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                            Text(s.mrn, style: const TextStyle(fontSize: 11, color: AppColors.secondaryText)),
                          ],
                        ),
                      ),
                      DataCell(Text(s.tests, style: const TextStyle(fontSize: 11))),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.indigo.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            s.category,
                            style: const TextStyle(color: Colors.indigoAccent, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataCell(_buildPriorityChip(s.priority)),
                      DataCell(Text(s.doctor, style: const TextStyle(fontSize: 11))),
                      DataCell(Text(s.collected, style: const TextStyle(fontSize: 12, color: AppColors.secondaryText))),
                      DataCell(_buildStatusChip(s.status, s.result)),
                      DataCell(
                        Row(
                          children: [
                            if (s.status != 'completed')
                              IconButton(
                                icon: const Icon(Icons.analytics_outlined, color: AppColors.primaryLight, size: 18),
                                tooltip: 'Enter diagnostics values',
                                onPressed: () => LabModals.showResultEntry(context, ref, s),
                              ),
                            IconButton(
                              icon: const Icon(Icons.qr_code_scanner_rounded, color: AppColors.secondaryText, size: 18),
                              tooltip: 'Print barcode label',
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Printing barcode label for ${s.id}')),
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

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: AppColors.card,
          style: AppTextStyles.bodyMedium,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildPriorityChip(String p) {
    Color bg = Colors.grey.withValues(alpha: 0.15);
    Color txt = Colors.grey;
    if (p == 'stat') {
      bg = AppColors.error.withValues(alpha: 0.15);
      txt = AppColors.error;
    } else if (p == 'urgent') {
      bg = AppColors.secondaryAccent.withValues(alpha: 0.15);
      txt = AppColors.secondaryAccent;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
      child: Text(
        p.toUpperCase(),
        style: TextStyle(color: txt, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildStatusChip(String s, String? res) {
    Color bg = Colors.grey.withValues(alpha: 0.15);
    Color txt = Colors.grey;
    String label = s;

    if (s == 'completed') {
      bg = AppColors.success.withValues(alpha: 0.15);
      txt = AppColors.success;
      label = '✅ Completed';
    } else if (s == 'processing') {
      bg = Colors.blue.withValues(alpha: 0.15);
      txt = Colors.blue;
      label = '🔬 Processing';
    } else if (s == 'collected') {
      bg = Colors.teal.withValues(alpha: 0.15);
      txt = Colors.teal;
      label = '🧫 Collected';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(color: txt, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
