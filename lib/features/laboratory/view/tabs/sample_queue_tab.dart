import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class SampleQueueTab extends StatefulWidget {
  const SampleQueueTab({super.key});

  @override
  State<SampleQueueTab> createState() => _SampleQueueTabState();
}

class _SampleQueueTabState extends State<SampleQueueTab> {
  String _searchQuery = '';
  String _selectedCategory = 'All Category';
  String _selectedStatus = 'All Status';
  final TextEditingController _searchController = TextEditingController();

  // Mock list of specimen samples
  final List<Map<String, dynamic>> _samples = [
    {
      'sampleId': 'IPDPAT-20260513-00001',
      'orderTime': '13-05-2026 16:23',
      'patientName': 'Mr. Nilesh Patel',
      'mrn': 'MRN-99812',
      'ageGender': '45 Yrs / Male',
      'testName': 'Blood Culture & Sensitivity',
      'category': 'Hematology',
      'priority': 'Routine',
      'orderedBy': 'Bakul Shah',
      'collected': 'Pending',
      'status': 'Ordered',
      'expanded': false,
    },
    {
      'sampleId': 'EMGPAT-20260519-00002',
      'orderTime': '19-05-2026 12:45',
      'patientName': 'Sunita Rawat',
      'mrn': 'MRN-87421',
      'ageGender': '32 Yrs / Female',
      'testName': 'Serum Electrolytes',
      'category': 'Biochemistry',
      'priority': 'Urgent',
      'orderedBy': 'Dr. Negi',
      'collected': 'Collected',
      'status': 'Processing',
      'expanded': false,
    },
    {
      'sampleId': 'OPDPAT-20260519-00003',
      'orderTime': '19-05-2026 10:15',
      'patientName': 'Kiran Joshi',
      'mrn': 'MRN-34190',
      'ageGender': '58 Yrs / Male',
      'testName': 'Glycated Hemoglobin (HbA1c)',
      'category': 'Biochemistry',
      'priority': 'Routine',
      'orderedBy': 'Dr. Semwal',
      'collected': 'Collected',
      'status': 'Results Entered',
      'expanded': false,
    },
  ];

