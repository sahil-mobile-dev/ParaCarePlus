import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class StateAdminOpdDeptChart extends StatelessWidget {
  const StateAdminOpdDeptChart({super.key});

  @override
  Widget build(BuildContext context) {
    final departments = [
      'Gen Med',
      'Paediatrics',
      'OBG',
      'Orthopaedics',
      'Ophthalmology',
      'Surgery',
    ];
    final loads = [24200.0, 18400.0, 15100.0, 12900.0, 9800.0, 8400.0];
    final maxVal = loads.reduce(max);

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
            'OPD Volume by Department',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Patient Load distribution across specialty departments MTD',
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
              children: List.generate(departments.length, (idx) {
                final l = loads[idx];
                final ratio = maxVal == 0 ? 0.0 : l / maxVal;

                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${(l / 1000).toStringAsFixed(1)}K',
                        style: const TextStyle(
                          fontSize: 7.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4DB6AC),
                        ),
                      ),
                      const SizedBox(height: 3),
                      FractionallySizedBox(
                        widthFactor: 0.6,
                        child: Container(
                          height: (ratio * 95).clamp(4.0, 100.0),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF4DB6AC,
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
            children: departments
                .map(
                  (d) => Expanded(
                    child: Text(
                      d,
                      style: const TextStyle(
                        fontSize: 8.5,
                        color: AppColors.secondaryText,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
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
