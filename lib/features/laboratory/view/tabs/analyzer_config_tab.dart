import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AnalyzerConfigTab extends StatefulWidget {
  const AnalyzerConfigTab({super.key});

  @override
  State<AnalyzerConfigTab> createState() => _AnalyzerConfigTabState();
}

class _AnalyzerConfigTabState extends State<AnalyzerConfigTab> {
  // Mock analyzer hardware configurations
  final List<Map<String, dynamic>> _analyzers = [
    {
      'name': 'Sysmex XN-550',
      'specialty': 'Hematology & Cell Counter',
      'linkedTests': 'CBC, WBC, RBC, Platelets, Hb',
      'calibrationStatus': 'Good',
      'calibrationRemaining': '18 hours left',
      'dailyRuns': 42,
      'isCalibrating': false,
    },
    {
      'name': 'Cobas c311 Analyzer',
      'specialty': 'Clinical Biochemistry',
      'linkedTests': 'Electrolytes, HbA1c, Lipids, LFT',
      'calibrationStatus': 'Good',
      'calibrationRemaining': '11 hours left',
      'dailyRuns': 87,
      'isCalibrating': false,
    },
    {
      'name': 'GeneXpert IV Molecular',
      'specialty': 'Microbiology & PCR assays',
      'linkedTests': 'Sputum PCR, Gene sequencing',
      'calibrationStatus': 'Calibrating Required',
      'calibrationRemaining': 'Expired (Recalibrate)',
      'dailyRuns': 14,
      'isCalibrating': false,
    },
  ];

  void _triggerCalibration(int index) {
    setState(() {
      _analyzers[index]['isCalibrating'] = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _analyzers[index]['isCalibrating'] = false;
          _analyzers[index]['calibrationStatus'] = 'Good';
          _analyzers[index]['calibrationRemaining'] = '24 hours left';
          _analyzers[index]['dailyRuns'] =
              0; // reset run counter after calibration
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.success,
            content: Text(
              '${_analyzers[index]['name']} successfully calibrated and initialized for daily runs!',
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Informational intro banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.settings_input_component_rounded,
                color: AppColors.secondaryAccent,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Physical Diagnostic Analyzer Deck: Track machine telemetry, calibration boundaries, and daily sample workloads to ensure laboratory accuracy score standards.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primaryText,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // 2. Grid of Analyzers
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth > 850
                ? 3
                : (constraints.maxWidth > 550 ? 2 : 1);
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _analyzers.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 220,
              ),
              itemBuilder: (context, index) {
                final machine = _analyzers[index];
                final isCalibrating = machine['isCalibrating'] as bool;
                final isExpired =
                    machine['calibrationStatus'] == 'Calibrating Required';
                final calibrationColor = isExpired
                    ? AppColors.error
                    : AppColors.success;

                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isExpired
                          ? AppColors.error.withValues(alpha: 0.3)
                          : AppColors.border,
                    ),
                  ),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              machine['name'] as String,
                              style: AppTextStyles.labelLarge.copyWith(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: calibrationColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              machine['calibrationStatus'] as String,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: calibrationColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        machine['specialty'] as String,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Divider(color: AppColors.border, height: 1),
                      const SizedBox(height: 12),
                      _buildTelemetryRow(
                        'Linked Panels',
                        machine['linkedTests'] as String,
                      ),
                      const SizedBox(height: 6),
                      _buildTelemetryRow(
                        'Calibration Time',
                        machine['calibrationRemaining'] as String,
                      ),
                      const SizedBox(height: 6),
                      _buildTelemetryRow(
                        'Daily Sample Workload',
                        '${machine['dailyRuns']} Runs today',
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 38,
                        child: isCalibrating
                            ? const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.secondaryAccent,
                                    ),
                                  ),
                                ),
                              )
                            : ElevatedButton.icon(
                                onPressed: () => _triggerCalibration(index),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isExpired
                                      ? AppColors.error
                                      : AppColors.secondaryAccent,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                icon: const Icon(Icons.build_rounded, size: 14),
                                label: const Text(
                                  'CALIBRATE HARDWARE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildTelemetryRow(String label, String val) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            val,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primaryText,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
