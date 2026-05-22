import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class EMRNotesTab extends StatelessWidget {
  const EMRNotesTab({super.key});

  static const List<Map<String, dynamic>> _notes = [
    {
      'date': '12 May 2026',
      'doctor': 'Dr. Priya Negi',
      'dept': 'Endocrinology',
      'title': 'Metformin Dosing Adjustment',
      'content':
          'Reviewed blood glucose logs. HbA1c at 7.4% is slightly elevated. Patient reports compliance with current dosage. Upgraded Metformin to 850mg BD to achieve stricter control. Stressed strict adherence to diabetic nutrition plan. Next review in 12 weeks with fresh HbA1c.',
      'tag': 'Therapeutic Plan',
    },
    {
      'date': '02 Apr 2026',
      'doctor': 'Dr. Anjali Sharma',
      'dept': 'Cardiology & Vascular Medicine',
      'title': 'Post-ECG Routine Review',
      'content':
          'Electrocardiogram shows normal sinus rhythm at 72 bpm. Mild Left Ventricular Hypertrophy (LVH) remains stable and consistent with long-term hypertension. Ejection fraction at 55%. Instructed patient to maintain home blood pressure records twice daily and present at next OPD. Continue Losartan 50mg and Amlodipine 5mg.',
      'tag': 'Diagnostic Summary',
    },
    {
      'date': '18 Feb 2026',
      'doctor': 'Dr. Suresh Rawat',
      'dept': 'Internal Medicine',
      'title': 'Hypertension Protocol Upgrade',
      'content':
          'Patient presents following a hypertensive incident. Current BP is 134/86 mmHg. Decided to upgrade treatment by introducing Losartan 50mg to current Amlodipine therapy. Counseled on low-sodium dietary habits. Patient educated on warnings signs (sudden severe headache, chest distress, visual spots) to trigger immediate emergency contact.',
      'tag': 'Emergency Follow-Up',
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
            Text('CLINICAL CONSULTING NOTES', style: AppTextStyles.labelSmall),
            Icon(
              Icons.rate_review_rounded,
              color: AppColors.primaryLight,
              size: 16,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _notes.length,
          itemBuilder: (context, index) {
            final note = _notes[index];

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
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          note['tag'] as String,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.primaryLight,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        note['date'] as String,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 9.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    note['title'] as String,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_rounded,
                        color: AppColors.secondaryText,
                        size: 11,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${note['doctor']} (${note['dept']})',
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: AppColors.border, height: 1),
                  const SizedBox(height: 10),
                  Text(
                    note['content'] as String,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      height: 1.45,
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
}
