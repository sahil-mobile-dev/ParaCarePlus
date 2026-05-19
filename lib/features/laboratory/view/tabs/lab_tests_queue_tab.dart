import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class LabTestsQueueTab extends StatefulWidget {
  const LabTestsQueueTab({super.key});

  @override
  State<LabTestsQueueTab> createState() => _LabTestsQueueTabState();
}

class _LabTestsQueueTabState extends State<LabTestsQueueTab> {
  String _searchQuery = '';
  final List<Map<String, dynamic>> _labQueue = [
    {
      'sampleId': 'SMP-4482',
      'patient': 'Devendra Rawat',
      'testName': 'Complete Blood Count (CBC)',
      'dept': 'Hematology',
      'doctor': 'Dr. Negi',
      'status': 'Sample Collected',
      'time': '10 mins ago',
    },
    {
      'sampleId': 'SMP-4483',
      'patient': 'Sanjay Joshi',
      'testName': 'Liver Function Test (LFT)',
      'dept': 'Biochemistry',
      'doctor': 'Dr. Negi',
      'status': 'Pending Collection',
      'time': '25 mins ago',
    },
    {
      'sampleId': 'SMP-4484',
      'patient': 'Geeta Devi',
      'testName': 'HbA1c & Fasting Glucose',
      'dept': 'Biochemistry',
      'doctor': 'Dr. Joshi',
      'status': 'Results Entered',
      'time': '40 mins ago',
    },
    {
      'sampleId': 'SMP-4485',
      'patient': 'Kiran Negi',
      'testName': 'Urine Routine & Micro',
      'dept': 'Clinical Path',
      'doctor': 'Dr. Semwal',
      'status': 'Pending Collection',
      'time': '1 hour ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _labQueue.where((item) {
      final q = _searchQuery.toLowerCase();
      return item['sampleId'].toString().toLowerCase().contains(q) ||
          item['patient'].toString().toLowerCase().contains(q) ||
          item['testName'].toString().toLowerCase().contains(q);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filter bar
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      color: AppColors.secondaryText,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        style: AppTextStyles.bodyMedium,
                        decoration: const InputDecoration(
                          hintText:
                              'Search patient name, sample ID, test name...',
                          hintStyle: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
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
              ),
            ),
            const SizedBox(width: 12),
            _buildDropdownFilter('All Departments'),
            const SizedBox(width: 12),
            _buildDropdownFilter('All Statuses'),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Queue Registry
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
                child: Text(
                  'Active Diagnostics Queue Registry',
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(color: AppColors.border, height: 1),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  columnWidths: const {
                    0: FixedColumnWidth(130), // Sample ID
                    1: FixedColumnWidth(180), // Patient
                    2: FixedColumnWidth(220), // Test name
                    3: FixedColumnWidth(130), // Dept
                    4: FixedColumnWidth(130), // Doctor
                    5: FixedColumnWidth(160), // Status
                    6: FixedColumnWidth(130), // Collected At
                    7: FixedColumnWidth(150), // Action
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(color: AppColors.surface),
                      children: [
                        _buildHeaderCell('SAMPLE ID'),
                        _buildHeaderCell('PATIENT'),
                        _buildHeaderCell('TEST NAME'),
                        _buildHeaderCell('DEPT'),
                        _buildHeaderCell('REQ. DOCTOR'),
                        _buildHeaderCell('STATUS'),
                        _buildHeaderCell('COLLECTED AT'),
                        _buildHeaderCell('ACTION'),
                      ],
                    ),
                    ...filtered.map((item) {
                      final status = item['status'] as String;
                      var statusColor = AppColors.secondaryAccent;
                      if (status == 'Sample Collected') {
                        statusColor = AppColors.primary;
                      } else if (status == 'Results Entered') {
                        statusColor = AppColors.success;
                      }

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
                              item['sampleId'] as String,
                              style: AppTextStyles.bodyMedium.copyWith(
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
                            child: Text(
                              item['patient'] as String,
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _buildTextCell(item['testName'] as String),
                          _buildTextCell(item['dept'] as String),
                          _buildTextCell(item['doctor'] as String),
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
                                color: statusColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                status,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: statusColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          _buildTextCell(item['time'] as String),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            child: _buildActionButton(context, item, status),
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

  Widget _buildDropdownFilter(String label) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Text(label, style: AppTextStyles.bodyMedium),
          const SizedBox(width: 8),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.secondaryText,
            size: 16,
          ),
        ],
      ),
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

  Widget _buildActionButton(
    BuildContext context,
    Map<String, dynamic> item,
    String status,
  ) {
    if (status == 'Pending Collection') {
      return ElevatedButton(
        onPressed: () {
          setState(() {
            item['status'] = 'Sample Collected';
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.success,
              content: Text('Sample Collected for ${item['patient']}!'),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: const Text('Collect Sample', style: TextStyle(fontSize: 11)),
      );
    } else if (status == 'Sample Collected') {
      return ElevatedButton(
        onPressed: () {
          _showEnterResultsDialog(context, item);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryAccent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: const Text('Enter Results', style: TextStyle(fontSize: 11)),
      );
    } else {
      return OutlinedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.success,
              content: Text(
                'Report generated and printed for ${item['patient']}!',
              ),
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.success,
          side: const BorderSide(color: AppColors.success, width: 0.5),
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: const Text('Verify & Print', style: TextStyle(fontSize: 11)),
      );
    }
  }

  void _showEnterResultsDialog(
    BuildContext context,
    Map<String, dynamic> item,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          title: const Text(
            'Enter Diagnostics Value',
            style: AppTextStyles.titleMedium,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Patient: ${item['patient']}',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text('Test: ${item['testName']}', style: AppTextStyles.bodySmall),
              const SizedBox(height: 16),
              const TextField(
                style: AppTextStyles.bodyMedium,
                decoration: InputDecoration(
                  labelText: 'Diagnostic Result Value',
                  labelStyle: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 13,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.secondaryText),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  item['status'] = 'Results Entered';
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.success,
                    content: Text(
                      'Results entered and ready for verification!',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
              ),
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
