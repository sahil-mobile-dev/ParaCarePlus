import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class HospDeptBedChart extends StatelessWidget {
  const HospDeptBedChart({super.key});

  @override
  Widget build(BuildContext context) {
    final depts = [
      {'name': 'General Medicine', 'occ': 88, 'avail': 12},
      {'name': 'Surgery', 'occ': 76, 'avail': 24},
      {'name': 'Orthopaedics', 'occ': 72, 'avail': 28},
      {'name': 'Gynaecology', 'occ': 81, 'avail': 19},
      {'name': 'Paediatrics', 'occ': 65, 'avail': 35},
      {'name': 'Cardiology', 'occ': 92, 'avail': 8},
      {'name': 'Neurology', 'occ': 78, 'avail': 22},
      {'name': 'Oncology', 'occ': 84, 'avail': 16},
      {'name': 'Nephrology', 'occ': 71, 'avail': 29},
      {'name': 'Emergency', 'occ': 96, 'avail': 4},
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.55,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bed Occupancy by Department',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Occupied vs available beds per clinical department (Top 10)',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const Row(
                children: [
                  Icon(Icons.square, size: 10, color: AppColors.primaryLight),
                  SizedBox(width: 4),
                  Text(
                    'Occupied',
                    style: TextStyle(color: Colors.white70, fontSize: 9),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.square, size: 10, color: Color(0x3D1E3A5F)),
                  SizedBox(width: 4),
                  Text(
                    'Available',
                    style: TextStyle(color: Colors.white70, fontSize: 9),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: ListView.separated(
              itemCount: depts.length,
              separatorBuilder: (context, idx) => const SizedBox(height: 8),
              itemBuilder: (context, idx) {
                final item = depts[idx];
                final occ = item['occ'] as int;
                final avail = item['avail'] as int;
                final name = item['name'] as String;

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
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$occ% Occ / $avail% Avail',
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          flex: occ,
                          child: Container(
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(3),
                                bottomLeft: Radius.circular(3),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: avail,
                          child: Container(
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0x3D1E3A5F),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(3),
                                bottomRight: Radius.circular(3),
                              ),
                            ),
                          ),
                        ),
                      ],
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
