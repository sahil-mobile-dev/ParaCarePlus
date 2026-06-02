import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/pharmacy/view_model/pharmacy_view_model.dart';

class DispenseQueueTab extends ConsumerStatefulWidget {
  const DispenseQueueTab({super.key});

  @override
  ConsumerState<DispenseQueueTab> createState() => _DispenseQueueTabState();
}

class _DispenseQueueTabState extends ConsumerState<DispenseQueueTab> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dispenseQueue = ref.watch(pharmacyProvider.select((s) => s.dispenseQueue));

    final filteredList = dispenseQueue.where((item) {
      final query = _searchQuery.toLowerCase();
      return item.patient.toLowerCase().contains(query) ||
          item.rxNo.toLowerCase().contains(query) ||
          item.doctor.toLowerCase().contains(query);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filter bar
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: AppTextStyles.bodyMedium,
                      decoration: const InputDecoration(
                        hintText:
                            'Search by Patient Name, RX No., or Doctor...',
                        hintStyle: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: AppColors.secondaryText,
                          size: 20,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val;
                        });
                      },
                    ),
                  ),
                  if (_searchQuery.isNotEmpty)
                    IconButton(
                      icon: const Icon(
                        Icons.clear_rounded,
                        color: AppColors.secondaryText,
                        size: 18,
                      ),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _searchQuery = '';
                        });
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(
                    Icons.filter_list_rounded,
                    color: AppColors.secondaryText,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'All Wards',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primaryText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Prescription Table
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Routine & Urgent Active Queue',
                      style: AppTextStyles.labelLarge,
                    ),
                    Text(
                      '${filteredList.length} prescriptions pending',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              const Divider(color: AppColors.border, height: 1),
              if (filteredList.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.medication_liquid_rounded,
                          size: 48,
                          color: AppColors.secondaryText,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'No prescriptions found in queue',
                          style: TextStyle(color: AppColors.secondaryText),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    columnWidths: const {
                      0: FixedColumnWidth(130), // RX No
                      1: FixedColumnWidth(160), // Patient
                      2: FixedColumnWidth(130), // Ward/Type
                      3: FixedColumnWidth(130), // Doctor
                      4: FixedColumnWidth(260), // Drugs
                      5: FixedColumnWidth(110), // Priority
                      6: FixedColumnWidth(110), // Time
                      7: FixedColumnWidth(130), // Status
                      8: FixedColumnWidth(130), // Actions
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      // Header Row
                      TableRow(
                        decoration: const BoxDecoration(
                          color: AppColors.surface,
                        ),
                        children: [
                          _buildHeaderCell('RX NO.'),
                          _buildHeaderCell('PATIENT'),
                          _buildHeaderCell('WARD/TYPE'),
                          _buildHeaderCell('DOCTOR'),
                          _buildHeaderCell('DRUGS'),
                          _buildHeaderCell('PRIORITY'),
                          _buildHeaderCell('TIME'),
                          _buildHeaderCell('STATUS'),
                          _buildHeaderCell('ACTIONS'),
                        ],
                      ),
                      // Data Rows
                      ...filteredList.map((item) {
                        final isUrgent = item.priority == 'Urgent';
                        return TableRow(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: AppColors.border),
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              child: Text(
                                item.rxNo,
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.patient,
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item.ageSex,
                                    style: AppTextStyles.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            _buildTextCell(item.wardType),
                            _buildTextCell(item.doctor),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              child: Text(
                                item.drugs,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.primaryText,
                                  height: 1.3,
                                ),
                              ),
                            ),
                            // Priority badge
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isUrgent
                                      ? AppColors.error.withValues(alpha: 0.1)
                                      : AppColors.success.withValues(
                                          alpha: 0.1,
                                        ),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: isUrgent
                                        ? AppColors.error
                                        : AppColors.success,
                                    width: 0.5,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  item.priority,
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: isUrgent
                                        ? AppColors.error
                                        : AppColors.success,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            _buildTextCell(item.time),
                            // Status Badge
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: item.status == 'Prepared'
                                      ? AppColors.success.withValues(alpha: 0.1)
                                      : item.status == 'Preparing'
                                      ? AppColors.secondaryAccent.withValues(
                                          alpha: 0.1,
                                        )
                                      : AppColors.primaryText.withValues(
                                          alpha: 0.05,
                                        ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  item.status,
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: item.status == 'Prepared'
                                        ? AppColors.success
                                        : item.status == 'Preparing'
                                        ? AppColors.secondaryAccent
                                        : AppColors.secondaryText,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            // Dispense Action
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  ref.read(pharmacyProvider.notifier).dispensePrescription(item.rxNo);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: AppColors.success,
                                      content: Text(
                                        'Prescription ${item.rxNo} dispensed successfully!',
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  textStyle: AppTextStyles.labelSmall.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: const Text('Dispense'),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String label) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        label,
        style: AppTextStyles.labelMedium.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.secondaryText,
        ),
      ),
    );
  }

  Widget _buildTextCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Text(text, style: AppTextStyles.bodyMedium),
    );
  }
}
