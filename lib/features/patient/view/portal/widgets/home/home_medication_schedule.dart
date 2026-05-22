import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class HomeMedicationSchedule extends ConsumerStatefulWidget {
  const HomeMedicationSchedule({super.key});

  @override
  ConsumerState<HomeMedicationSchedule> createState() =>
      _HomeMedicationScheduleState();
}

class _HomeMedicationScheduleState
    extends ConsumerState<HomeMedicationSchedule> {
  final Map<int, bool> _medicationStatus = {
    0: true, // Metformin morning - Taken
    1: true, // Amlodipine morning - Taken
    2: false, // Metformin afternoon - Not Taken
    3: false, // Atorvastatin night - Not Taken
    4: false, // Losartan night - Not Taken
  };

  @override
  Widget build(BuildContext context) {
    return _buildChartCard(
      title: "Today's Medication Schedule",
      icon: Icons.medication_rounded,
      child: Column(
        children: [
          _buildMedItem(
            0,
            'Metformin 500mg',
            '1 tablet after breakfast · T2DM',
            '8:00 AM',
            AppColors.secondaryAccent,
          ),
          const SizedBox(height: 6),
          _buildMedItem(
            1,
            'Amlodipine 5mg',
            '1 tablet morning · Hypertension',
            '8:00 AM',
            AppColors.error,
          ),
          const SizedBox(height: 6),
          _buildMedItem(
            2,
            'Metformin 500mg',
            '1 tablet after lunch · T2DM',
            '2:00 PM',
            AppColors.primaryLight,
          ),
          const SizedBox(height: 6),
          _buildMedItem(
            3,
            'Atorvastatin 10mg',
            '1 tablet at night · Cholesterol',
            '9:00 PM',
            AppColors.success,
          ),
          const SizedBox(height: 6),
          _buildMedItem(
            4,
            'Losartan 50mg',
            '1 tablet at night · HTN',
            '9:00 PM',
            const Color(0xFFC77DFF),
          ),
        ],
      ),
    );
  }

  Widget _buildMedItem(
    int id,
    String name,
    String instructions,
    String time,
    Color color,
  ) {
    final isDone = _medicationStatus[id] ?? false;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.circle, color: color, size: 8),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    decoration: isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                Text(
                  instructions,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: AppColors.primaryLight,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                _medicationStatus[id] = !isDone;
              });
            },
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone ? AppColors.success : Colors.transparent,
                border: Border.all(
                  color: isDone ? AppColors.success : AppColors.border,
                ),
              ),
              child: isDone
                  ? const Icon(Icons.check, color: Colors.black, size: 12)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard({
    required String title,
    required IconData icon,
    required Widget child,
    Color color = AppColors.primaryLight,
  }) {
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
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
