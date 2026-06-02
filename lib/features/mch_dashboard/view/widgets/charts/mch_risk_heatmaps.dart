import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class MchRiskHeatmaps extends StatelessWidget {
  const MchRiskHeatmaps({super.key});

  @override
  Widget build(BuildContext context) {
    final districts = [
      'Dehradun',
      'Haridwar',
      'Nainital',
      'Almora',
      'Pithoragarh',
      'Chamoli',
      'Tehri',
      'Pauri',
    ];
    final factors = [
      'Anaemia',
      'Hypertension',
      'Diabetes',
      'Prev. C-Sec',
      'Age <18/>35',
      'Still-Birth',
      'Multiple',
      'Cardiac',
    ];

    final hrpData = [
      [35, 20, 15, 25, 10, 8, 5, 4], // Dehradun
      [55, 30, 22, 28, 12, 10, 6, 5], // Haridwar
      [42, 25, 18, 20, 15, 9, 7, 3], // Nainital
      [48, 28, 14, 18, 16, 12, 5, 2], // Almora
      [68, 35, 12, 22, 25, 15, 8, 4], // Pithoragarh
      [32, 18, 8, 10, 18, 11, 4, 1], // Chamoli
      [44, 22, 11, 15, 14, 10, 5, 3], // Tehri
      [40, 24, 13, 17, 12, 9, 6, 2], // Pauri
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        final cellWidth =
            (constraints.maxWidth * (isWide ? 0.5 : 1.0) - 90) / factors.length;
        final cellHeight = 260 / districts.length;

        final charts = [
          // HRP Heatmap
          Expanded(
            flex: isWide ? 1 : 0,
            child: Container(
              height: 330,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(
                  color: AppColors.border.withValues(alpha: 0.4),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'HIGH-RISK PREGNANCY HEATMAP — DISTRICT × RISK FACTOR',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: AppColors.secondaryText,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 55),
                            ...factors.map(
                              (f) => SizedBox(
                                width: cellWidth,
                                child: Text(
                                  f,
                                  style: const TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 7.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Expanded(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: districts.length,
                            itemBuilder: (context, r) {
                              return SizedBox(
                                height: cellHeight,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 55,
                                      child: Text(
                                        districts[r],
                                        style: const TextStyle(
                                          color: AppColors.secondaryText,
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    ...List.generate(factors.length, (c) {
                                      final val = hrpData[r][c];
                                      Color cellBg = const Color(0xFF0C1F34);
                                      if (val >= 40) {
                                        cellBg = const Color(
                                          0xFFF72585,
                                        ).withValues(alpha: 0.85);
                                      } else if (val >= 25) {
                                        cellBg = const Color(
                                          0xFFC77DFF,
                                        ).withValues(alpha: 0.7);
                                      } else if (val >= 15) {
                                        cellBg = AppColors.primaryLight
                                            .withValues(alpha: 0.5);
                                      } else {
                                        cellBg = AppColors.primary.withValues(
                                          alpha: 0.25,
                                        );
                                      }

                                      return Container(
                                        width: cellWidth - 2,
                                        height: cellHeight - 2,
                                        margin: const EdgeInsets.all(1),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: cellBg,
                                          borderRadius: BorderRadius.circular(
                                            2,
                                          ),
                                        ),
                                        child: Text(
                                          '$val',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 8.5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ];

        return isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: charts,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: charts,
              );
      },
    );
  }
}
