import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';

class MapsStatsBar extends StatelessWidget {
  const MapsStatsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _StatCard(
          value: '8',
          label: 'Hospitals Nearby',
          color: AppColors.primaryLight,
        ),
        SizedBox(width: 12),
        _StatCard(
          value: '24',
          label: 'Open Pharmacies',
          color: AppColors.success,
        ),
        SizedBox(width: 12),
        _StatCard(
          value: '3',
          label: 'Ambulances Active',
          color: AppColors.secondaryAccent,
        ),
        SizedBox(width: 12),
        _StatCard(
          value: '47',
          label: 'Online Doctors',
          color: Color(0xFFC77DFF),
        ),
        SizedBox(width: 12),
        _StatCard(
          value: '4.2',
          label: 'Nearest ETA (km)',
          color: AppColors.error,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
