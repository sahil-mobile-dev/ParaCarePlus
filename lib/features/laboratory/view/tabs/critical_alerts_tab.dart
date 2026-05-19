import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class CriticalAlertsTab extends StatefulWidget {
  const CriticalAlertsTab({super.key});

  @override
  State<CriticalAlertsTab> createState() => _CriticalAlertsTabState();
}

class _RxAlertItem {
  final String id;
  final String patient;
  final String ward;
  final String testName;
  final String parameter;
  final String observedVal;
  final String refRange;
  final String severity;

  _RxAlertItem({
    required this.id,
    required this.patient,
    required this.ward,
    required this.testName,
    required this.parameter,
    required this.observedVal,
    required this.refRange,
    required this.severity,
  });
}

class _CriticalAlertsTabState extends State<CriticalAlertsTab> {
  final List<_RxAlertItem> _alerts = [
    _RxAlertItem(
      id: 'ALT-301',
      patient: 'Devendra Rawat',
      ward: 'ICU Bed 3',
      testName: 'Serum Electrolytes',
      parameter: 'Potassium (K+)',
      observedVal: '6.8 mmol/L',
      refRange: '3.5 - 5.0 mmol/L',
      severity: 'CRITICAL HIGH',
    ),
    _RxAlertItem(
      id: 'ALT-302',
      patient: 'Sanjay Joshi',
      ward: 'Emergency Bed 5',
      testName: 'Complete Blood Count',
      parameter: 'Hemoglobin (Hb)',
      observedVal: '5.2 g/dL',
      refRange: '12.0 - 16.0 g/dL',
      severity: 'CRITICAL LOW',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'High-Urgency Abnormal Findings',
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  '${_alerts.length} Critical Alerts',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_alerts.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: const Center(
              child: Column(
                children: [
                  Icon(
                    Icons.health_and_safety_rounded,
                    size: 48,
                    color: AppColors.success,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'No critical abnormal alerts. All patient values stable!',
                    style: TextStyle(color: AppColors.secondaryText),
                  ),
                ],
              ),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _alerts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 900 ? 2 : 1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 220,
            ),
            itemBuilder: (context, index) {
              final alert = _alerts[index];
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.error, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.error.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            alert.severity,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          alert.ward,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      alert.patient,
                      style: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Test: ${alert.testName} (${alert.parameter})',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.background.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: AppColors.border,
                            width: 0.5,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Observed Value',
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  alert.observedVal,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.error,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Normal Reference Bounds',
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  alert.refRange,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.primaryText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              _handleAlertAction(
                                index,
                                'escalated to ${alert.ward} charge nurse',
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.error,
                              side: const BorderSide(
                                color: AppColors.error,
                                width: 0.5,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text(
                              'Escalate to Ward',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _handleAlertAction(
                                index,
                                'approved and sent to clinician',
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.success,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text(
                              'Approve Alert',
                              style: TextStyle(fontSize: 11),
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

  void _handleAlertAction(int index, String outcome) {
    final alert = _alerts[index];
    setState(() {
      _alerts.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: outcome.contains('approved')
            ? AppColors.success
            : AppColors.error,
        content: Text('Critical Alert for ${alert.patient} was $outcome!'),
      ),
    );
  }
}
