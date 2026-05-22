import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class LabKpis extends StatelessWidget {
  const LabKpis({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        var crossAxisCount = 2;
        if (width > 1100) {
          crossAxisCount = 6;
        } else if (width > 700) {
          crossAxisCount = 3;
        }

        final items = _getKpis();

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 1.35,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final k = items[index];
            return Container(
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 3,
                      child: Container(color: k.color),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: k.color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Icon(k.icon, color: k.color, size: 16),
                          ),
                          const Spacer(),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              k.value,
                              style: AppTextStyles.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            k.label,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.secondaryText,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              k.subtext,
                              style: TextStyle(
                                color: k.color,
                                fontSize: 8.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<_LabKpiItem> _getKpis() {
    return [
      _LabKpiItem(
        value: '28',
        label: 'Total Reports',
        subtext: 'Last 12 months',
        color: AppColors.primaryLight,
        icon: Icons.assignment_rounded,
      ),
      _LabKpiItem(
        value: '7',
        label: 'Abnormal Results',
        subtext: 'Require attention',
        color: AppColors.error,
        icon: Icons.warning_amber_rounded,
      ),
      _LabKpiItem(
        value: '18',
        label: 'Normal Results',
        subtext: 'Within range',
        color: AppColors.success,
        icon: Icons.check_circle_outline_rounded,
      ),
      _LabKpiItem(
        value: '3',
        label: 'Pending Reports',
        subtext: 'Results awaited',
        color: AppColors.secondaryAccent,
        icon: Icons.pending_actions_rounded,
      ),
      _LabKpiItem(
        value: '10 May',
        label: 'Last Test Date',
        subtext: 'Lipid panel done',
        color: AppColors.primaryLight,
        icon: Icons.calendar_month_rounded,
      ),
      _LabKpiItem(
        value: '4',
        label: 'Tests Due',
        subtext: 'Scheduled next month',
        color: AppColors.secondaryAccent,
        icon: Icons.notification_important_rounded,
      ),
    ];
  }
}

class _LabKpiItem {
  _LabKpiItem({
    required this.value,
    required this.label,
    required this.subtext,
    required this.color,
    required this.icon,
  });

  final String value;
  final String label;
  final String subtext;
  final Color color;
  final IconData icon;
}
