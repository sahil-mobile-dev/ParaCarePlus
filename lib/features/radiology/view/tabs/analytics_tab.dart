import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AnalyticsTab extends StatelessWidget {
  const AnalyticsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Department Performance Indicators'),
        const SizedBox(height: AppSpacing.lg),
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    'Monthly Scans',
                    '1,420',
                    '+12.4%',
                    Icons.show_chart_rounded,
                    AppColors.success,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMetricTile(
                    'Mean TAT (Scans)',
                    '34 min',
                    '-8.2%',
                    Icons.timer_outlined,
                    AppColors.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppRadius.md),
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    'AI CAD Triggers',
                    '142',
                    '+5.6%',
                    Icons.psychology_rounded,
                    AppColors.secondaryAccent,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMetricTile(
                    'Radiology Revenue',
                    '₹8.4L',
                    '+18.1%',
                    Icons.currency_rupee_rounded,
                    AppColors.primaryLight,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVolumeByModalityCard(),
            const SizedBox(height: AppSpacing.lg),
            _buildRadiologistReportingLoadCard(),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        const Icon(Icons.bar_chart_rounded, color: AppColors.primary, size: 22),
        const SizedBox(width: 8),
        Text(title, style: AppTextStyles.titleSmall),
      ],
    );
  }

  Widget _buildMetricTile(
    String label,
    String val,
    String trend,
    IconData icon,
    Color color,
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
            child: Icon(icon, color: color, size: 22),
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
                Row(
                  children: [
                    Text(
                      val,
                      style: AppTextStyles.titleSmall.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: trend.startsWith('+')
                            ? AppColors.success.withValues(alpha: 0.1)
                            : AppColors.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        trend,
                        style: TextStyle(
                          color: trend.startsWith('+')
                              ? AppColors.success
                              : AppColors.error,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVolumeByModalityCard() {
    final data = <Map<String, dynamic>>[
      {
        'modality': 'CT Scan',
        'count': 540,
        'ratio': 0.38,
        'color': AppColors.primary,
      },
      {
        'modality': 'MRI Scan',
        'count': 320,
        'ratio': 0.225,
        'color': AppColors.secondaryAccent,
      },
      {
        'modality': 'Digital X-Ray',
        'count': 410,
        'ratio': 0.288,
        'color': AppColors.success,
      },
      {
        'modality': 'Ultrasound USG',
        'count': 150,
        'ratio': 0.105,
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
            'Volume Analysis by Modality',
            style: AppTextStyles.labelLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Scan distribution by diagnostic category',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 16),
          ...data.map((item) {
            final color = item['color'] as Color;
            final modality = item['modality'] as String;
            final count = item['count'] as int;
            final ratio = item['ratio'] as double;
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
                          Text(modality, style: AppTextStyles.bodyMedium),
                        ],
                      ),
                      Text(
                        '$count Scans (${(ratio * 100).toStringAsFixed(1)}%)',
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

  Widget _buildRadiologistReportingLoadCard() {
    final load = <Map<String, dynamic>>[
      {
        'name': 'Dr. Meera Gupta',
        'assigned': 25,
        'pending': 4,
        'tat': '22 min',
        'status': 'Active',
      },
      {
        'name': 'Dr. Rajesh Sen',
        'assigned': 18,
        'pending': 1,
        'tat': '35 min',
        'status': 'Active',
      },
      {
        'name': 'Dr. Vineet Roy',
        'assigned': 15,
        'pending': 8,
        'tat': '42 min',
        'status': 'Busy',
      },
      {
        'name': 'Dr. S. K. Nayak',
        'assigned': 8,
        'pending': 0,
        'tat': '18 min',
        'status': 'Idle',
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
            'Radiologist Report Loads',
            style: AppTextStyles.labelLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Real-time interpretation workflow metrics',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1.8),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(1.2),
            },
            children: [
              TableRow(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.border)),
                ),
                children: [
                  _headerCell('Radiologist'),
                  _headerCell('Daily Scans'),
                  _headerCell('Pending'),
                  _headerCell('Avg TAT'),
                ],
              ),
              ...load.map((doc) {
                final name = doc['name'] as String;
                final status = doc['status'] as String;
                final assigned = doc['assigned'] as int;
                final pending = doc['pending'] as int;
                final tat = doc['tat'] as String;
                return TableRow(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColors.border)),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            status,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: status == 'Busy'
                                  ? AppColors.error
                                  : AppColors.success,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _cell(assigned.toString()),
                    _cell(
                      pending.toString(),
                      isBold: true,
                      color: pending > 3
                          ? AppColors.error
                          : AppColors.primaryText,
                    ),
                    _cell(tat),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerCell(String t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        t,
        style: AppTextStyles.labelSmall.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _cell(String val, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          val,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: color ?? AppColors.primaryText,
          ),
        ),
      ),
    );
  }
}
