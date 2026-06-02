import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/ipd_beds/view_model/ipd_beds_view_model.dart';

class IpdTriageGrid extends ConsumerWidget {
  const IpdTriageGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ipdBedsProvider);
    final kpi = state.kpiData;

    final triageCards = [
      {
        'title': 'Red — Immediate',
        'desc': 'Life-threatening',
        'value': kpi.criticalCasesActive.toString(),
        'color': AppColors.error,
        'bg': AppColors.error.withValues(alpha: 0.1),
      },
      {
        'title': 'Yellow — Urgent',
        'desc': 'Delayed care acceptable',
        'value': '118',
        'color': AppColors.secondaryAccent,
        'bg': AppColors.secondaryAccent.withValues(alpha: 0.1),
      },
      {
        'title': 'Green — Minor',
        'desc': 'Walking wounded',
        'value': '104',
        'color': AppColors.success,
        'bg': AppColors.success.withValues(alpha: 0.1),
      },
      {
        'title': 'Black — Expectant',
        'desc': 'Palliative / deceased',
        'value': '18',
        'color': AppColors.secondaryText,
        'bg': AppColors.secondaryText.withValues(alpha: 0.1),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TRIAGE CATEGORY DISTRIBUTION — CURRENT ER CENSUS',
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
            final crossCount = constraints.maxWidth > 800 ? 4 : 2;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossCount,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.8,
              ),
              itemCount: triageCards.length,
              itemBuilder: (context, index) {
                final card = triageCards[index];
                final color = card['color'] as Color;

                return Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: card['bg'] as Color,
                    border: Border.all(color: color.withValues(alpha: 0.3)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              card['title'] as String,
                              style: TextStyle(
                                color: color,
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppTextStyles.fontFamily,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        card['value'] as String,
                        style: TextStyle(
                          color: color,
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                      ),
                      Text(
                        card['desc'] as String,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 9.5,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
