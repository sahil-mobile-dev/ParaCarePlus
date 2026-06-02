import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class VaccinationCoverageChart extends StatelessWidget {
  const VaccinationCoverageChart({super.key});

  @override
  Widget build(BuildContext context) {
    final districts = [
      'D.Dun',
      'H.war',
      'N.tal',
      'U.S.N',
      'Pau',
      'Teh',
      'Cha',
      'Alm',
      'Pit',
    ];
    final coverage = [96.0, 91.0, 94.0, 89.0, 97.0, 93.0, 95.0, 94.0, 88.0];

    final antigens = [
      'BCG',
      'OPV3',
      'DPT3',
      'HepB',
      'Measles',
      'Vitamin A',
      'MR',
    ];
    final rates = [98.4, 96.2, 95.8, 95.1, 94.7, 92.4, 91.4];

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final isMobile = w < 760;

        final distBars = _buildDistrictCoverage(districts, coverage);
        final antigenBars = _buildAntigenCoverage(antigens, rates);

        return isMobile
            ? Column(
                children: [distBars, const SizedBox(height: 16), antigenBars],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: distBars),
                  const SizedBox(width: 16),
                  Expanded(child: antigenBars),
                ],
              );
      },
    );
  }

  Widget _buildDistrictCoverage(List<String> districts, List<double> coverage) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'District Immunisation Coverage %',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Full Immunisation Coverage vs 90% UIP Target',
                    style: TextStyle(
                      fontSize: 9.5,
                      color: AppColors.secondaryText,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Vertical Bar Chart
          SizedBox(
            height: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(districts.length, (idx) {
                final c = coverage[idx];
                final ratio = (c - 80.0) / 20.0; // Scaled between 80% and 100%
                final barCol = c >= 95.0
                    ? AppColors.success
                    : (c >= 90.0 ? AppColors.primaryLight : AppColors.error);

                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${c.round()}%',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: barCol,
                        ),
                      ),
                      const SizedBox(height: 2),
                      FractionallySizedBox(
                        widthFactor: 0.6,
                        child: Container(
                          height: (ratio * 95).clamp(4.0, 100.0),
                          decoration: BoxDecoration(
                            color: barCol.withValues(alpha: 0.75),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(2),
                              topRight: Radius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: districts
                .map(
                  (d) => Expanded(
                    child: Text(
                      d,
                      style: const TextStyle(
                        fontSize: 8.5,
                        color: AppColors.secondaryText,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAntigenCoverage(List<String> antigens, List<double> rates) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Vaccine-wise Antigen Coverage %',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Antigen completion rates under UIP',
            style: TextStyle(
              fontSize: 9.5,
              color: AppColors.secondaryText,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: List.generate(antigens.length, (idx) {
              final ant = antigens[idx];
              final r = rates[idx];
              final ratio = (r - 80.0) / 20.0;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.5),
                child: Row(
                  children: [
                    SizedBox(
                      width: 60,
                      child: Text(
                        ant,
                        style: const TextStyle(
                          fontSize: 9.5,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.04),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: ratio.clamp(0.0, 1.0),
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: AppColors.success.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 36,
                      child: Text(
                        '${r.toStringAsFixed(1)}%',
                        style: const TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.success,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
