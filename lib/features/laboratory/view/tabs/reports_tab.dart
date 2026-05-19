import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class ReportsTab extends StatefulWidget {
  const ReportsTab({super.key});

  @override
  State<ReportsTab> createState() => _ReportsTabState();
}

class _ReportsTabState extends State<ReportsTab> {
  String _searchQuery = '';

  // Mock list of completed reports
  final List<Map<String, dynamic>> _reports = [
    {
      'sampleId': 'OPDPAT-20260519-00003',
      'patientName': 'Kiran Joshi',
      'mrn': 'MRN-34190',
      'tests': 'Glycated Hemoglobin (HbA1c)',
      'keyResult': 'HbA1c 5.8% (Normal)',
      'time': '19-05-2026 11:20',
      'isAbnormal': false,
    },
    {
      'sampleId': 'IPDPAT-20260518-00045',
      'patientName': 'Rajeshwari Negi',
      'mrn': 'MRN-11985',
      'tests': 'Lipid Profile Panel',
      'keyResult': 'Cholesterol 245 mg/dL (Abnormal)',
      'time': '18-05-2026 15:45',
      'isAbnormal': true,
    },
    {
      'sampleId': 'OPDPAT-20260518-00021',
      'patientName': 'David Miller',
      'mrn': 'MRN-77643',
      'tests': 'Complete Blood Count (CBC)',
      'keyResult': 'WBC 7.8 K/uL (Normal)',
      'time': '18-05-2026 10:12',
      'isAbnormal': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredReports = _reports.where((report) {
      return report['patientName'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          report['sampleId'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          report['mrn'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Search Bar & Filters Header
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: AppTextStyles.bodyMedium,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.secondaryText,
                            size: 18,
                          ),
                          hintText:
                              'Search completed reports by patient, sample ID or MRN...',
                          hintStyle: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 12,
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
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  icon: const Icon(Icons.tune_rounded, size: 16),
                  label: const Text('Filter', style: TextStyle(fontSize: 12)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // 2. Table list of reports
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
                child: Text(
                  'Dispatched Diagnostics Registry',
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(color: AppColors.border, height: 1),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 1000,
                  child: Table(
                    columnWidths: const {
                      0: FixedColumnWidth(180), // Sample ID
                      1: FixedColumnWidth(160), // Patient Name
                      2: FixedColumnWidth(210), // Tests
                      3: FixedColumnWidth(210), // Key Result
                      4: FixedColumnWidth(120), // Dispatch Time
                      5: FixedColumnWidth(120), // Status
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      // Header Row
                      TableRow(
                        decoration: const BoxDecoration(
                          color: AppColors.surface,
                        ),
                        children: [
                          _buildHeaderCell('SAMPLE ID'),
                          _buildHeaderCell('PATIENT'),
                          _buildHeaderCell('TESTS'),
                          _buildHeaderCell('KEY DIAG VAL'),
                          _buildHeaderCell('DISPATCH TIME'),
                          _buildHeaderCell('ACTIONS'),
                        ],
                      ),
                      // Data Rows
                      ...filteredReports.map((report) {
                        final isAbnormal = report['isAbnormal'] as bool;
                        final color = isAbnormal
                            ? AppColors.error
                            : AppColors.success;

                        return TableRow(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.border,
                                width: 0.5,
                              ),
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                report['sampleId'] as String,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    report['patientName'] as String,
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    report['mrn'] as String,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.secondaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildTextCell(report['tests'] as String),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      report['keyResult'] as String,
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildTextCell(report['time'] as String),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    child: const Icon(
                                      Icons.visibility_rounded,
                                      color: AppColors.primary,
                                      size: 18,
                                    ),
                                    onTap: () => _showPrintConfirm(
                                      report['patientName'] as String,
                                    ),
                                  ),

                                  const SizedBox(width: 12),
                                  GestureDetector(
                                    child: const Icon(
                                      Icons.picture_as_pdf_rounded,
                                      color: AppColors.error,
                                      size: 18,
                                    ),
                                    onTap: () => _showDownloadConfirm(
                                      report['patientName'] as String,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  GestureDetector(
                                    child: const Icon(
                                      Icons.print_rounded,
                                      color: AppColors.success,
                                      size: 18,
                                    ),
                                    onTap: () => _showPrintConfirm(
                                      report['patientName'] as String,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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

  void _showPrintConfirm(String patient) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.success,
        content: Text('Report queued for printing: $patient.'),
      ),
    );
  }

  void _showDownloadConfirm(String patient) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        content: Text('Downloading PDF report for $patient...'),
      ),
    );
  }

  Widget _buildHeaderCell(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(text, style: AppTextStyles.bodyMedium),
    );
  }
}
