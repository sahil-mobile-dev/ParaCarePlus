import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class StateAdminBudgetSunburstChart extends StatelessWidget {
  const StateAdminBudgetSunburstChart({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'title': 'National Health Mission (NHM)',
        'items': [
          {'name': 'Reproductive & Child Health (RCH)', 'val': '₹32.0 Cr'},
          {'name': 'Integrated Disease Surveillance (IDSP)', 'val': '₹18.0 Cr'},
          {'name': 'Immunisation & Vaccination', 'val': '₹22.0 Cr'},
        ],
        'color': const Color(0xFF60A5FA),
      },
      {
        'title': 'Ayushman Bharat (PMJAY)',
        'items': [
          {'name': 'Secondary/Tertiary Hospitalisation', 'val': '₹48.0 Cr'},
          {'name': 'Specialty Day Care Packages', 'val': '₹12.0 Cr'},
        ],
        'color': const Color(0xFFFFCA28),
      },
      {
        'title': 'State Budget & Infrastructure',
        'items': [
          {'name': 'workforce Salaries & Payroll', 'val': '₹62.0 Cr'},
          {'name': 'Free Essential Medicines Supply', 'val': '₹28.0 Cr'},
        ],
        'color': const Color(0xFF4DB6AC),
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
            'Health Budget Expenditure Allocation',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'State Expenditure Drill-Down by Program Category',
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
            itemCount: categories.length,
            itemBuilder: (context, idx) {
              final cat = categories[idx];
              final col = cat['color']! as Color;
              final subItems = cat['items']! as List<Map<String, String>>;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: col,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            cat['title']! as String,
                            style: const TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: AppTextStyles.fontFamily,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...subItems.map((sub) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 18, bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            sub['name']!,
                            style: const TextStyle(
                              fontSize: 9.5,
                              color: Colors.white60,
                              fontFamily: AppTextStyles.fontFamily,
                            ),
                          ),
                          Text(
                            sub['val']!,
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              color: col,
                              fontFamily: AppTextStyles.fontFamily,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 8),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
