import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class EMRDiagnosesTab extends StatelessWidget {
  const EMRDiagnosesTab({super.key});

  static const List<Map<String, dynamic>> _diagnoses = [
    {
      'code': 'ICD-10 I10',
      'title': 'Essential (Primary) Hypertension',
      'status': 'Active',
      'statusColor': AppColors.error,
      'date': '12 Jan 2024',
      'severity': 0.7,
      'severityText': 'Moderate-High',
      'doctor': 'Dr. Suresh Rawat',
      'notes': 'Daily monitoring required. Target BP <130/80 mmHg.',
    },
    {
      'code': 'ICD-10 R73.09',
      'title': 'Borderline Pre-Diabetes',
      'status': 'Monitored',
      'statusColor': AppColors.secondaryAccent,
      'date': '15 May 2024',
      'severity': 0.4,
      'severityText': 'Mild-Moderate',
      'doctor': 'Dr. Rajesh Kumar',
      'notes': 'Lifestyle modifications, low GI carbohydrate diet.',
    },
    {
      'code': 'ICD-10 E78.5',
      'title': 'Hyperlipidemia, Unspecified',
      'status': 'Controlled',
      'statusColor': AppColors.success,
      'date': '08 Nov 2024',
      'severity': 0.3,
      'severityText': 'Mild / Stable',
      'doctor': 'Dr. Suresh Rawat',
      'notes': 'Managed via low-dose atorvastatin. Responds well.',
    },
    {
      'code': 'ICD-10 M23.22',
      'title': 'Meniscus Tear, Right Knee',
      'status': 'Resolved (Post-Op)',
      'statusColor': AppColors.success,
      'date': '05 Mar 2025',
      'severity': 0.1,
      'severityText': 'Recovered',
      'doctor': 'Dr. Anil Gupta',
      'notes': 'Post arthroscopy recovery complete. Full ROM achieved.',
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
            Text('ICD-10 CLINICAL DIAGNOSES', style: AppTextStyles.labelSmall),
            Icon(
              Icons.assignment_turned_in_rounded,
              color: AppColors.primaryLight,
              size: 16,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _diagnoses.length,
          itemBuilder: (context, index) {
            final diag = _diagnoses[index];
            final statusColor = diag['statusColor'] as Color;
            final severity = diag['severity'] as double;

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
                          diag['code'] as String,
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
                          diag['status'] as String,
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
                    diag['title'] as String,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        'Diagnosed on: ',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        diag['date'] as String,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'By: ',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        diag['doctor'] as String,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: AppColors.border, height: 1),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        'Severity Index: ',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        diag['severityText'] as String,
                        style: TextStyle(
                          color: severity > 0.5
                              ? AppColors.error
                              : (severity > 0.2
                                    ? AppColors.secondaryAccent
                                    : AppColors.success),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 100,
                        height: 6,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(
                            value: severity,
                            backgroundColor: AppColors.surface,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              severity > 0.5
                                  ? AppColors.error
                                  : (severity > 0.2
                                        ? AppColors.secondaryAccent
                                        : AppColors.success),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (diag['notes'] != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.surface.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        diag['notes'] as String,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
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
}
