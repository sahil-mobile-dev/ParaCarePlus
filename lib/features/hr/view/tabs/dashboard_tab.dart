import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _metricCard(
                'Total Roster Staff',
                '342',
                '12 Active Doctors',
                AppColors.primary,
                Icons.groups_rounded,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _metricCard(
                'Staff On Duty',
                '184',
                'Biometric Synced',
                AppColors.success,
                Icons.badge_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _metricCard(
                'Pending Leaves',
                '12',
                'Requires Review',
                AppColors.error,
                Icons.beach_access_rounded,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _metricCard(
                'Open Openings',
                '08',
                'Job Applications',
                AppColors.secondaryAccent,
                Icons.work_outline_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _buildDistributionCard(),
        const SizedBox(height: AppSpacing.lg),
        _buildApprovalsList(),
      ],
    );
  }

  Widget _metricCard(
    String label,
    String value,
    String sub,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  sub,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistributionCard() {
    final data = <Map<String, dynamic>>[
      {
        'dept': 'Medical / Doctors',
        'count': 82,
        'ratio': 0.24,
        'color': AppColors.primary,
      },
      {
        'dept': 'Nursing / Clinical Support',
        'count': 145,
        'ratio': 0.42,
        'color': AppColors.success,
      },
      {
        'dept': 'Administrative Staff',
        'count': 54,
        'ratio': 0.16,
        'color': AppColors.secondaryAccent,
      },
      {
        'dept': 'Tech / Labs / Radiology',
        'count': 61,
        'ratio': 0.18,
        'color': AppColors.primaryLight,
      },
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
          Text(
            'Staffing Distribution by Department',
            style: AppTextStyles.labelLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Headcount ratio throughout enterprise HIMS',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 16),
          ...data.map((item) {
            final color = item['color'] as Color;
            final dept = item['dept'] as String;
            final ratio = item['ratio'] as double;
            final count = item['count'] as int;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(dept, style: AppTextStyles.bodyMedium),
                        ],
                      ),
                      Text(
                        '$count Staff (${(ratio * 100).toStringAsFixed(0)}%)',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: ratio,
                    backgroundColor: AppColors.background,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildApprovalsList() {
    final approvals = <Map<String, String>>[
      {
        'name': 'Shashi Kiran',
        'role': 'Staff Nurse - ICU',
        'type': 'Casual Leave Request',
        'date': 'May 24 - May 26',
      },
      {
        'name': 'Dr. Rohan Mehra',
        'role': 'Pediatric Head',
        'type': 'Medical Allowance Claim',
        'date': '₹18,500 claimed',
      },
      {
        'name': 'Aman Rawat',
        'role': 'HR Admin Coordinator',
        'type': 'Maternity Extension Request',
        'date': 'Requires HOD signoff',
      },
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
          Text(
            'Pending HR Actions',
            style: AppTextStyles.labelLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Items requiring administrative verification',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),
          ...approvals.map((act) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppColors.border,
                    radius: 18,
                    child: Icon(
                      Icons.person_rounded,
                      color: AppColors.secondaryText,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          act['name']!,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${act['role']} | ${act['type']}',
                          style: AppTextStyles.bodySmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          act['date']!,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.secondaryAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.success,
                          size: 22,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.cancel_rounded,
                          color: AppColors.error,
                          size: 22,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
