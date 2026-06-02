import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/lab_diagnostics/model/lab_diagnostics_model.dart';
import 'package:paracareplus/features/lab_diagnostics/view/widgets/lab_modals.dart';
import 'package:paracareplus/features/lab_diagnostics/view_model/lab_diagnostics_view_model.dart';

class UrgentStatTab extends ConsumerWidget {
  const UrgentStatTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(labDiagnosticsProvider);

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
              const Icon(Icons.warning_amber_rounded, color: AppColors.error),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${state.urgentTests.length} URGENT/STAT Tests Active — Target TAT: 1 hour. Clinical teams awaiting critical diagnostic outcomes.',
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
        // List of urgent tests
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.urgentTests.length,
          itemBuilder: (context, index) {
            final u = state.urgentTests[index];
            final isStat = u.priority.toUpperCase() == 'STAT';

            return Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.md),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isStat
                      ? AppColors.error.withValues(alpha: 0.3)
                      : AppColors.secondaryAccent.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: isStat
                                    ? AppColors.error.withValues(alpha: 0.15)
                                    : AppColors.secondaryAccent.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                u.priority,
                                style: TextStyle(
                                  color: isStat ? AppColors.error : AppColors.secondaryAccent,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              u.patientName,
                              style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tests Ordered: ${u.tests}',
                          style: const TextStyle(fontSize: 12, color: AppColors.secondaryText),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Specimen ID: ${u.id}',
                          style: const TextStyle(fontSize: 11, color: AppColors.secondaryText),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Column(
                    children: [
                      Text(
                        u.elapsed,
                        style: AppTextStyles.titleLarge.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('elapsed', style: TextStyle(fontSize: 10, color: AppColors.secondaryText)),
                      const SizedBox(height: 4),
                      Text(
                        'Target TAT left: ${u.remaining}',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                    onPressed: () {
                      // Find the full sample item from state list
                      final sample = state.samples.firstWhere(
                        (s) => s.id == u.id,
                        orElse: () => LabSampleItem(
                          id: u.id,
                          patientName: u.patientName,
                          mrn: 'MRN-Unknown',
                          tests: u.tests,
                          category: 'Haematology',
                          priority: u.priority,
                          doctor: 'Unknown',
                          collected: '—',
                          status: 'collected',
                        ),
                      );
                      LabModals.showResultEntry(context, ref, sample);
                    },
                    child: const Text('ENTER RESULT', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
