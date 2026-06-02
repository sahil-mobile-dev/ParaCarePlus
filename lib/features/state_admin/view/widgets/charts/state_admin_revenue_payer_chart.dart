import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class StateAdminRevenuePayerChart extends StatelessWidget {
  const StateAdminRevenuePayerChart({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Ayushman',
      'CGHS/ESI',
      'OPD cash',
      'IPD cash',
      'Insurance',
    ];
    final revenues = [18.4, 9.2, 6.1, 8.9, 4.2]; // in Crores
    final maxVal = revenues.reduce(max);

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
            'Revenue Mix by Payer Category',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'MTD Collections Split (Crores INR)',
            style: TextStyle(
              fontSize: 9.5,
              color: AppColors.secondaryText,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 16),
          // Vertical bars
          SizedBox(
            height: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(categories.length, (idx) {
                final r = revenues[idx];
                final ratio = maxVal == 0 ? 0.0 : r / maxVal;

                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '₹${r}Cr',
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFCA28),
                        ),
                      ),
                      const SizedBox(height: 3),
                      FractionallySizedBox(
                        widthFactor: 0.6,
                        child: Container(
                          height: (ratio * 95).clamp(4.0, 100.0),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFFFCA28,
                            ).withValues(alpha: 0.75),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(3),
                              topRight: Radius.circular(3),
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
            children: categories
                .map(
                  (c) => Expanded(
                    child: Text(
                      c,
                      style: const TextStyle(
                        fontSize: 8.5,
                        color: AppColors.secondaryText,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
