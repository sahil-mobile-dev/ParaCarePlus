import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class WellnessCheckups extends StatelessWidget {
  const WellnessCheckups({super.key});

  @override
  Widget build(BuildContext context) {
    final checkups = <Map<String, dynamic>>[
      {
        'title': 'ECG + Cardiac Screening',
        'desc': 'Annual · Recommended for HTN patients',
        'due': 'Due: 20 May 2026',
        'dueColor': AppColors.error,
        'icon': Icons.heart_broken_rounded,
        'iconColor': AppColors.error,
        'actionLabel': 'Book',
        'actionMsg': 'Booking ECG appointment…',
      },
      {
        'title': 'OGTT (Oral Glucose Tolerance Test)',
        'desc': 'Every 3 months · Pre-diabetic monitoring',
        'due': 'Due: Jun 2026',
        'dueColor': AppColors.secondaryAccent,
        'icon': Icons.bloodtype_rounded,
        'iconColor': AppColors.secondaryAccent,
        'actionLabel': 'Schedule',
        'actionMsg': 'Scheduling OGTT…',
      },
      {
        'title': 'Full Body Checkup (Annual)',
        'desc': 'CBC + LFT + KFT + Lipid + Thyroid + Urine',
        'due': 'Done: May 2026 ✓',
        'dueColor': AppColors.success,
        'icon': Icons.biotech_rounded,
        'iconColor': AppColors.success,
        'actionLabel': null,
      },
      {
        'title': 'Eye Examination',
        'desc': 'Annual · Diabetic retinopathy screening',
        'due': 'Due: Aug 2026',
        'dueColor': AppColors.secondaryAccent,
        'icon': Icons.visibility_rounded,
        'iconColor': AppColors.primaryLight,
        'actionLabel': 'Book',
        'actionMsg': 'Opening eye exam booking…',
      },
      {
        'title': 'Mental Health Assessment (PHQ-9)',
        'desc': 'Quarterly · Stress/anxiety monitoring',
        'due': 'Due: Jun 2026',
        'dueColor': AppColors.secondaryAccent,
        'icon': Icons.psychology_rounded,
        'iconColor': Colors.purpleAccent,
        'actionLabel': 'Start',
        'actionMsg': 'Opening mental health assessment…',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
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
              const Icon(
                Icons.medical_services_rounded,
                color: AppColors.success,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'PREVENTIVE HEALTH CHECKUP SCHEDULE',
                style: AppTextStyles.labelMedium.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: checkups.map((checkup) {
              final iconColor = checkup['iconColor'] as Color;
              final actionLabel = checkup['actionLabel'] as String?;

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 600;

                    final iconWidget = Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: iconColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        checkup['icon'] as IconData,
                        color: iconColor,
                        size: 16,
                      ),
                    );

                    final contentWidget = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          checkup['title'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          checkup['desc'] as String,
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    );

                    final statusWidget = Text(
                      checkup['due'] as String,
                      style: TextStyle(
                        color: checkup['dueColor'] as Color,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: isMobile ? TextAlign.left : TextAlign.right,
                    );

                    final buttonWidget = actionLabel != null
                        ? ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(checkup['actionMsg'] as String),
                                  backgroundColor: iconColor,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: iconColor.withValues(alpha: 0.1),
                              foregroundColor: iconColor,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                                side: BorderSide(
                                  color: iconColor.withValues(alpha: 0.3),
                                ),
                              ),
                            ),
                            child: Text(
                              actionLabel,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : const SizedBox.shrink();

                    if (isMobile) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              iconWidget,
                              const SizedBox(width: 10),
                              Expanded(child: contentWidget),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [statusWidget, buttonWidget],
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          iconWidget,
                          const SizedBox(width: 10),
                          Expanded(flex: 3, child: contentWidget),
                          Expanded(flex: 2, child: statusWidget),
                          if (actionLabel != null) ...[
                            const SizedBox(width: 12),
                            buttonWidget,
                          ],
                        ],
                      );
                    }
                  },
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
