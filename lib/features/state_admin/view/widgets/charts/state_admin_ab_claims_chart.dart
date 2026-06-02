import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class StateAdminAbClaimsChart extends StatelessWidget {
  const StateAdminAbClaimsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final status = [
      {
        'label': 'Claims Approved YTD',
        'count': '6,847',
        'color': AppColors.success,
        'pct': 0.8,
      },
      {
        'label': 'Claims Pending Review',
        'count': '1,247',
        'color': AppColors.secondaryAccent,
        'pct': 0.15,
      },
      {
        'label': 'Claims Rejected / Flagged',
        'count': '247',
        'color': AppColors.error,
        'pct': 0.05,
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
            'Ayushman Bharat Claim Status',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Claims Volume State SHA Approvals MTD',
            style: TextStyle(
              fontSize: 9.5,
              color: AppColors.secondaryText,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: status.map((s) {
              final col = s['color']! as Color;
              final pct = s['pct']! as double;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          s['label']! as String,
                          style: const TextStyle(
                            fontSize: 9.5,
                            color: Colors.white70,
                            fontFamily: AppTextStyles.fontFamily,
                          ),
                        ),
                        Text(
                          s['count']! as String,
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            color: col,
                            fontFamily: AppTextStyles.fontFamily,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: pct,
                        child: Container(
                          decoration: BoxDecoration(
                            color: col,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
