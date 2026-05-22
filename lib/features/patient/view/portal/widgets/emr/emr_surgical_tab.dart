import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class EMRSurgicalTab extends StatelessWidget {
  const EMRSurgicalTab({super.key});

  static const List<Map<String, dynamic>> _surgeries = [
    {
      'procedure': 'Right Knee Diagnostic & Therapeutic Arthroscopy',
      'date': '05 Mar 2025',
      'indication': 'Medial meniscus bucket-handle tear',
      'surgeon': 'Dr. Anil Gupta (Orthopaedic Surgery)',
      'anesthesia': 'General Anesthesia (Sevoflurane)',
      'status': 'Fully Recovered',
      'statusColor': AppColors.success,
      'facility': 'Max Hospital, Dehradun',
      'pmjayApproved': true,
      'claimAmount': '₹12,400',
    },
    {
      'procedure': 'Laparoscopic Appendectomy',
      'date': '12 Oct 2019',
      'indication': 'Acute suppurative appendicitis',
      'surgeon': 'Dr. S. K. Sood (General Surgery)',
      'anesthesia': 'Spinal Anesthesia',
      'status': 'Historical Record',
      'statusColor': AppColors.secondaryText,
      'facility': 'Doon Hospital, Dehradun',
      'pmjayApproved': false,
      'claimAmount': '',
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
            Text('SURGICAL & PROCEDURE LOGS', style: AppTextStyles.labelSmall),
            Icon(
              Icons.biotech_rounded,
              color: AppColors.primaryLight,
              size: 16,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _surgeries.length,
          itemBuilder: (context, index) {
            final surgery = _surgeries[index];
            final statusColor = surgery['statusColor'] as Color;

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
                      Expanded(
                        child: Text(
                          surgery['procedure'] as String,
                          style: AppTextStyles.labelLarge.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          surgery['status'] as String,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: statusColor,
                            fontSize: 8.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildMetaRow('Date of Procedure', surgery['date'] as String),
                  _buildMetaRow('Indication', surgery['indication'] as String),
                  _buildMetaRow(
                    'Operating Surgeon',
                    surgery['surgeon'] as String,
                  ),
                  _buildMetaRow(
                    'Anesthesia Type',
                    surgery['anesthesia'] as String,
                  ),
                  _buildMetaRow(
                    'Clinical Facility',
                    surgery['facility'] as String,
                  ),

                  if (surgery['pmjayApproved'] as bool) ...[
                    const SizedBox(height: 10),
                    const Divider(color: AppColors.border, height: 1),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: AppColors.success.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.card_membership_rounded,
                                color: AppColors.success,
                                size: 10,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'AB-PMJAY COVERED',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.success,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          'Claim Settled: ',
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          surgery['claimAmount'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
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
