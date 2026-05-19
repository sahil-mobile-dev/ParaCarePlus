import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class CriticalValuesTab extends StatefulWidget {
  const CriticalValuesTab({super.key});

  @override
  State<CriticalValuesTab> createState() => _CriticalValuesTabState();
}

class _CriticalValuesTabState extends State<CriticalValuesTab> {
  // Mock list of critical values
  final List<Map<String, dynamic>> _criticalLogs = [
    {
      'sampleId': 'EMGPAT-20260519-00002',
      'patientName': 'Sunita Rawat',
      'mrn': 'MRN-87421',
      'location': 'Ward Bed-04',
      'testName': 'Serum Potassium (K+)',
      'observedValue': '6.8 mmol/L',
      'referenceRange': '3.5 - 5.1 mmol/L',
      'alertLevel': 'CRITICAL HIGH',
      'assignedDoctor': 'Dr. Negi',
      'timestamp': '19-05-2026 12:48',
    },
    {
      'sampleId': 'OPDPAT-20260519-00010',
      'patientName': 'Suresh Chandra',
      'mrn': 'MRN-22105',
      'location': 'OPD Medicine Clinic',
      'testName': 'Hemoglobin (Hb)',
      'observedValue': '5.2 g/dL',
      'referenceRange': '13.5 - 17.5 g/dL',
      'alertLevel': 'CRITICAL LOW',
      'assignedDoctor': 'Dr. Semwal',
      'timestamp': '19-05-2026 11:30',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Alert banner header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: AppColors.error,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Safety Protocol: All life-threatening critical findings must be reported to the prescribing ward clinician within 15 minutes of detection.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        Text(
          'Active High-Alert Pathology Findings (${_criticalLogs.length})',
          style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppSpacing.md),

        // 2. Critical cards list
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _criticalLogs.length,
          itemBuilder: (context, index) {
            final log = _criticalLogs[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.error.withValues(alpha: 0.4),
                ),
              ),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            log['patientName'] as String,
                            style: AppTextStyles.labelLarge.copyWith(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${log['mrn']} | Location: ${log['location']}',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          log['alertLevel'] as String,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: Colors.white,
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
                        flex: 2,
                        child: _buildValueColumn(
                          'TEST PARAMETER',
                          log['testName'] as String,
                          false,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: _buildValueColumn(
                          'OBSERVED VALUE',
                          log['observedValue'] as String,
                          true,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: _buildValueColumn(
                          'NORMAL BOUNDS',
                          log['referenceRange'] as String,
                          false,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: _buildValueColumn(
                          'DETECTED TIME',
                          log['timestamp'] as String,
                          false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.primary,
                              content: Text(
                                'Alert acknowledged and approved for ${log['patientName']}.',
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.secondaryText,
                          side: const BorderSide(color: AppColors.border),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Text(
                          'APPROVE ALERT',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.secondaryAccent,
                              content: Text(
                                'Emergency call dispatched to ${log['location']}! Clinician ${log['assignedDoctor']} notified.',
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Text(
                          '🚨 ESCALATE TO WARD',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildValueColumn(String label, String value, bool isRed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isRed ? AppColors.error : AppColors.primaryText,
            fontWeight: isRed ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
