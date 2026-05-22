import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class EMRCertificatesTab extends StatelessWidget {
  const EMRCertificatesTab({super.key});

  static const List<Map<String, dynamic>> _certificates = [
    {
      'certId': 'NHA-MC-2026-08872',
      'title': 'Medical Fitness & Physical Clearance Certificate',
      'date': '12 May 2026',
      'doctor': 'Dr. Suresh Rawat (Medicine)',
      'purpose': 'Employment Clearance - Annual Review',
      'status': 'Active / Valid',
      'statusColor': AppColors.success,
    },
    {
      'certId': 'NHA-MC-2025-04281',
      'title': 'Clinical Sick Leave & Rest Recommendation',
      'date': '14 Nov 2025',
      'doctor': 'Dr. Vikas Mehta (Emergency)',
      'purpose':
          'Excused Leave (3 days bed rest recommended post hypertensive crisis)',
      'status': 'Expired / Historical',
      'statusColor': AppColors.secondaryText,
    },
    {
      'certId': 'COWIN-VC-77638A',
      'title': 'National Covid-19 Universal Vaccination Certificate',
      'date': '02 Apr 2026',
      'doctor': 'Ministry of Health & Family Welfare (MoHFW)',
      'purpose': 'International Travel & Universal Health ID verification',
      'status': 'Verified / Lifetime',
      'statusColor': AppColors.success,
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
            Text(
              'HEALTH & MEDICAL CERTIFICATES',
              style: AppTextStyles.labelSmall,
            ),
            Icon(
              Icons.verified_user_rounded,
              color: AppColors.primaryLight,
              size: 16,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _certificates.length,
          itemBuilder: (context, index) {
            final cert = _certificates[index];
            final statusColor = cert['statusColor'] as Color;

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
                          cert['certId'] as String,
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
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          cert['status'] as String,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: statusColor,
                            fontSize: 8.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    cert['title'] as String,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildMetaRow('Date of Issue', cert['date'] as String),
                  _buildMetaRow('Issued By', cert['doctor'] as String),
                  _buildMetaRow('Purpose / Detail', cert['purpose'] as String),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Downloading verified PDF Certificate ${cert['certId']}...',
                            ),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.success,
                        side: const BorderSide(color: AppColors.success),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.verified_rounded, size: 16),
                      label: const Text(
                        'DOWNLOAD SIGNED DIGITAL PDF',
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
