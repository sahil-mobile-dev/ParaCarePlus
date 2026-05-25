import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AiPredictiveRisks extends StatelessWidget {
  const AiPredictiveRisks({super.key});

  @override
  Widget build(BuildContext context) {
    final risks = <Map<String, dynamic>>[
      {
        'title': 'Type 2 Diabetes Risk',
        'prob': '68%',
        'icon': Icons.bloodtype_rounded,
        'iconColor': AppColors.error,
        'metrics': [
          {
            'lbl': 'Without intervention',
            'val': 0.68,
            'color': AppColors.error,
          },
          {
            'lbl': 'With AI plan followed',
            'val': 0.31,
            'color': AppColors.success,
          },
        ],
        'insight':
            'Key drivers: FBG 108 mg/dL, BMI 27.8, family history (father), HbA1c trend +0.2%/yr. ICMR Diabetes Prevention Protocol recommended.',
      },
      {
        'title': 'Cardiovascular Event Risk',
        'prob': '42%',
        'icon': Icons.heart_broken_rounded,
        'iconColor': AppColors.secondaryAccent,
        'metrics': [
          {
            'lbl': 'Without intervention',
            'val': 0.42,
            'color': AppColors.secondaryAccent,
          },
          {
            'lbl': 'With statin + lifestyle',
            'val': 0.24,
            'color': AppColors.success,
          },
        ],
        'insight':
            'LDL 142 mg/dL, SBP avg 144, smoking-free positive. Framingham + QRISK3 ensemble model. Statin escalation considered.',
      },
      {
        'title': 'Hypertensive Crisis Risk',
        'prob': '22%',
        'icon': Icons.bolt_rounded,
        'iconColor': Colors.orange,
        'metrics': [
          {'lbl': 'Without intervention', 'val': 0.22, 'color': Colors.orange},
          {
            'lbl': 'With medication adherence',
            'val': 0.08,
            'color': AppColors.success,
          },
        ],
        'insight':
            'BP variability index 18.4, 3 missed doses last week, sodium intake high. Real-time BP monitoring recommended (daily readings).',
      },
      {
        'title': 'NAFLD / Metabolic Risk',
        'prob': '35%',
        'icon': Icons.scale_rounded,
        'iconColor': Colors.purpleAccent,
        'metrics': [
          {
            'lbl': 'NASH Progression Risk',
            'val': 0.35,
            'color': Colors.purpleAccent,
          },
          {
            'lbl': 'With weight reduction 5%',
            'val': 0.18,
            'color': AppColors.success,
          },
        ],
        'insight':
            'ALT 48 U/L (borderline), BMI 27.8, triglycerides 162. FIB-4 score: 1.12. Fibroscan USG recommended within 3 months.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.online_prediction_rounded,
                  color: AppColors.primaryLight,
                  size: 18,
                ),
                SizedBox(width: 8),
                Text(
                  'AI PREDICTIVE RISK ANALYSIS\nML MODEL OUTPUTS',
                  style: AppTextStyles.labelSmall,
                ),
              ],
            ),
            Text(
              'Model: ParaCare-ML v2.1',
              style: TextStyle(color: AppColors.secondaryText, fontSize: 8.5),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final crossAxisCount = width > 900 ? 2 : 1;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: risks.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: AppSpacing.sm,
                mainAxisSpacing: AppSpacing.sm,
                childAspectRatio: width > 900 ? 1.6 : 1.7,
              ),
              itemBuilder: (context, index) {
                final r = risks[index];
                final iconColor = r['iconColor'] as Color;
                final metrics = r['metrics'] as List<Map<String, dynamic>>;

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Icon(
                            r['icon'] as IconData,
                            color: iconColor,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              r['title'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            r['prob'] as String,
                            style: TextStyle(
                              color: iconColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: metrics.map((m) {
                          final val = m['val'] as double;
                          final color = m['color'] as Color;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      m['lbl'] as String,
                                      style: const TextStyle(
                                        color: AppColors.secondaryText,
                                        fontSize: 9.5,
                                      ),
                                    ),
                                    Text(
                                      '${(val * 100).toInt()}%',
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: LinearProgressIndicator(
                                    value: val,
                                    backgroundColor: Colors.white.withValues(
                                      alpha: 0.06,
                                    ),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      color,
                                    ),
                                    minHeight: 5,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.only(top: 6),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: AppColors.border,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Text(
                          r['insight'] as String,
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 9,
                            height: 1.25,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
