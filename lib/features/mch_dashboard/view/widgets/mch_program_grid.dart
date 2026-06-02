import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/mch_dashboard/view_model/mch_dashboard_view_model.dart';

class MchProgramGrid extends ConsumerWidget {
  const MchProgramGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mchDashboardProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'NATIONAL PROGRAMME ACHIEVEMENT',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: AppColors.secondaryText,
            fontFamily: AppTextStyles.fontFamily,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossCount = constraints.maxWidth > 1200
                ? 4
                : (constraints.maxWidth > 800 ? 3 : 2);

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossCount,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2,
              ),
              itemCount: state.programs.length,
              itemBuilder: (context, index) {
                final p = state.programs[index];
                final doneText = p.isPercent
                    ? '${p.done}%'
                    : p.done.round().toString();
                final totalText = p.isPercent
                    ? '—'
                    : p.total.round().toString();

                var barColor = AppColors.success;
                if (p.pct < 70) {
                  barColor = AppColors.error;
                } else if (p.pct < 85) {
                  barColor = AppColors.secondaryAccent;
                }

                final colorVal = int.parse('FF${p.themeHex}', radix: 16);
                final themeColor = Color(colorVal);

                return Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(
                      color: AppColors.border.withValues(alpha: 0.4),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: themeColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.assignment_turned_in_rounded,
                              size: 13,
                              color: themeColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppTextStyles.fontFamily,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Text(
                                  'Achievement Target',
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: SizedBox(
                          height: 8,
                          width: double.infinity,
                          child: LinearProgressIndicator(
                            value: p.pct / 100.0,
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.07,
                            ),
                            valueColor: AlwaysStoppedAnimation<Color>(barColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            p.isPercent ? doneText : '$doneText / $totalText',
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 9.5,
                              fontFamily: AppTextStyles.fontFamily,
                            ),
                          ),
                          Text(
                            '${p.pct}%',
                            style: TextStyle(
                              color: themeColor,
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppTextStyles.fontFamily,
                            ),
                          ),
                        ],
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
