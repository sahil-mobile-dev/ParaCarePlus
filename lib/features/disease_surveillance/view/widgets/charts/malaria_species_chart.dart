import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class MalariaSpeciesChart extends StatelessWidget {
  const MalariaSpeciesChart({super.key});

  @override
  Widget build(BuildContext context) {
    final weeks = [
      'W1',
      'W2',
      'W3',
      'W4',
      'W5',
      'W6',
      'W7',
      'W8',
      'W9',
      'W10',
      'W11',
      'W12',
    ];
    final vivax = [
      42.0,
      50.0,
      62.0,
      38.0,
      47.0,
      58.0,
      68.0,
      74.0,
      89.0,
      95.0,
      110.0,
      98.0,
    ];
    final falciparum = [
      5.0,
      8.0,
      12.0,
      4.0,
      6.0,
      9.0,
      15.0,
      18.0,
      24.0,
      35.0,
      43.0,
      30.0,
    ];

    final totals = List<double>.generate(
      vivax.length,
      (i) => vivax[i] + falciparum[i],
    );
    final maxTotal = totals.reduce(max);

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
                    'Malaria Species Distribution',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'P. vivax vs P. falciparum Stacked Weekly Ratio',
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
          const SizedBox(height: 12),
          const Row(
            children: [
              _LegendDot('P. vivax', AppColors.primaryLight),
              SizedBox(width: 12),
              _LegendDot('P. falciparum (Fatal)', AppColors.error),
            ],
          ),
          const SizedBox(height: 16),
          // Stacked Bars area
          SizedBox(
            height: 124,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(weeks.length, (idx) {
                final v = vivax[idx];
                final f = falciparum[idx];
                final total = v + f;

                final ratioV = maxTotal == 0 ? 0.0 : v / maxTotal;
                final ratioF = maxTotal == 0 ? 0.0 : f / maxTotal;

                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${total.round()}',
                        style: const TextStyle(
                          fontSize: 7.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 2),
                      FractionallySizedBox(
                        widthFactor: 0.65,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Falciparum on top
                            Container(
                              height: (ratioF * 96).clamp(0.0, 96.0),
                              decoration: const BoxDecoration(
                                color: AppColors.error,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(2),
                                  topRight: Radius.circular(2),
                                ),
                              ),
                            ),
                            // Vivax at bottom
                            Container(
                              height: (ratioV * 96).clamp(0.0, 96.0),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(2),
                                  bottomRight: Radius.circular(2),
                                ),
                              ),
                            ),
                          ],
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
            children: weeks
                .map(
                  (w) => Expanded(
                    child: Text(
                      w,
                      style: const TextStyle(
                        fontSize: 8.5,
                        color: AppColors.secondaryText,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot(this.label, this.color);
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 9.5,
            color: AppColors.secondaryText,
            fontFamily: AppTextStyles.fontFamily,
          ),
        ),
      ],
    );
  }
}
