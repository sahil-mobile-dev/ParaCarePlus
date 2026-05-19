import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class PendingTasksList extends StatelessWidget {
  const PendingTasksList({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      {
        'title': '5 Leave Requests pending',
        'subtitle': 'HR Module • Waiting for approval',
        'icon': Icons.person_off_outlined,
        'color': Colors.orange,
      },
      {
        'title': '2 Purchase Orders for approval',
        'subtitle': 'Inventory Module • Managed by you',
        'icon': Icons.shopping_cart_outlined,
        'color': Colors.blue,
      },
      {
        'title': '3 Blood Cross-match pending',
        'subtitle': 'Blood Bank • High Priority',
        'icon': Icons.bloodtype_outlined,
        'color': Colors.red,
      },
      {
        'title': '7 Drug Expiry items action needed',
        'subtitle': 'Pharmacy Module • Needs attention',
        'icon': Icons.medication_outlined,
        'color': Colors.orange,
      },
    ];

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
                    Icons.assignment_turned_in_outlined,
                    color: AppColors.secondaryAccent,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Pending Approvals & Tasks',
                    style: AppTextStyles.titleSmall,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  '12 TOTAL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ...tasks.map((t) => _buildTaskItem(t)),
        ],
      ),
    );
  }

  Widget _buildTaskItem(Map<String, dynamic> t) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (t['color'] as Color).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              t['icon'] as IconData,
              size: 16,
              color: t['color'] as Color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t['title'] as String,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  t['subtitle'] as String,
                  style: AppTextStyles.labelSmall.copyWith(fontSize: 9),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('View', style: TextStyle(fontSize: 10)),
          ),
        ],
      ),
    );
  }
}
