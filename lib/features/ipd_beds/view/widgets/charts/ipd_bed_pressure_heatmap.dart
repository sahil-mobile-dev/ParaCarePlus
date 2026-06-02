import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class IpdBedPressureHeatmap extends StatelessWidget {
  const IpdBedPressureHeatmap({super.key});

  @override
  Widget build(BuildContext context) {
    final districts = [
      'Dehradun',
      'Haridwar',
      'Rishikesh',
      'Almora',
      'Pithoragarh',
      'Chamoli',
      'Tehri',
      'Pauri',
    ];
    final wards = [
      'Gen. Med',
      'Surgery',
      'Ortho',
      'Gynae',
      'Paeds',
      'ICU',
      'HDU',
      'NICU',
    ];

    // Simulated occupancy percentages
    final data = [
      [90, 85, 70, 75, 60, 95, 88, 70], // Dehradun
      [92, 88, 75, 80, 65, 98, 90, 75], // Haridwar
      [75, 70, 60, 65, 50, 80, 70, 60], // Rishikesh
      [82, 78, 65, 70, 55, 85, 75, 65], // Almora
      [88, 80, 70, 75, 60, 92, 80, 70], // Pithoragarh
      [55, 50, 45, 50, 40, 65, 55, 45], // Chamoli
      [78, 74, 60, 65, 50, 82, 72, 60], // Tehri
      [80, 76, 62, 68, 52, 84, 74, 62], // Pauri
    ];

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
            'DISTRICT × WARD BED PRESSURE HEATMAP',
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                final cellWidth = (constraints.maxWidth - 90) / wards.length;
                final cellHeight =
                    (constraints.maxHeight - 24) / districts.length;

                return Column(
                  children: [
                    // Header row (wards)
                    Row(
                      children: [
                        const SizedBox(width: 75),
                        ...wards.map(
                          (w) => SizedBox(
                            width: cellWidth,
                            child: Text(
                              w,
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 8.5,
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
                    // Heatmap grid
                    Expanded(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: districts.length,
                        itemBuilder: (context, r) {
                          return SizedBox(
                            height: cellHeight,
                            child: Row(
                              children: [
                                // District Label
                                SizedBox(
                                  width: 70,
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
                                // Row Cells
                                ...List.generate(wards.length, (c) {
                                  final val = data[r][c];
                                  Color cellBg = const Color(
                                    0xFF0C1F34,
                                  ); // background shade
                                  if (val >= 90) {
                                    cellBg = AppColors.error.withValues(
                                      alpha: 0.85,
                                    );
                                  } else if (val >= 75) {
                                    cellBg = AppColors.secondaryAccent
                                        .withValues(alpha: 0.75);
                                  } else if (val >= 50) {
                                    cellBg = AppColors.primaryLight.withValues(
                                      alpha: 0.5,
                                    );
                                  } else {
                                    cellBg = AppColors.success.withValues(
                                      alpha: 0.3,
                                    );
                                  }

                                  return Container(
                                    width: cellWidth - 2,
                                    height: cellHeight - 2,
                                    margin: const EdgeInsets.all(1),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: cellBg,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: Text(
                                      '$val%',
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
