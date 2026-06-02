import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class MchMalnutritionChart extends StatelessWidget {
  const MchMalnutritionChart({super.key});

  @override
  Widget build(BuildContext context) {
    final districts = ['D.Dun', 'H.war', 'Rish', 'Alm', 'Pith', 'Cham', 'Teh', 'Pau'];
    final sam = [284, 524, 184, 284, 248, 184, 248, 224];
    final mam = [852, 1572, 552, 852, 744, 552, 744, 672];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MALNUTRITION BURDEN — SAM + MAM BY DISTRICT',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: AppColors.secondaryText,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('2.5K', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('2K', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('1.5K', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('1K', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('0', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final barWidth = (constraints.maxWidth / districts.length) * 0.5;
                      final barSpacing = constraints.maxWidth / districts.length;

                      return Stack(
                        children: List.generate(districts.length, (i) {
                          final district = districts[i];
                          final samVal = sam[i];
                          final mamVal = mam[i];
                          final totalVal = samVal + mamVal;

                          final samHeight = constraints.maxHeight * (samVal / 2500);
                          final mamHeight = constraints.maxHeight * (mamVal / 2500);

                          return Positioned(
                            left: i * barSpacing + (barSpacing - barWidth) / 2,
                            bottom: 0,
                            child: Column(
                              children: [
                                Tooltip(
                                  message: '$district - SAM: $samVal, MAM: $mamVal',
                                  child: Column(
                                    children: [
                                      // MAM (Stacked Top)
                                      Container(
                                        width: barWidth,
                                        height: mamHeight,
                                        color: AppColors.secondaryAccent.withValues(alpha: 0.5),
                                      ),
                                      // SAM (Stacked Bottom)
                                      Container(
                                        width: barWidth,
                                        height: samHeight - 16,
                                        decoration: const BoxDecoration(
                                          color: AppColors.error,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(2),
                                            topRight: Radius.circular(2),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                SizedBox(
                                  width: barSpacing,
                                  child: Text(
                                    district,
                                    style: const TextStyle(color: AppColors.secondaryText, fontSize: 8),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(width: 10, height: 10, decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 4),
                  const Text('Severe (SAM)', style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  Container(width: 10, height: 10, decoration: BoxDecoration(color: AppColors.secondaryAccent.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 4),
                  const Text('Moderate (MAM)', style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
