import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class UrgentStatTab extends StatefulWidget {
  const UrgentStatTab({super.key});

  @override
  State<UrgentStatTab> createState() => _UrgentStatTabState();
}

class _UrgentStatTabState extends State<UrgentStatTab> {
  // Mock active urgent queue
  final List<Map<String, dynamic>> _urgentSamples = [
    {
      'sampleId': 'EMGPAT-20260519-00002',
      'patientName': 'Sunita Rawat',
      'mrn': 'MRN-87421',
      'testName': 'Serum Electrolytes',
      'orderedBy': 'Dr. Negi',
      'wardLocation': 'Emergency Ward Bed-04',
      'tatRemaining': '42 min remaining',
      'criticalValue': 'K+ 6.2 mmol/L (Severe)',
      'status': 'Processing',
    },
    {
      'sampleId': 'ICUPAT-20260519-00008',
      'patientName': 'Amit Singhal',
      'mrn': 'MRN-55410',
      'testName': 'Arterial Blood Gas (ABG)',
      'orderedBy': 'Dr. K.P. Sharma',
      'wardLocation': 'ICU Bed-12',
      'tatRemaining': '18 min remaining',
      'criticalValue': 'pH 7.21 (Critical Acidosis)',
      'status': 'Ordered',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. STAT Alert Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.error.withValues(alpha: 0.4)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.campaign_rounded,
                  color: AppColors.error,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Urgent / STAT Pathology Dispatch Active',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Strict Target Turnaround Time (TAT): 1 Hour from collection. Ensure fast diagnostics reporting.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // 2. Urgent List Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Active Emergency Requests (${_urgentSamples.length})',
              style: AppTextStyles.labelLarge
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'CRITICAL SPEED',
                style: AppTextStyles.labelSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // 3. Grid of Urgent Cards
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth > 800 ? 2 : 1;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _urgentSamples.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 220,
              ),
              itemBuilder: (context, index) {
                final sample = _urgentSamples[index];
                return _buildUrgentCard(sample);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildUrgentCard(Map<String, dynamic> sample) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sample['patientName'] as String,
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${sample['mrn']} | ${sample['wardLocation']}',
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.secondaryText),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  sample['tatRemaining'] as String,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem('REQ TEST', sample['testName'] as String),
              ),
              Expanded(
                child: _buildInfoItem('REQ PHYSICIAN', sample['orderedBy'] as String),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PRE-ALERT / PRELIM VAL',
                      style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 9,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      sample['criticalValue'] as String,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.secondaryAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.success,
                      content: Text('Dispatched fast priority alert to ${sample['wardLocation']}!'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: const Text('DISPATCH ALERT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 9,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.primaryText,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
