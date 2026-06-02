import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AiFeatureSuite extends StatefulWidget {
  const AiFeatureSuite({super.key});

  @override
  State<AiFeatureSuite> createState() => _AiFeatureSuiteState();
}

class _AiFeatureSuiteState extends State<AiFeatureSuite> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final features = <Map<String, dynamic>>[
      {
        'title': 'Symptom Checker',
        'desc': 'NLP differential diagnosis from 12k+ symptom patterns',
        'badge': 'LIVE',
        'badgeColor': AppColors.primaryLight,
        'icon': Icons.healing_rounded,
        'iconColor': AppColors.error,
      },
      {
        'title': 'Drug Interaction AI',
        'desc': 'Cross-checks active medications for adverse interactions',
        'badge': 'LIVE',
        'badgeColor': AppColors.primaryLight,
        'icon': Icons.medication_rounded,
        'iconColor': AppColors.secondaryAccent,
      },
      {
        'title': 'Predictive Risk Engine',
        'desc': 'ML models predicting disease onset 6–18 months ahead',
        'badge': 'LIVE',
        'badgeColor': AppColors.primaryLight,
        'icon': Icons.analytics_rounded,
        'iconColor': AppColors.primaryLight,
      },
      {
        'title': 'Mental Health Bot',
        'desc': 'CBT-based conversational therapy, mood tracking',
        'badge': 'BETA',
        'badgeColor': Colors.purpleAccent,
        'icon': Icons.psychology_rounded,
        'iconColor': Colors.purpleAccent,
      },
      {
        'title': 'Radiology AI',
        'desc': 'Deep learning scan analysis of X-Ray, CT, MRI scans',
        'badge': 'BETA',
        'badgeColor': Colors.purpleAccent,
        'icon': Icons.image_rounded,
        'iconColor': Colors.indigoAccent,
      },
      {
        'title': 'Lab Interpretation AI',
        'desc': 'Contextual analysis of 200+ lab parameters with trends',
        'badge': 'LIVE',
        'badgeColor': AppColors.primaryLight,
        'icon': Icons.biotech_rounded,
        'iconColor': AppColors.success,
      },
      {
        'title': 'Diet & Nutrition AI',
        'desc': 'Meal plans for T2D + Hypertension, ICMR-NIN aligned',
        'badge': 'NEW',
        'badgeColor': AppColors.success,
        'icon': Icons.restaurant_menu_rounded,
        'iconColor': Colors.teal,
      },
      {
        'title': 'Activity & Fitness AI',
        'desc': 'Adaptive exercise plans from wearable data, METS intensity',
        'badge': 'NEW',
        'badgeColor': AppColors.success,
        'icon': Icons.directions_run_rounded,
        'iconColor': AppColors.primaryLight,
      },
      {
        'title': 'Sleep Analysis AI',
        'desc': 'Sleep stage classification, apnoea risk detection',
        'badge': 'BETA',
        'badgeColor': Colors.purpleAccent,
        'icon': Icons.nights_stay_rounded,
        'iconColor': Colors.purple,
      },
      {
        'title': 'Medication AI Coach',
        'desc': 'Smart reminders, side-effect early-warning system',
        'badge': 'LIVE',
        'badgeColor': AppColors.primaryLight,
        'icon': Icons.alarm_on_rounded,
        'iconColor': Colors.orange,
      },
      {
        'title': 'Appointment AI',
        'desc': 'Smart scheduling with urgency triage, doctor matching',
        'badge': 'LIVE',
        'badgeColor': AppColors.primaryLight,
        'icon': Icons.calendar_month_rounded,
        'iconColor': Colors.tealAccent,
      },
      {
        'title': 'eSanjeevani Bridge',
        'desc': 'Govt. telemedicine platform integration, ABDM-linked',
        'badge': 'LIVE',
        'badgeColor': AppColors.primaryLight,
        'icon': Icons.video_call_rounded,
        'iconColor': AppColors.success,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Row(
          children: [
            Icon(Icons.grid_view_rounded, color: Colors.purpleAccent, size: 18),
            SizedBox(width: 8),
            Text(
              'AI FEATURE SUITE — 12 INTELLIGENT MODULES',
              style: AppTextStyles.labelSmall,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: features.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.sm,
                mainAxisSpacing: AppSpacing.sm,
                childAspectRatio: 1.6,
              ),
              itemBuilder: (context, index) {
                final feat = features[index];
                final iconColor = feat['iconColor'] as Color;
                final isActive = _activeIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _activeIndex = index;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Activated ${feat['title']} workspace module context.',
                        ),
                        backgroundColor: iconColor,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.surface : AppColors.card,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isActive
                            ? Colors.purpleAccent
                            : AppColors.border,
                        width: isActive ? 1.5 : 1,
                      ),
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: Colors.purpleAccent.withValues(
                                  alpha: 0.15,
                                ),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (feat['badgeColor'] as Color).withValues(
                                alpha: 0.15,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              feat['badge'] as String,
                              style: TextStyle(
                                color: feat['badgeColor'] as Color,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: iconColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                feat['icon'] as IconData,
                                color: iconColor,
                                size: 16,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              feat['title'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              feat['desc'] as String,
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 9.5,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
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
