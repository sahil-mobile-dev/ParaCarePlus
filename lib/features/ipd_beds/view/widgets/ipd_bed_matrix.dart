import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/ipd_beds/view_model/ipd_beds_view_model.dart';

class IpdBedMatrix extends ConsumerWidget {
  const IpdBedMatrix({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ipdBedsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'WARD-WISE BED STATUS — REAL-TIME',
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
                childAspectRatio: 2.2,
              ),
              itemCount: state.wards.length,
              itemBuilder: (context, index) {
                final w = state.wards[index];
                final pct = w.percent;
                final pctText = '${(pct * 100).round()}%';

                Color barColor = AppColors.success;
                if (pct >= 0.90) {
                  barColor = AppColors.error;
                } else if (pct >= 0.75) {
                  barColor = AppColors.secondaryAccent;
                }

                final colorVal = int.parse('FF${w.themeHex}', radix: 16);
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
                          Icon(
                            Icons.local_hospital_rounded,
                            size: 14,
                            color: themeColor,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              w.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppTextStyles.fontFamily,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
                            value: pct,
                            backgroundColor: Colors.white.withValues(alpha: 0.07),
                            valueColor: AlwaysStoppedAnimation<Color>(barColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${w.occupied}/${w.total}',
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 10,
                              fontFamily: AppTextStyles.fontFamily,
                            ),
                          ),
                          Text(
                            pctText,
                            style: TextStyle(
                              color: barColor,
                              fontSize: 10,
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
