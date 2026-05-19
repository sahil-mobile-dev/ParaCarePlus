import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/model/dashboard_models.dart';

class StaffOnDutyList extends StatelessWidget {
  final List<StaffOnDuty> staff;

  const StaffOnDutyList({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.badge_outlined,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Text('Staff On Duty', style: AppTextStyles.titleSmall),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View Full Roster',
                  style: AppTextStyles.labelSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ...staff.map(_buildStaffItem),
        ],
      ),
    );
  }

  Widget _buildStaffItem(StaffOnDuty s) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.surface,
            child: Icon(
              Icons.person_outline_rounded,
              size: 16,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.name,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${s.role} • ${s.department}',
                  style: AppTextStyles.labelSmall.copyWith(fontSize: 9),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Row(
              children: [
                Icon(Icons.circle, color: AppColors.success, size: 6),
                SizedBox(width: 4),
                Text(
                  'ON DUTY',
                  style: TextStyle(
                    color: AppColors.success,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
