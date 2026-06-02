import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class StateAdminDiseaseBurdenChart extends StatelessWidget {
  const StateAdminDiseaseBurdenChart({super.key});

  @override
  Widget build(BuildContext context) {
    final diseases = [
      {'name': 'Cardiovascular', 'pct': 22, 'color': AppColors.error},
      {
        'name': 'Respiratory (ILI/ARI)',
        'pct': 18,
        'color': const Color(0xFF60A5FA),
      },
      {
        'name': 'Diabetes Mellitus',
        'pct': 14,
        'color': const Color(0xFF4DB6AC),
      },
      {
        'name': 'Vector-borne (Dengue/Malaria)',
        'pct': 12,
        'color': AppColors.secondaryAccent,
      },
      {
        'name': 'Hypertension Case loads',
        'pct': 10,
        'color': const Color(0xFFFFD166),
      },
      {
        'name': 'Active Tuberculosis',
        'pct': 8,
        'color': const Color(0xFFCE93D8),
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
            'Disease Burden Distribution',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Top Disease Categories Diagnosed YTD',
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
            itemCount: diseases.length,
            itemBuilder: (context, idx) {
              final d = diseases[idx];
              final col = d['color']! as Color;
              final pct = d['pct']! as int;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
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
                    Expanded(
                      child: Text(
                        d['name']! as String,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white70,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$pct%',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        color: col,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
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
