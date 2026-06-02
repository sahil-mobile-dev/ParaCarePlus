import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class DengueWeeklyChart extends StatelessWidget {
  const DengueWeeklyChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulated weekly case count for last 12 weeks
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
    final cases = [
      80.0,
      95.0,
      110.0,
      85.0,
      120.0,
      160.0,
      210.0,
      240.0,
      310.0,
      420.0,
      487.0,
      390.0,
    ];
    final maxVal = cases.reduce(max);

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dengue Weekly Case Count',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'All Districts — Haridwar Active Hotspot Highlighted',
                    style: TextStyle(
                      fontSize: 9.5,
                      color: AppColors.secondaryText,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.3),
                  ),
                ),
                child: const Text(
                  'ACTIVE OUTBREAK',
                  style: TextStyle(
                    color: AppColors.error,
                    fontSize: 8.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Bar Chart area
          SizedBox(
            height: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(cases.length, (idx) {
                final c = cases[idx];
                final ratio = maxVal == 0 ? 0.0 : c / maxVal;
                // Highlight last few weeks which represent the Haridwar surge
                final isSurge = idx >= 8;

                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${c.round()}',
                        style: TextStyle(
                          fontSize: 7.5,
                          fontWeight: FontWeight.bold,
                          color: isSurge
                              ? AppColors.error
                              : AppColors.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 3),
                      FractionallySizedBox(
                        widthFactor: 0.7,
                        child: Container(
                          height: (ratio * 110).clamp(4.0, 110.0),
                          decoration: BoxDecoration(
                            color: isSurge
                                ? AppColors.error.withValues(alpha: 0.8)
                                : const Color(
                                    0xFFFFD166,
                                  ).withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(2),
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
