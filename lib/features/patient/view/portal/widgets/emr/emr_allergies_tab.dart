import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class EMRAllergiesTab extends StatelessWidget {
  const EMRAllergiesTab({super.key});

  static const List<Map<String, dynamic>> _allergies = [
    {
      'substance': 'Penicillin G / V',
      'type': 'Drug Allergy',
      'severity': 'HIGH SEVERITY',
      'color': AppColors.error,
      'reaction': 'Anaphylactoid reaction, acute skin hives, facial angioedema',
      'date': '14 Nov 2024',
      'verified': true,
    },
    {
      'substance': 'Sulfonamides / Sulfa Drugs',
      'type': 'Drug Allergy',
      'severity': 'MODERATE',
      'color': AppColors.secondaryAccent,
      'reaction': 'Maculopapular rash, drug fever, localized pruritus',
      'date': '22 May 2023',
      'verified': true,
    },
    {
      'substance': 'Peanuts & Tree Nuts',
      'type': 'Food Allergy',
      'severity': 'LOW / MILD',
      'color': AppColors.success,
      'reaction': 'Mild gastrointestinal discomfort, scratchy throat',
      'date': '10 Aug 2021',
      'verified': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Premium Red Alert Panel for High Severity Allergies
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.error.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: AppColors.error,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CRITICAL ALLERGY ALERT',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Patient has high anaphylaxis risk to Penicillin. Do NOT prescribe any Beta-lactam antibiotics without direct expert guidance.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
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
              'ALLERGENS & ADVERSE REACTIONS',
              style: AppTextStyles.labelSmall,
            ),
            Text(
              '3 Active Warnings',
              style: TextStyle(
                color: AppColors.secondaryText,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _allergies.length,
          itemBuilder: (context, index) {
            final allergy = _allergies[index];
            final color = allergy['color'] as Color;

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
                      Row(
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            color: color,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            allergy['substance'] as String,
                            style: AppTextStyles.labelLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: color.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          allergy['severity'] as String,
                          style: TextStyle(
                            color: color,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Reaction: ${allergy['reaction']}',
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(color: AppColors.border, height: 1),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Category: ${allergy['type']}',
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10,
                        ),
                      ),
                      const Spacer(),
                      if (allergy['verified'] as bool)
                        Row(
                          children: [
                            const Icon(
                              Icons.verified_user_rounded,
                              color: AppColors.success,
                              size: 10,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Verified Clinical Record',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.success,
                                fontSize: 8.5,
                              ),
                            ),
                          ],
                        )
                      else
                        Text(
                          'Self-Reported',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.secondaryText,
                            fontSize: 8.5,
                          ),
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
