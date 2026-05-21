import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class CompletedReportsTab extends StatefulWidget {
  const CompletedReportsTab({super.key});

  @override
  State<CompletedReportsTab> createState() => _CompletedReportsTabState();
}

class _CompletedReportsTabState extends State<CompletedReportsTab> {
  final List<Map<String, dynamic>> _reports = [
    {
      'id': 'REP-5510',
      'patient': 'Devender Negi',
      'mrn': 'MRN-4412',
      'modality': 'CT Chest',
      'date': '2026-05-20',
      'physician': 'Dr. Vineet Roy',
      'radiologist': 'Dr. Meera Gupta',
      'status': 'Signed Off',
    },
    {
      'id': 'REP-5509',
      'patient': 'Sunita Rao',
      'mrn': 'MRN-6091',
      'modality': 'MRI Brain Contrast',
      'date': '2026-05-19',
      'physician': 'Dr. Alok Verma',
      'radiologist': 'Dr. Meera Gupta',
      'status': 'Signed Off',
    },
    {
      'id': 'REP-5508',
      'patient': 'Amit Kumar',
      'mrn': 'MRN-8812',
      'modality': 'X-Ray Lumbar Spine',
      'date': '2026-05-18',
      'physician': 'Dr. S. K. Nayak',
      'radiologist': 'Dr. Rajesh Sen',
      'status': 'Signed Off',
    },
    {
      'id': 'REP-5507',
      'patient': 'Heena Begum',
      'mrn': 'MRN-1090',
      'modality': 'USG Pelvis',
      'date': '2026-05-17',
      'physician': 'Dr. Alok Verma',
      'radiologist': 'Dr. Meera Gupta',
      'status': 'Signed Off',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.archive_outlined,
                      color: AppColors.success,
                      size: 22,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Approved Clinical Report Archives',
                      style: AppTextStyles.titleSmall,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${_reports.length} Reports Archived',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.border, height: 1),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 800),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(1.2),
                  1: FlexColumnWidth(2.0),
                  2: FlexColumnWidth(1.5),
                  3: FlexColumnWidth(1.5),
                  4: FlexColumnWidth(1.8),
                  5: FlexColumnWidth(1.2),
                  6: FlexColumnWidth(1.5),
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                    ),
                    children: [
                      _headerCell('Report ID'),
                      _headerCell('Patient / MRN'),
                      _headerCell('Imaging Modality'),
                      _headerCell('Signed Date'),
                      _headerCell('Interpreting Radiologist'),
                      _headerCell('Status'),
                      _headerCell('Report Action'),
                    ],
                  ),
                  ..._reports.map((item) => _buildRow(item)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildRow(Map<String, dynamic> item) {
    final id = item['id'] as String;
    final patient = item['patient'] as String;
    final mrn = item['mrn'] as String;
    final modality = item['modality'] as String;
    final date = item['date'] as String;
    final radiologist = item['radiologist'] as String;
    final status = item['status'] as String;
    final physician = item['physician'] as String;
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      children: [
        _dataCell(id, isBold: true),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                patient,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(mrn, style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        _dataCell(modality),
        _dataCell(date),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Row(
            children: [
              const Icon(
                Icons.verified_user_rounded,
                color: AppColors.success,
                size: 14,
              ),
              const SizedBox(width: 6),
              Text(radiologist, style: AppTextStyles.bodyMedium),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                status,
                style: const TextStyle(
                  color: AppColors.success,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.picture_as_pdf_rounded,
                  color: AppColors.error,
                  size: 20,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Downloading PDF report for $id...'),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.share_rounded,
                  color: AppColors.primaryLight,
                  size: 18,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Sharing report $id with referring clinician $physician',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _headerCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Text(
        text,
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.secondaryText,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _dataCell(String text, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.primaryText,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
