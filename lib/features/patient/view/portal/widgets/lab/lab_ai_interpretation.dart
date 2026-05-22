import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class LabAiInterpretation extends StatelessWidget {
  const LabAiInterpretation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryLight.withValues(alpha: 0.1),
            AppColors.primary.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: AppColors.primaryLight.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.smart_toy_rounded,
                color: AppColors.primaryLight,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'AI Lab Interpretation — Latest Batch (10 May 2026)',
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'AI-POWERED',
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              var columns = 1;
              if (width > 900) {
                columns = 4;
              } else if (width > 550) {
                columns = 2;
              }

              final findings = _getFindings();

              if (columns == 1) {
                return Column(
                  children: findings
                      .map(
                        (f) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: _FindingBox(finding: f),
                        ),
                      )
                      .toList(),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: AppSpacing.sm,
                  mainAxisSpacing: AppSpacing.sm,
                  childAspectRatio: 1.45,
                ),
                itemCount: findings.length,
                itemBuilder: (context, index) {
                  return _FindingBox(finding: findings[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  List<_FindingData> _getFindings() {
    return [
      _FindingData(
        tag: 'HIGH ALERT',
        tagColor: AppColors.error,
        description:
            'LDL 138 mg/dL — significantly above optimal (<100 mg/dL). Atherogenic risk elevated. Immediate dietary fat reduction and statin therapy review recommended.',
        icon: Icons.error_outline_rounded,
      ),
      _FindingData(
        tag: 'MONITOR',
        tagColor: AppColors.secondaryAccent,
        description:
            'Fasting Glucose 142 mg/dL — pre-diabetic range (126+ = T2D threshold). Repeat OGTT test recommended within 30 days to rule out T2D onset.',
        icon: Icons.offline_bolt_rounded,
      ),
      _FindingData(
        tag: 'BORDERLINE',
        tagColor: AppColors.secondaryAccent,
        description:
            'HbA1c 6.2% — above normal (<5.7%). Consistent with pre-diabetes. 3-month glycemic control review essential. Consider metformin discussion with physician.',
        icon: Icons.hourglass_empty_rounded,
      ),
      _FindingData(
        tag: 'NORMAL',
        tagColor: AppColors.success,
        description:
            'CBC, Kidney Function, Liver Panel — all within normal reference ranges. No anemia detected (Hb 13.8 g/dL). eGFR 82 mL/min — adequate renal function.',
        icon: Icons.check_circle_outline_rounded,
      ),
    ];
  }
}

class _FindingData {
  _FindingData({
    required this.tag,
    required this.tagColor,
    required this.description,
    required this.icon,
  });

  final String tag;
  final Color tagColor;
  final String description;
  final IconData icon;
}

class _FindingBox extends StatelessWidget {
  const _FindingBox({required this.finding});
  final _FindingData finding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: finding.tagColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: finding.tagColor.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(finding.icon, color: finding.tagColor, size: 10),
                const SizedBox(width: 4),
                Text(
                  finding.tag,
                  style: TextStyle(
                    color: finding.tagColor,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            finding.description,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 10,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
