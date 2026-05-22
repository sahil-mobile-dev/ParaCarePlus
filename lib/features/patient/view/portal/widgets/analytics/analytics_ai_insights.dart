import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AnalyticsAiInsights extends StatelessWidget {
  const AnalyticsAiInsights({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        var crossAxisCount = 1;
        if (width > 1200) {
          crossAxisCount = 4;
        } else if (width > 800) {
          crossAxisCount = 2;
        }

        final cards = _getInsights();

        if (crossAxisCount == 1) {
          return Column(
            children: cards
                .map(
                  (c) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: _AiInsightCard(insight: c),
                  ),
                )
                .toList(),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 1.35,
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return _AiInsightCard(insight: cards[index]);
          },
        );
      },
    );
  }

  List<_InsightData> _getInsights() {
    return [
      _InsightData(
        badgeText: 'HIGH RISK',
        badgeColor: AppColors.error,
        title: 'Cardiovascular Risk Elevated',
        description:
            'Combined BP 128/82, cholesterol 218, BMI 26.2, and family history of hypertension increases 10-year CVD risk to ~42%. lifestyle modification urgently recommended.',
        actionText: 'View Cardiology Report',
        icon: Icons.warning_amber_rounded,
      ),
      _InsightData(
        badgeText: 'MONITOR',
        badgeColor: AppColors.secondaryAccent,
        title: 'Diabetes Risk Trending Up',
        description:
            'Fasting sugar 142 mg/dL (pre-diabetic threshold 100-125 exceeded). HbA1c at 6.2% — borderline. Without dietary changes, full T2D onset estimated within 18-24 months.',
        actionText: 'Dietary Recommendations',
        icon: Icons.trending_up_rounded,
      ),
      _InsightData(
        badgeText: 'ACTION Required',
        badgeColor: AppColors.primaryLight,
        title: 'Activity Deficit — 4,820 Steps/day',
        description:
            'Current activity level 60% below WHO target of 8,000 steps/day. AI recommends 30-min brisk walk daily. This alone could reduce CV risk by 8% over 90 days.',
        actionText: 'Activity Plan',
        icon: Icons.directions_run_rounded,
      ),
      _InsightData(
        badgeText: 'SLEEP DEBT',
        badgeColor: const Color(0xFFC77DFF),
        title: 'Chronic Sleep Debt Detected',
        description:
            'Averaging 6.2 hrs vs 7-9hr recommendation — cumulative sleep debt of ~12.6 hrs/month. Associated with elevated cortisol, insulin resistance, and immune suppression.',
        actionText: 'Sleep Improvement Plan',
        icon: Icons.nightlight_round,
      ),
    ];
  }
}

class _InsightData {
  _InsightData({
    required this.badgeText,
    required this.badgeColor,
    required this.title,
    required this.description,
    required this.actionText,
    required this.icon,
  });

  final String badgeText;
  final Color badgeColor;
  final String title;
  final String description;
  final String actionText;
  final IconData icon;
}

class _AiInsightCard extends StatelessWidget {
  const _AiInsightCard({required this.insight});
  final _InsightData insight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'AI',
                style: TextStyle(
                  color: AppColors.primaryLight,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: insight.badgeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.round),
                  border: Border.all(
                    color: insight.badgeColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(insight.icon, color: insight.badgeColor, size: 10),
                    const SizedBox(width: 4),
                    Text(
                      insight.badgeText.toUpperCase(),
                      style: TextStyle(
                        color: insight.badgeColor,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                insight.title,
                style: AppTextStyles.labelLarge.copyWith(fontSize: 13),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                insight.description,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 10.5,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.card,
                      content: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: AppColors.primaryLight,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Opening ${insight.actionText}…',
                            style: const TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      insight.actionText,
                      style: const TextStyle(
                        color: AppColors.primaryLight,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.5,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_right_alt_rounded,
                      color: AppColors.primaryLight,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