  void _clearFilters() {
    setState(() {
      _searchQuery = '';
      _selectedCategory = 'All Category';
      _selectedStatus = 'All Status';
      _searchController.clear();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredSamples = _samples.where((sample) {
      final matchesSearch =
          sample['patientName'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          sample['sampleId'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          sample['mrn'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );

      final matchesCategory =
          _selectedCategory == 'All Category' ||
          sample['category'] == _selectedCategory;

      final matchesStatus =
          _selectedStatus == 'All Status' ||
          sample['status'] == _selectedStatus;

      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Interactive Pathology Filter Deck
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pathology Specimen Registry Filters',
                style: AppTextStyles.labelMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: TextField(
                              controller: _searchController,
                              style: AppTextStyles.bodyMedium,
                              decoration: const InputDecoration(
                                hintText: 'Search patient, sample ID, MRN...',
                                hintStyle: TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 12,
                                ),
                                prefixIcon: Icon(
                                  Icons.search_rounded,
                                  color: AppColors.secondaryText,
                                  size: 20,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              onChanged: (val) {
                                setState(() {
                                  _searchQuery = val;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(flex: 2, child: _buildCategoryDropdown()),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(flex: 2, child: _buildStatusDropdown()),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(child: _buildDateField('From Date')),
                          const SizedBox(width: 12),
                          Expanded(child: _buildDateField('To Date')),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 110,
                            height: 40,
                            child: OutlinedButton(
                              onPressed: _clearFilters,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColors.border),
                                foregroundColor: AppColors.secondaryText,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text(
                                'Clear Filters',
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // 2. Specimen Table Card
        Container(
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
                    Text(
                      'Live Diagnostics Sample Worklist',
                      style: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Showing ${filteredSamples.length} samples',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: AppColors.border, height: 1),
              if (filteredSamples.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(40),
                  child: const Center(
                    child: Text(
                      'No matching specimens found in queue.',
                      style: TextStyle(color: AppColors.secondaryText),
                    ),
                  ),
                )
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 1290,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header row
                        Container(
                          color: AppColors.surface,
                          height: 48,
                          child: Row(
                            children: [
                              const SizedBox(width: 60), // Expand arrow
                              _buildHeaderCell('SAMPLE ID', 210),
                              _buildHeaderCell('PATIENT', 180),
                              _buildHeaderCell('TEST NAME', 200),
                              _buildHeaderCell('PRIORITY', 110),
                              _buildHeaderCell('REQ. BY', 120),
                              _buildHeaderCell('COLLECTED', 130),
                              _buildHeaderCell('STATUS', 140),
                              _buildHeaderCell('ACTION', 140),
                            ],
                          ),
                        ),
                        // Data rows
                        ...filteredSamples.map((sample) {
                          final isExpanded = sample['expanded'] == true;
                          return Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: AppColors.border,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 60,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        child: IconButton(
                                          icon: Icon(
                                            isExpanded
                                                ? Icons
                                                      .keyboard_arrow_down_rounded
                                                : Icons
                                                      .keyboard_arrow_right_rounded,
                                            color: AppColors.secondaryText,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              sample['expanded'] = !isExpanded;
                                            });
                                          },
                                        ),
                                      ),
                                      _buildCell(
                                        width: 210,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              sample['sampleId'] as String,
                                              style: AppTextStyles.bodyMedium
                                                  .copyWith(
                                                    color: AppColors.primary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              sample['orderTime'] as String,
                                              style: AppTextStyles.bodySmall
                                                  .copyWith(
                                                    color:
                                                        AppColors.secondaryText,
                                                    fontSize: 10,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      _buildCell(
                                        width: 180,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              sample['patientName'] as String,
                                              style: AppTextStyles.bodyMedium
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              '${sample['mrn']} | ${sample['ageGender']}',
                                              style: AppTextStyles.bodySmall
                                                  .copyWith(
                                                    color:
                                                        AppColors.secondaryText,
                                                    fontSize: 10,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      _buildTextCell(
                                        sample['testName'] as String,
                                        200,
                                      ),
                                      _buildPriorityBadge(
                                        sample['priority'] as String,
                                        110,
                                      ),
                                      _buildTextCell(
                                        sample['orderedBy'] as String,
                                        120,
                                      ),
                                      _buildCollectedBadge(
                                        sample['collected'] as String,
                                        100,
                                      ),
                                      _buildStatusBadge(
                                        sample['status'] as String,
                                        140,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 12,
                                        ),
                                        child: _buildRowAction(sample),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isExpanded)
                                  Container(
                                    color: AppColors.surface,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildDetailField(
                                          'Specimen Container',
                                          sample['category'] == 'Hematology'
                                              ? 'Lavender EDTA Tube (EDTA K3)'
                                              : 'Red SST Tube (Gel/Clot Act)',
                                        ),
                                        _buildDetailField(
                                          'Barcode Ref',
                                          'BC-${sample['sampleId'].toString().split('-').last}',
                                        ),
                                        _buildDetailField(
                                          'Assigned Section',
                                          sample['category'] as String,
                                        ),
                                        _buildDetailField(
                                          'Doctor Clinical Notes',
                                          'Check cell pathology counts and evaluate anomalies.',
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCategory,
          dropdownColor: AppColors.card,
          style: AppTextStyles.bodyMedium,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.secondaryText,
            size: 20,
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedCategory = newValue;
              });
            }
          },
          items:
              <String>[
                'All Category',
                'Hematology',
                'Biochemistry',
                'Microbiology',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedStatus,
          dropdownColor: AppColors.card,
          style: AppTextStyles.bodyMedium,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.secondaryText,
            size: 20,
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedStatus = newValue;
              });
            }
          },
          items:
              <String>[
                'All Status',
                'Ordered',
                'Collected',
                'Processing',
                'Results Entered',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildDateField(String label) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.secondaryText,
            ),
          ),
          const Icon(
            Icons.calendar_today_rounded,
            color: AppColors.secondaryText,
            size: 14,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String label, double width) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryText,
          ),
        ),
      ),
    );
  }

  Widget _buildCell({required double width, required Widget child}) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: child,
      ),
    );
  }

  Widget _buildTextCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          text,
          style: AppTextStyles.bodyMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(String priority, double width) {
    final isUrgent = priority == 'Urgent';
    final color = isUrgent ? AppColors.error : AppColors.success;
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Text(
              priority,
              style: AppTextStyles.labelSmall.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCollectedBadge(String collected, double width) {
    final isCollected = collected == 'Collected';
    final color = isCollected ? AppColors.success : AppColors.secondaryAccent;
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          collected,
          style: AppTextStyles.bodyMedium.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status, double width) {
    var color = AppColors.secondaryText;
    if (status == 'Processing') {
      color = AppColors.primary;
    } else if (status == 'Results Entered') {
      color = AppColors.success;
    } else if (status == 'Ordered') {
      color = AppColors.secondaryAccent;
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: width,
        child: Container(
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            status,
            style: AppTextStyles.labelMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRowAction(Map<String, dynamic> sample) {
    final collected = sample['collected'] as String;
    final status = sample['status'] as String;

    if (collected == 'Pending') {
      return ElevatedButton(
        onPressed: () {
          setState(() {
            sample['collected'] = 'Collected';
            sample['status'] = 'Collected';
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.success,
              content: Text(
                'Specimen sample collected for ${sample['patientName']}!',
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: const Text('Collect Sample', style: TextStyle(fontSize: 11)),
      );
    } else if (status == 'Collected') {
      return ElevatedButton(
        onPressed: () {
          setState(() {
            sample['status'] = 'Processing';
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.primary,
              content: Text(
                'Specimen loading onto analyzer for ${sample['patientName']}...',
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryAccent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: const Text('Process Sample', style: TextStyle(fontSize: 11)),
      );
    } else {
      return OutlinedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.success,
              content: Text('Report ready for ${sample['patientName']}.'),
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.success,
          side: const BorderSide(color: AppColors.success, width: 0.5),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: const Text('Ready / Dispatch', style: TextStyle(fontSize: 11)),
      );
    }
  }

  Widget _buildDetailField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.primaryText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
