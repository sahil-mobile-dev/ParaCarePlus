import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class MchImmunisationChart extends StatelessWidget {
  const MchImmunisationChart({super.key});

  @override
  Widget build(BuildContext context) {
    final antigens = ['BCG', 'OPV3', 'DPT3', 'Measles', 'Hep-B3', 'Rota3', 'PCV3', 'Vit-A', 'JE', 'DPT Boost'];
    final coverage = [97.2, 95.4, 94.7, 93.8, 96.1, 88.4, 87.2, 82.4, 78.6, 74.2];

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
            'IMMUNISATION COVERAGE BY ANTIGEN — STATE AVERAGE',
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
                    Text('100%', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('80%', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('60%', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('40%', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    Text('20%', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final barWidth = (constraints.maxWidth / antigens.length) * 0.6;
                      final barSpacing = constraints.maxWidth / antigens.length;

                      return Stack(
                        children: List.generate(antigens.length, (i) {
                          final label = antigens[i];
                          final val = coverage[i];
                          final height = constraints.maxHeight * (val / 100);

                          final color = HSLColor.fromAHSL(
                            1.0,
                            160.0 + (i * 12.0),
                            0.7,
                            0.5,
                          ).toColor();

                          return Positioned(
                            left: i * barSpacing + (barSpacing - barWidth) / 2,
                            bottom: 0,
                            child: Column(
                              children: [
                                Tooltip(
                                  message: '$label: $val%',
                                  child: Container(
                                    width: barWidth,
                                    height: height - 16,
                                    decoration: BoxDecoration(
                                      color: color.withValues(alpha: 0.75),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(3),
                                        topRight: Radius.circular(3),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                SizedBox(
                                  width: barSpacing,
                                  child: Text(
                                    label,
                                    style: const TextStyle(color: AppColors.secondaryText, fontSize: 8),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
        ],
      ),
    );
  }
}
