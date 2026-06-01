import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class DrugInteractionChecker extends StatelessWidget {
  const DrugInteractionChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: AppColors.secondaryAccent,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                'Drug Interaction Checker',
                style: AppTextStyles.labelMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _buildInteractionItem(
            title: 'Metformin + Omeprazole — Moderate Interaction',
            desc:
                'Omeprazole may slightly increase Metformin plasma levels by inhibiting its renal transport. Monitor blood glucose. No dose change needed unless hyperglycemia worsens.',
            severity: 'moderate',
            color: AppColors.secondaryAccent,
            icon: Icons.medication_liquid_rounded,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildInteractionItem(
            title: 'Atorvastatin + Vitamin D3 — Minor / Beneficial',
            desc:
                'No clinically significant negative interaction. Vitamin D may enhance statin effectiveness in some patients. Continue as prescribed.',
            severity: 'minor',
            color: AppColors.success,
            icon: Icons.workspace_premium_rounded,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildInteractionItem(
            title: 'Amlodipine + Atorvastatin — Moderate Interaction',
            desc:
                'Amlodipine inhibits CYP3A4, increasing Atorvastatin levels. Risk of myopathy at higher statin doses. Current low-dose (10mg) combination is generally safe. Watch for muscle pain.',
            severity: 'moderate',
            color: AppColors.secondaryAccent,
            icon: Icons.error_outline_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionItem({
    required String title,
    required String desc,
    required String severity,
    required Color color,
    required IconData icon,
  }) {
    final bg = severity == 'moderate'
        ? AppColors.secondaryAccent.withValues(alpha: 0.06)
        : AppColors.success.withValues(alpha: 0.06);

    final border = severity == 'moderate'
        ? AppColors.secondaryAccent.withValues(alpha: 0.2)
        : AppColors.success.withValues(alpha: 0.15);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  desc,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 10,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
