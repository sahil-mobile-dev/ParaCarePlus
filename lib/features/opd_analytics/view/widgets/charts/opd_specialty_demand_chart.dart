import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class OpdSpecialtyDemandChart extends StatelessWidget {
  const OpdSpecialtyDemandChart({super.key});

  @override
  Widget build(BuildContext context) {
    final specs = [
      {'name': 'Gen Medicine', 'val': 9840, 'color': AppColors.primaryLight},
      {'name': 'Orthopaedics', 'val': 7120, 'color': AppColors.success},
      {'name': 'Gynaecology', 'val': 6480, 'color': AppColors.secondaryAccent},
      {'name': 'Paediatrics', 'val': 5840, 'color': Colors.purpleAccent},
      {'name': 'Cardiology', 'val': 4320, 'color': AppColors.error},
      {'name': 'ENT', 'val': 3980, 'color': Colors.tealAccent},
      {'name': 'Ophthalmology', 'val': 3640, 'color': Colors.pinkAccent},
      {'name': 'Dermatology', 'val': 3200, 'color': Colors.orangeAccent},
      {'name': 'Neurology', 'val': 2840, 'color': Colors.indigoAccent},
      {'name': 'Surgery', 'val': 4120, 'color': AppColors.primaryLight},
      {'name': 'Psychiatry', 'val': 1240, 'color': AppColors.success},
      {'name': 'Dental', 'val': 960, 'color': Colors.purpleAccent},
    ];

    const maxVal = 10000;

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
                'OPD Demand by Specialty',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Today's Patient Count (Top 12 Specialties)",
                style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: ListView.separated(
              itemCount: specs.length,
              separatorBuilder: (context, idx) => const SizedBox(height: 6),
              itemBuilder: (context, idx) {
                final item = specs[idx];
                final name = item['name'] as String;
                final val = item['val'] as int;
                final color = item['color'] as Color;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          val.toString(),
                          style: TextStyle(
                            color: color,
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: SizedBox(
                        height: 5,
                        child: LinearProgressIndicator(
                          value: val / maxVal,
                          backgroundColor: Colors.white.withValues(alpha: 0.05),
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
