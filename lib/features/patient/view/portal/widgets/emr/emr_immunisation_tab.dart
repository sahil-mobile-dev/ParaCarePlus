import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class EMRImmunisationTab extends StatelessWidget {
  const EMRImmunisationTab({super.key});

  static const List<Map<String, dynamic>> _vaccines = [
    {
      'name': 'COVID-19 Booster (5th Dose) — Covaxin',
      'date': '02 Apr 2026',
      'batch': 'COV-8827A-26',
      'status': 'Administered',
      'facility': 'AIIMS Rishikesh OPD Section',
      'verified': true,
      'notes':
          'No immediate adverse reactions reported. 15-min post observations clear.',
    },
    {
      'name': 'Influenza Vaccine (Quadrivalent) — Fluarix Tetra',
      'date': '12 Oct 2025',
      'batch': 'FLU-TX889-25',
      'status': 'Administered',
      'facility': 'Doon Hospital, Dehradun',
      'verified': true,
      'notes': 'Annual routine booster. No reactions noted.',
    },
    {
      'name': 'Pneumococcal Vaccine (PCV13) — Prevenar 13',
      'date': '15 Jul 2024',
      'batch': 'PNE-PV776-24',
      'status': 'Administered',
      'facility': 'Max Hospital, Dehradun',
      'verified': true,
      'notes': 'High-risk prevention protocol due to borderline hypertension.',
    },
    {
      'name': 'Tetanus Toxoid Booster (TT)',
      'date': '04 Mar 2024',
      'batch': 'TT-BOOST-89',
      'status': 'Administered',
      'facility': 'Rishikesh Primary Health Center',
      'verified': false,
      'notes': 'Administered post minor laceration. CoWIN sync pending.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // CoWIN Government Registry Verification Panel
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.success.withValues(alpha: 0.3),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified_rounded,
                  color: AppColors.success,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'COWIN CENTRAL REGISTRY LINKED',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      '3 of 4 immunisation events verified and synced with National Health Authority digital database.',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 10,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'IMMUNISATION HISTORY LEDGER',
              style: AppTextStyles.labelSmall,
            ),
            Icon(
              Icons.vaccines_rounded,
              color: AppColors.primaryLight,
              size: 16,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _vaccines.length,
          itemBuilder: (context, index) {
            final vac = _vaccines[index];
            final verified = vac['verified'] as bool;

            return Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              padding: const EdgeInsets.all(12),
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
                          vac['name'] as String,
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
                          color: AppColors.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Given',
                          style: TextStyle(
                            color: AppColors.success,
                            fontSize: 8.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Text(
                        'Date: ',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        vac['date'] as String,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Batch: ',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        vac['batch'] as String,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        'Center: ',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          vac['facility'] as String,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (vac['notes'] != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      vac['notes'] as String,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  const Divider(color: AppColors.border, height: 1),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Spacer(),
                      if (verified)
                        Row(
                          children: [
                            const Icon(
                              Icons.verified_user_rounded,
                              color: AppColors.success,
                              size: 10,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'CoWIN Verified Record',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.success,
                                fontSize: 8.5,
                              ),
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            const Icon(
                              Icons.sync_problem_rounded,
                              color: AppColors.secondaryAccent,
                              size: 10,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Self-Uploaded (Sync Pending)',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.secondaryAccent,
                                fontSize: 8.5,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
