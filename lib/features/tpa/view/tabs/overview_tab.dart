import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        final isMedium =
            constraints.maxWidth > 600 && constraints.maxWidth <= 900;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Metrics Grid
            GridView.count(
              crossAxisCount: isWide ? 4 : (isMedium ? 2 : 1),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: isWide ? 2.0 : 2.5,
              children: [
                _metricCard(
                  'Co-Partnered TPAs',
                  '12 Active',
                  'Star Health, Niva Bupa...',
                  AppColors.primary,
                  Icons.business_rounded,
                ),
                _metricCard(
                  'Total Claims Filed',
                  '284',
                  'FY 2025-26 logs',
                  AppColors.success,
                  Icons.assignment_rounded,
                ),
                _metricCard(
                  'Pending Claims Vol',
                  '₹42.8 Lakhs',
                  'Under TPA Review',
                  AppColors.secondaryAccent,
                  Icons.hourglass_top_rounded,
                ),
                _metricCard(
                  'Rejection Ratio',
                  '3.4%',
                  'Industry Avg: 6.2%',
                  AppColors.error,
                  Icons.gpp_bad_rounded,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Performance and High Priority Action Sections
            Flex(
              direction: isWide ? Axis.horizontal : Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: isWide ? 3 : 0,
                  child: _buildInsurerPerformanceGrid(),
                ),
                if (isWide)
                  const SizedBox(width: AppSpacing.lg)
                else
                  const SizedBox(height: AppSpacing.lg),
                Expanded(
                  flex: isWide ? 3 : 0,
                  child: _buildHighPriorityApprovals(context),
                ),
              ],
            ),
          ],
        );
      },
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.secondaryText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsurerPerformanceGrid() {
    final insurers = <Map<String, dynamic>>[
      {
        'name': 'Star Health Insurance',
        'claims': 112,
        'ratio': 0.96,
        'color': AppColors.success,
      },
      {
        'name': 'Niva Bupa Health',
        'claims': 84,
        'ratio': 0.92,
        'color': AppColors.primary,
      },
      {
        'name': 'HDFC ERGO General',
        'claims': 52,
        'ratio': 0.89,
        'color': AppColors.primaryLight,
      },
      {
        'name': 'ICICI Lombard GIC',
        'claims': 36,
        'ratio': 0.85,
        'color': AppColors.secondaryAccent,
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
            'TPA Claim Settlement Performance',
            style: AppTextStyles.labelLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Top co-partnered insurer settlement metrics',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 16),
          ...insurers.map((ins) {
            final name = ins['name'] as String;
            final claims = ins['claims'] as int;
            final ratio = ins['ratio'] as double;
            final color = ins['color'] as Color;

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
                          Text(name, style: AppTextStyles.bodyMedium),
                        ],
                      ),
                      Text(
                        '$claims Claims (${(ratio * 100).toStringAsFixed(0)}% Settled)',
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

  Widget _buildHighPriorityApprovals(BuildContext context) {
    final highPriority = <Map<String, String>>[
      {
        'name': 'Ramesh Kumar',
        'tpa': 'Star Health',
        'amount': '₹1,24,000',
        'type': 'IPD Pre-Auth Surgery',
      },
      {
        'name': 'Dr. Sonia Sen',
        'tpa': 'Niva Bupa',
        'amount': '₹85,500',
        'type': 'Angioplasty Settlement',
      },
      {
        'name': 'Vipin Rawat',
        'tpa': 'HDFC ERGO',
        'amount': '₹2,10,000',
        'type': 'Orthopedic Implant Pre-Auth',
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
            'High-Priority TPA Actions',
            style: AppTextStyles.labelLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Pre-authorizations requiring urgent TPA desk verification',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),
          ...highPriority.map((act) {
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
                      Icons.shield_rounded,
                      color: AppColors.primary,
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
                          '${act['tpa']} | ${act['type']}',
                          style: AppTextStyles.bodySmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          act['amount']!,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.secondaryAccent,
                            fontWeight: FontWeight.bold,
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
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.success,
                              content: Text(
                                'Verification sent to ${act['tpa']} for ${act['name']}!',
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.info_outline,
                          color: AppColors.primary,
                          size: 22,
                        ),
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: AppColors.surface,
                                title: const Text('Priority Action Details'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Patient: ${act['name']}',
                                      style: AppTextStyles.bodyMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Insurer: ${act['tpa']}',
                                      style: AppTextStyles.bodyMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Type: ${act['type']}',
                                      style: AppTextStyles.bodyMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Estimated Payout: ${act['amount']}',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: AppColors.secondaryAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
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
