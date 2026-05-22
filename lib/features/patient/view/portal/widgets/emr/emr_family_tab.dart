import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class EMRFamilyTab extends StatelessWidget {
  const EMRFamilyTab({super.key});

  static const List<Map<String, dynamic>> _familyMembers = [
    {
      'relation': 'Father',
      'status': 'Living (Age 74)',
      'conditions': ['Type-2 Diabetes Mellitus', 'Essential Hypertension'],
      'notes':
          'Diagnosed at age 52. Managed via insulin and oral antihypertensives.',
    },
    {
      'relation': 'Mother',
      'status': 'Living (Age 70)',
      'conditions': ['Hyperlipidemia', 'Osteoarthritis'],
      'notes':
          'Diagnosed at age 58. Cholesterol managed via lifestyle and statins.',
    },
    {
      'relation': 'Paternal Grandfather',
      'status': 'Deceased (Age 78)',
      'conditions': ['Ischemic Heart Disease (CAD)', 'Myocardial Infarction'],
      'notes': 'Suffered fatal myocardial infarction at age 78.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // AI Genetic Familial Risk Profiler Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withValues(alpha: 0.15),
                AppColors.surface.withValues(alpha: 0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.3),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.psychology_rounded,
                    color: AppColors.secondaryAccent,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'AI GENETIC FAMILIAL RISK ANALYSIS',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.secondaryAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Based on reported family conditions (paternal CAD, maternal/paternal hyperlipidemia & diabetes), the relative genetic risk factors are computed below:',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
              ),
              const SizedBox(height: AppSpacing.sm),
              _buildRiskIndicator(
                'Type-2 Diabetes Susceptibility',
                0.65,
                AppColors.secondaryAccent,
              ),
              const SizedBox(height: 6),
              _buildRiskIndicator(
                'Cardiovascular Disease (CAD) Risk',
                0.78,
                AppColors.error,
              ),
              const SizedBox(height: 6),
              _buildRiskIndicator(
                'Hyperlipidemia Trait Propensity',
                0.50,
                AppColors.primaryLight,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        const Text(
          'HEREDITARY HEALTH TIMELINES',
          style: AppTextStyles.labelSmall,
        ),
        const SizedBox(height: AppSpacing.sm),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _familyMembers.length,
          itemBuilder: (context, index) {
            final member = _familyMembers[index];
            final conditions = member['conditions'] as List<String>;

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
                      Text(
                        member['relation'] as String,
                        style: AppTextStyles.labelLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        member['status'] as String,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.secondaryText,
                          fontSize: 9.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: conditions
                        .map(
                          (c) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Text(
                              c,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  if (member['notes'] != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      member['notes'] as String,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 10,
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

  Widget _buildRiskIndicator(String title, double score, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 9.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${(score * 100).toInt()}% Risk',
              style: TextStyle(
                color: color,
                fontSize: 9.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2.5),
            child: LinearProgressIndicator(
              value: score,
              backgroundColor: AppColors.surface,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
      ],
    );
  }
}
