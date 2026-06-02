import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/radiology_imaging/view_model/radiology_imaging_view_model.dart';

class RadiologyWorklistTab extends ConsumerStatefulWidget {
  const RadiologyWorklistTab({super.key});

  @override
  ConsumerState<RadiologyWorklistTab> createState() => _RadiologyWorklistTabState();
}

class _RadiologyWorklistTabState extends ConsumerState<RadiologyWorklistTab> {
  String _selectedModality = 'All';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(radiologyImagingProvider);

    final filteredList = state.worklist.where((item) {
      final matchesModality = _selectedModality == 'All' || item.modality == _selectedModality;
      final matchesSearch = item.patient.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.accession.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesModality && matchesSearch;
    }).toList();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.list_alt_rounded, color: AppColors.primaryLight, size: 16),
              const SizedBox(width: 8),
              const Text(
                'RADIOLOGY WORKLIST',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: AppColors.secondaryText,
                  fontFamily: AppTextStyles.fontFamily,
                ),
              ),
              const Spacer(),
              // Filter Modality
              DropdownButton<String>(
                dropdownColor: AppColors.surface,
                value: _selectedModality,
                style: const TextStyle(color: Colors.white, fontSize: 11),
                items: const [
                  DropdownMenuItem(value: 'All', child: Text('All Modalities')),
                  DropdownMenuItem(value: 'X-Ray', child: Text('X-Ray')),
                  DropdownMenuItem(value: 'CT Scan', child: Text('CT Scan')),
                  DropdownMenuItem(value: 'MRI', child: Text('MRI')),
                  DropdownMenuItem(value: 'Ultrasound', child: Text('Ultrasound')),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _selectedModality = val);
                },
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            style: const TextStyle(color: Colors.white, fontSize: 12),
            decoration: InputDecoration(
              hintText: 'Search by patient name, Accession #...',
              hintStyle: const TextStyle(color: AppColors.secondaryText),
              prefixIcon: const Icon(Icons.search, color: AppColors.secondaryText, size: 16),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onChanged: (val) => setState(() => _searchQuery = val),
          ),
          const SizedBox(height: AppSpacing.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowHeight: 34,
              dataRowMinHeight: 34,
              dataRowMaxHeight: 40,
              horizontalMargin: 8,
              columnSpacing: 20,
              columns: const [
                DataColumn(label: Text('Accession', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Patient', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Age/Sex', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Modality', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Examination', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Ward/OPD', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Priority', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Status', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Time', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
              ],
              rows: filteredList.map((item) {
                final isStat = item.priority.toUpperCase() == 'STAT';
                final prioColor = isStat ? AppColors.error : AppColors.secondaryAccent;
                var statusColor = AppColors.primaryLight;
                if (item.status == 'Completed') {
                  statusColor = AppColors.success;
                } else if (item.status == 'Reported') {
                  statusColor = AppColors.success;
                }

                return DataRow(
                  cells: [
                    DataCell(Text(item.accession, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))),
                    DataCell(Text(item.patient, style: const TextStyle(color: Colors.white70, fontSize: 11))),
                    DataCell(Text(item.ageSex, style: const TextStyle(color: Colors.white70, fontSize: 11))),
                    DataCell(Text(item.modality, style: const TextStyle(color: Colors.white70, fontSize: 11))),
                    DataCell(Text(item.examination, style: const TextStyle(color: Colors.white54, fontSize: 11))),
                    DataCell(Text(item.wardOpd, style: const TextStyle(color: Colors.white54, fontSize: 11))),
                    DataCell(Text(item.priority, style: TextStyle(color: prioColor, fontSize: 11, fontWeight: FontWeight.bold))),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                        ),
                        child: Text(item.status, style: TextStyle(color: statusColor, fontSize: 9, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    DataCell(Text(item.time, style: const TextStyle(color: Colors.white54, fontSize: 11))),
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
