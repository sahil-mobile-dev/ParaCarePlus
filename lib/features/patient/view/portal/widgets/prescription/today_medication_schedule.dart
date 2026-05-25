import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class TodayMedicationSchedule extends StatefulWidget {
  const TodayMedicationSchedule({super.key});

  @override
  State<TodayMedicationSchedule> createState() => _TodayMedicationScheduleState();
}

class _TodayMedicationScheduleState extends State<TodayMedicationSchedule> {
  final List<Map<String, dynamic>> _meds = [
    {
      'name': 'Amlodipine 5mg',
      'desc': '1 tablet — Antihypertensive · Take with water',
      'time': '7:00 AM',
      'icon': Icons.favorite_rounded,
      'iconBg': AppColors.error.withValues(alpha: 0.15),
      'iconColor': AppColors.error,
      'taken': true,
      'defaultPendingText': 'Pending',
    },
    {
      'name': 'Metformin 500mg',
      'desc': '1 tablet after breakfast — Anti-diabetic',
      'time': '9:00 AM',
      'icon': Icons.water_drop_rounded,
      'iconBg': const Color(0xFFF77F00).withValues(alpha: 0.15),
      'iconColor': const Color(0xFFF77F00),
      'taken': true,
      'defaultPendingText': 'Pending',
    },
    {
      'name': 'Atorvastatin 10mg',
      'desc': '1 tablet at night — Statin/Cholesterol',
      'time': '10:00 PM',
      'icon': Icons.biotech_rounded,
      'iconBg': const Color(0xFFC77DFF).withValues(alpha: 0.15),
      'iconColor': const Color(0xFFC77DFF),
      'taken': false,
      'defaultPendingText': 'Due tonight',
    },
    {
      'name': 'Vitamin D3 1000 IU',
      'desc': '1 capsule after lunch — Supplement',
      'time': '1:00 PM',
      'icon': Icons.grid_view_rounded,
      'iconBg': AppColors.success.withValues(alpha: 0.15),
      'iconColor': AppColors.success,
      'taken': false,
      'defaultPendingText': 'Pending',
    },
    {
      'name': 'Omeprazole 20mg',
      'desc': '1 capsule before dinner — PPI/Gastric',
      'time': '7:00 PM',
      'icon': Icons.medication_rounded,
      'iconBg': AppColors.primaryLight.withValues(alpha: 0.15),
      'iconColor': AppColors.primaryLight,
      'taken': false,
      'defaultPendingText': 'Pending',
    },
  ];

  void _toggleMed(int index) {
    setState(() {
      _meds[index]['taken'] = !(_meds[index]['taken'] as bool);
    });
    final isTaken = _meds[index]['taken'] as bool;
    final name = _meds[index]['name'] as String;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isTaken ? '$name marked as taken' : '$name marked as pending'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.access_time_filled_rounded, color: Color(0xFF00B4D8), size: 16),
              const SizedBox(width: 6),
              Text(
                "Today's Medication Schedule — 15 May 2026",
                style: AppTextStyles.labelMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _meds.length,
            separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final med = _meds[index];
              final isTaken = med['taken'] as bool;
              final iconBg = med['iconBg'] as Color;
              final iconColor = med['iconColor'] as Color;
              final icon = med['icon'] as IconData;
              final name = med['name'] as String;
              final desc = med['desc'] as String;
              final time = med['time'] as String;
              final defaultPendingText = med['defaultPendingText'] as String;

              return InkWell(
                onTap: () => _toggleMed(index),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF112240),
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: iconBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Icon(icon, color: iconColor, size: 16),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              desc,
                              style: const TextStyle(color: AppColors.secondaryText, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            time,
                            style: const TextStyle(color: AppColors.secondaryText, fontSize: 11),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            isTaken ? 'Taken ✓' : defaultPendingText,
                            style: TextStyle(
                              color: isTaken ? AppColors.success : (defaultPendingText == 'Due tonight' ? AppColors.secondaryAccent : AppColors.secondaryText),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: isTaken ? AppColors.success : Colors.transparent,
                          border: Border.all(
                            color: isTaken ? AppColors.success : AppColors.border,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: isTaken
                            ? const Icon(Icons.check, size: 14, color: Colors.white)
                            : null,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
