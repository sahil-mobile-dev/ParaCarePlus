import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class ChronicAiRisk extends StatelessWidget {
  const ChronicAiRisk({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 900
            ? 4
            : (constraints.maxWidth > 600 ? 2 : 1);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.psychology_outlined,
                  color: AppColors.error,
                  size: 18,
                ),
                SizedBox(width: 8),
                Text(
                  'AI RISK PREDICTION (5-YEAR OUTLOOK)',
                  style: AppTextStyles.labelSmall,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.5,
              children: [
                _buildRiskCard(
                  name: 'Type 2 Diabetes',
                  source: 'AI Prediction',
                  percentage: '68%',
                  riskValue: 0.68,
                  color: AppColors.error,
                  desc:
                      'Pre-diabetic HbA1c 6.2% + family history + sedentary lifestyle = high T2D risk. Lifestyle intervention can reduce risk by 40%.',
                ),
                _buildRiskCard(
                  name: 'Cardiovascular Event',
                  source: 'Framingham Score',
                  percentage: '42%',
                  riskValue: 0.42,
                  color: AppColors.secondaryAccent,
                  desc:
                      '10-year CV event risk (Framingham). BP + cholesterol + BMI combination is significant. Medication compliance reduces risk by ~30%.',
                ),
                _buildRiskCard(
                  name: 'Hypertensive Crisis',
                  source: '12-month risk',
                  percentage: '22%',
                  riskValue: 0.22,
                  color: AppColors.secondaryAccent,
                  desc:
                      'Partially controlled BP with elevated stress index increases risk of hypertensive crisis. Consistent medication + stress reduction advised.',
                ),
                _buildRiskCard(
                  name: 'Non-Alcoholic Fatty Liver',
                  source: '5-year risk',
                  percentage: '35%',
                  riskValue: 0.35,
                  color: AppColors.secondaryAccent,
                  desc:
                      'Mild fatty liver Grade I on USG + pre-diabetes + elevated lipids = NAFLD progression risk. Liver function monitoring every 6 months advised.',
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildRiskCard({
    required String name,
    required String source,
    required String percentage,
    required double riskValue,
    required Color color,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      source,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                percentage,
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: riskValue,
            backgroundColor: Colors.white.withValues(alpha: 0.1),
            color: color,
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              desc,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 9.5,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
