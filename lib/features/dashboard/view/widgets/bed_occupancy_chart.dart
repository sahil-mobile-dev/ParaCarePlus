import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/model/dashboard_models.dart';

class BedOccupancyChart extends StatelessWidget {
  final List<BedStatus> statuses;

  const BedOccupancyChart({super.key, required this.statuses});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Bed Occupancy by Department', style: AppTextStyles.titleMedium),
        const SizedBox(height: AppSpacing.md),
        ...statuses.map((status) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(status.department, style: AppTextStyles.bodyMedium),
                  Text(
                    '${status.occupiedBeds}/${status.totalBeds}',
                    style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: status.occupiedBeds / status.totalBeds,
                  minHeight: 8,
                  backgroundColor: AppColors.border,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getColorForOccupancy(status.occupiedBeds / status.totalBeds),
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Color _getColorForOccupancy(double ratio) {
    if (ratio > 0.9) return AppColors.error;
    if (ratio > 0.7) return AppColors.secondaryAccent;
    return AppColors.success;
  }
}
