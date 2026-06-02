import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class HospPatientFunnelChart extends StatelessWidget {
  const HospPatientFunnelChart({super.key});

  @override
  Widget build(BuildContext context) {
    final funnelData = [
      {'name': 'OPD Walk-ins', 'val': '158.4K', 'width': 1.0, 'color': AppColors.primaryLight},
      {'name': 'IPD Admissions', 'val': '11.5K', 'width': 0.8, 'color': AppColors.success},
      {'name': 'Surgeries', 'val': '3.7K', 'width': 0.6, 'color': AppColors.secondaryAccent},
      {'name': 'ICU Transfers', 'val': '1.1K', 'width': 0.4, 'color': AppColors.error},
      {'name': 'Discharges', 'val': '10.8K', 'width': 0.7, 'color': AppColors.success},
    ];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Patient Flow Funnel',
                style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'Monthly patient journey attrition funnel (OPD to Discharge)',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
                  ),
                ],
              ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: funnelData.map((item) {
                final widthFactor = item['width'] as double;
                final name = item['name'] as String;
                final val = item['val'] as String;
                final color = item['color'] as Color;

                return FractionallySizedBox(
                  widthFactor: widthFactor,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: color.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          val,
                          style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
