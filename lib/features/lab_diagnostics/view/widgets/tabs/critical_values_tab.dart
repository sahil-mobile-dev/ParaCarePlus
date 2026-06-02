import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/lab_diagnostics/view_model/lab_diagnostics_view_model.dart';

class CriticalValuesTab extends ConsumerWidget {
  const CriticalValuesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(labDiagnosticsProvider);
    final notifier = ref.read(labDiagnosticsProvider.notifier);

    final unackCount = state.criticalValues.where((c) => !c.acknowledged).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Alert banner
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.15),
            border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.error_outline_rounded, color: AppColors.error),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '$unackCount Critical Values Unacknowledged! Treating clinicians must acknowledge these within 30 minutes as per hospital policy.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        // List of critical findings
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.criticalValues.length,
          itemBuilder: (context, index) {
            final c = state.criticalValues[index];

            return Opacity(
              opacity: c.acknowledged ? 0.6 : 1.0,
              child: Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: c.acknowledged 
                        ? AppColors.border.withValues(alpha: 0.5) 
                        : AppColors.error,
                    width: c.acknowledged ? 1.0 : 2.0,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c.patientName,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.error,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${c.id} | ${c.ward}',
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondaryText),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _buildParamItem('TEST', c.test),
                              const SizedBox(width: 24),
                              _buildParamItem('RESULT VALUE', c.value, isAlert: true),
                              const SizedBox(width: 24),
                              _buildParamItem('NORMAL REFERENCE', c.normalRange),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              c.flag,
                              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Assigned Treating Clinician: ${c.doctor}',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryLight),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Column(
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                          icon: const Icon(Icons.phone_in_talk_rounded, color: Colors.white, size: 14),
                          label: const Text('CALL CLINICIAN', style: TextStyle(color: Colors.white, fontSize: 11)),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Dialing ${c.doctor} (Ext. 2245). Urgent HIMS alert dispatched.'),
                                backgroundColor: AppColors.error,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        if (!c.acknowledged)
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondaryAccent),
                            icon: const Icon(Icons.check_rounded, color: Colors.white, size: 14),
                            label: const Text('ACKNOWLEDGE', style: TextStyle(color: Colors.white, fontSize: 11)),
                            onPressed: () {
                              notifier.acknowledgeCritical(c.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Critical alert acknowledged. Timestamp recorded in HIMS audit logs.'),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                            },
                          )
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.border.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'ACKNOWLEDGED',
                              style: TextStyle(fontSize: 10, color: AppColors.secondaryText, fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildParamItem(String label, String value, {bool isAlert = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: AppColors.secondaryText, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: isAlert ? AppColors.error : AppColors.primaryText,
          ),
        ),
      ],
    );
  }
}
