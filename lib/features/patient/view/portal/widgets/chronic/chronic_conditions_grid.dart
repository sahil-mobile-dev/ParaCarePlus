import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class ChronicConditionsGrid extends StatelessWidget {
  const ChronicConditionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 900
            ? 3
            : (constraints.maxWidth > 600 ? 2 : 1);

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.35,
          children: [
            _buildConditionCard(
              context: context,
              icon: Icons.heart_broken_rounded,
              name: 'Hypertension',
              status: 'ACTIVE — Stage 1',
              statusColor: AppColors.error,
              metric1Label: 'Systolic',
              metric1Val: '128 mmHg',
              metric1Color: AppColors.error,
              metric2Label: 'Diastolic',
              metric2Val: '82 mmHg',
              metric2Color: AppColors.secondaryAccent,
              progress: 0.65,
              progressLabel: 'Control Level',
              progressValText: '65% — Partial Control',
              progressColor: AppColors.secondaryAccent,
              button1Icon: Icons.analytics_outlined,
              button1Text: 'BP Log',
              button2Icon: Icons.medical_services_outlined,
              button2Text: 'Consult',
            ),
            _buildConditionCard(
              context: context,
              icon: Icons.bloodtype_rounded,
              name: 'Pre-Diabetes',
              status: 'ACTIVE — Borderline',
              statusColor: AppColors.secondaryAccent,
              metric1Label: 'HbA1c',
              metric1Val: '6.2%',
              metric1Color: AppColors.secondaryAccent,
              metric2Label: 'FPG',
              metric2Val: '142 mg/dL',
              metric2Color: AppColors.secondaryAccent,
              progress: 0.75,
              progressLabel: 'T2D Progression Risk',
              progressValText: '75% — High if untreated',
              progressColor: AppColors.secondaryAccent,
              button1Icon: Icons.bar_chart_rounded,
              button1Text: 'Sugar Log',
              button2Icon: Icons.medical_services_outlined,
              button2Text: 'Consult',
            ),
            _buildConditionCard(
              context: context,
              icon: Icons.science_outlined,
              name: 'Hyperlipidemia',
              status: 'ACTIVE — Borderline High',
              statusColor: AppColors.secondaryAccent,
              metric1Label: 'Total Chol',
              metric1Val: '218 mg/dL',
              metric1Color: AppColors.secondaryAccent,
              metric2Label: 'LDL',
              metric2Val: '138 mg/dL',
              metric2Color: AppColors.error,
              progress: 0.60,
              progressLabel: 'CV Risk Contribution',
              progressValText: '60% — Significant',
              progressColor: AppColors.secondaryAccent,
              button1Icon: Icons.show_chart_rounded,
              button1Text: 'Lipid Trend',
              button2Icon: Icons.restaurant_menu_rounded,
              button2Text: 'Diet Plan',
            ),
            _buildConditionCard(
              context: context,
              icon: Icons.monitor_weight_outlined,
              name: 'Overweight',
              status: 'MONITORED — BMI 26.2',
              statusColor: AppColors.secondaryText,
              metric1Label: 'BMI',
              metric1Val: '26.2',
              metric1Color: AppColors.secondaryAccent,
              metric2Label: 'Weight',
              metric2Val: '72.4 kg',
              metric2Color: Colors.white,
              progress: 0.45,
              progressLabel: 'Risk Level',
              progressValText: '45% — Moderate',
              progressColor: AppColors.secondaryAccent,
              button1Icon: Icons.bar_chart_rounded,
              button1Text: 'Weight Log',
            ),
            _buildConditionCard(
              context: context,
              icon: Icons.nightlight_round,
              name: 'Sleep Disorder',
              status: 'MONITORED — Insomnia Risk',
              statusColor: AppColors.secondaryText,
              metric1Label: 'Avg Sleep',
              metric1Val: '6.2 hrs',
              metric1Color: AppColors.error,
              metric2Label: 'Quality',
              metric2Val: 'Poor',
              metric2Color: AppColors.secondaryAccent,
              progress: 0.40,
              progressLabel: 'Severity',
              progressValText: '40% — Mild–Moderate',
              progressColor: Colors.purple,
              button1Icon: Icons.show_chart_rounded,
              button1Text: 'Sleep Log',
            ),
            _buildConditionCard(
              context: context,
              icon: Icons.psychology_outlined,
              name: 'Stress / Anxiety',
              status: 'MONITORED — Elevated Stress',
              statusColor: AppColors.secondaryText,
              metric1Label: 'Stress Index',
              metric1Val: '6.4/10',
              metric1Color: AppColors.error,
              metric2Label: 'Wellness',
              metric2Val: '72/100',
              metric2Color: AppColors.secondaryAccent,
              progress: 0.64,
              progressLabel: 'Cortisol Risk',
              progressValText: '64% — Elevated',
              progressColor: AppColors.primaryLight,
              button1Icon: Icons.spa_outlined,
              button1Text: 'Wellness Plan',
            ),
            _buildConditionCard(
              context: context,
              icon: Icons.wb_sunny_outlined,
              name: 'Vitamin D Deficiency',
              status: 'MANAGED — On Supplements',
              statusColor: AppColors.secondaryText,
              metric1Label: '25-OH Vit D',
              metric1Val: '18 ng/mL',
              metric1Color: AppColors.secondaryAccent,
              metric2Label: 'Target',
              metric2Val: '>30',
              metric2Color: AppColors.success,
              progress: 0.55,
              progressLabel: 'D3 Supplement Adherence',
              progressValText: 'Stable Improving',
              progressColor: AppColors.success,
              button1Icon: Icons.medical_information_outlined,
              button1Text: 'Track Adherence',
            ),
            _buildConditionCard(
              context: context,
              icon: Icons.local_fire_department_outlined,
              name: 'GERD',
              status: 'MANAGED — On Omeprazole',
              statusColor: AppColors.secondaryText,
              metric1Label: 'Frequency',
              metric1Val: 'Rare',
              metric1Color: AppColors.success,
              metric2Label: 'Control',
              metric2Val: 'Good',
              metric2Color: AppColors.success,
              progress: 0.85,
              progressLabel: 'Symptom Control',
              progressValText: '85% — Well Controlled',
              progressColor: AppColors.success,
              button1Icon: Icons.restaurant_outlined,
              button1Text: 'Diet Tips',
            ),
            _buildConditionCard(
              context: context,
              icon: Icons.directions_walk_rounded,
              name: 'Knee Osteoarthritis',
              status: 'MANAGED — Post-Arthroscopy',
              statusColor: AppColors.secondaryText,
              metric1Label: 'Pain Level',
              metric1Val: '2/10',
              metric1Color: AppColors.success,
              metric2Label: 'Function',
              metric2Val: 'Good',
              metric2Color: AppColors.success,
              progress: 0.80,
              progressLabel: 'Recovery Status',
              progressValText: '80% — Good Recovery',
              progressColor: AppColors.success,
              button1Icon: Icons.sports_gymnastics_rounded,
              button1Text: 'Exercise Plan',
            ),
          ],
        );
      },
    );
  }

  Widget _buildConditionCard({
    required BuildContext context,
    required IconData icon,
    required String name,
    required String status,
    required Color statusColor,
    required String metric1Label,
    required String metric1Val,
    required Color metric1Color,
    required String metric2Label,
    required String metric2Val,
    required Color metric2Color,
    required double progress,
    required String progressLabel,
    required String progressValText,
    required Color progressColor,
    required IconData button1Icon,
    required String button1Text,
    IconData? button2Icon,
    String? button2Text,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: statusColor, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      status,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        metric1Label,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 9,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        metric1Val,
                        style: TextStyle(
                          color: metric1Color,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        metric2Label,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 9,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        metric2Val,
                        style: TextStyle(
                          color: metric2Color,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                color: progressColor,
                minHeight: 4,
                borderRadius: BorderRadius.circular(2),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    progressLabel,
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 9,
                    ),
                  ),
                  Text(
                    progressValText,
                    style: TextStyle(
                      color: progressColor,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Opening $button1Text...')),
                    );
                  },
                  icon: Icon(
                    button1Icon,
                    size: 12,
                    color: AppColors.secondaryText,
                  ),
                  label: Text(
                    button1Text,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.secondaryText,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    backgroundColor: AppColors.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: const BorderSide(color: AppColors.border),
                    ),
                  ),
                ),
              ),
              if (button2Text != null) ...[
                const SizedBox(width: 6),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Opening $button2Text...')),
                      );
                    },
                    icon: Icon(
                      button2Icon,
                      size: 12,
                      color: AppColors.secondaryText,
                    ),
                    label: Text(
                      button2Text,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      backgroundColor: AppColors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: const BorderSide(color: AppColors.border),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
