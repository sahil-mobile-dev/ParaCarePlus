import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class StateAdminMchIndicatorsChart extends StatelessWidget {
  const StateAdminMchIndicatorsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final indicators = [
      {
        'name': 'ANC Registration',
        'val': '98.2%',
        'status': 'Excellent',
        'color': AppColors.success,
      },
      {
        'name': '4+ ANC Checkups',
        'val': '94.3%',
        'status': 'Excellent',
        'color': AppColors.success,
      },
      {
        'name': 'Institutional Deliveries',
        'val': '87.1%',
        'status': 'Below target',
        'color': AppColors.error,
      },
      {
        'name': 'Full Immunisation',
        'val': '94.7%',
        'status': 'Excellent',
        'color': AppColors.success,
      },
      {
        'name': 'Maternal Care Radar',
        'val': '78%',
        'status': 'Average',
        'color': const Color(0xFFFFD166),
      },
    ];

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
            'Maternal & Child Health Indicators',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Key Benchmarks Under NHM RCH Programme',
            style: TextStyle(
              fontSize: 9.5,
              color: AppColors.secondaryText,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: indicators.length,
            itemBuilder: (context, idx) {
              final ind = indicators[idx];
              final col = ind['color']! as Color;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: col,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          ind['name']! as String,
                          style: const TextStyle(
                            fontSize: 10.5,
                            color: Colors.white70,
                            fontFamily: AppTextStyles.fontFamily,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          ind['val']! as String,
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            color: col,
                            fontFamily: AppTextStyles.fontFamily,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${ind['status']})',
                          style: const TextStyle(
                            fontSize: 9.5,
                            color: AppColors.secondaryText,
                            fontFamily: AppTextStyles.fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
