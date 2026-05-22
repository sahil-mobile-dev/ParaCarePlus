import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class EMRDischargeTab extends StatelessWidget {
  const EMRDischargeTab({super.key});

  static const List<Map<String, dynamic>> _discharges = [
    {
      'ipdId': 'IPD-2025-09827',
      'diag': 'Acute Meniscus Bucket-Handle Tear (Right)',
      'admitted': '03 Mar 2025',
      'discharged': '06 Mar 2025',
      'stay': '3 Days',
      'facility': 'Max Hospital, Dehradun',
      'doctor': 'Dr. Anil Gupta (Orthopaedic Surgery)',
      'status': 'Discharged',
      'summary':
          'Patient underwent right knee arthroscopy under general anesthesia. Post-operative period was uneventful. Mobilized on Day 2 with knee brace. Discharged in stable condition with prescription and home physiotherapy instructions.',
    },
    {
      'ipdId': 'IPD-2025-04472',
      'diag': 'Hypertensive Urgency / Crisis',
      'admitted': '14 Nov 2025',
      'discharged': '15 Nov 2025',
      'stay': '1 Day (Short Stay Observation)',
      'facility': 'Doon Hospital, Dehradun',
      'doctor': 'Dr. Vikas Mehta (Emergency Medicine)',
      'status': 'Discharged',
      'summary':
          'Presented with BP 172/104 mmHg. Treated with IV Labetalol infusion and oral antihypertensives. Monitored for 24 hours. BP stabilized at 138/82 mmHg. Discharged with strict instructions for cardiology checkup and dosage modifications.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('IPD DISCHARGE SUMMARIES', style: AppTextStyles.labelSmall),
            Icon(
              Icons.home_work_rounded,
              color: AppColors.primaryLight,
              size: 16,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _discharges.length,
          itemBuilder: (context, index) {
            final summary = _discharges[index];

            return Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          summary['ipdId'] as String,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.primaryLight,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'COMPLETED',
                          style: TextStyle(
                            color: AppColors.success,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    summary['diag'] as String,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildMetaRow('Hospital', summary['facility'] as String),
                  _buildMetaRow('Admitted On', summary['admitted'] as String),
                  _buildMetaRow(
                    'Discharged On',
                    summary['discharged'] as String,
                  ),
                  _buildMetaRow('Duration of Stay', summary['stay'] as String),
                  _buildMetaRow(
                    'Chief Consultant',
                    summary['doctor'] as String,
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: AppColors.border, height: 1),
                  const SizedBox(height: 10),
                  const Text(
                    'Clinical Course & Discharge Advice:',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    summary['summary'] as String,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 10.5,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Downloading signed PDF Discharge Summary for ${summary['ipdId']}...',
                            ),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryLight,
                        side: const BorderSide(color: AppColors.primaryLight),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.download_rounded, size: 16),
                      label: const Text(
                        'DOWNLOAD FULL DISCHARGE REPORT',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMetaRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 10.5,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
