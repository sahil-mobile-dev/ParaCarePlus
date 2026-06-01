import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/doctor/view_model/doctor_dashboard_view_model.dart';

class OpdQueueTab extends ConsumerStatefulWidget {
  const OpdQueueTab({super.key});

  @override
  ConsumerState<OpdQueueTab> createState() => _OpdQueueTabState();
}

class _OpdQueueTabState extends ConsumerState<OpdQueueTab> {
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(doctorDashboardViewModelProvider);
    final notifier = ref.read(doctorDashboardViewModelProvider.notifier);

    final isWide = MediaQuery.of(context).size.width > 950;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(state),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Left side - Queue list
                      Expanded(
                        flex: 10,
                        child: _buildQueueList(state, notifier),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      // Right side - Active consult console
                      Expanded(
                        flex: 12,
                        child: _buildConsultConsole(state, notifier),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(child: _buildQueueList(state, notifier)),
                      const SizedBox(height: AppSpacing.lg),
                      Expanded(child: _buildConsultConsole(state, notifier)),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(DoctorDashboardState state) {
    final pendingCount = state.opdPatients
        .where((p) => p.status != 'Completed')
        .length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('OPD Consultations Desk', style: AppTextStyles.titleMedium),
        const SizedBox(height: 2),
        Text(
          'Manage queue of OPD tokens. $pendingCount patients waiting for review.',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildQueueList(
    DoctorDashboardState state,
    DoctorDashboardViewModel notifier,
  ) {
    final activeList = state.opdPatients
        .where((p) => p.status != 'Completed')
        .toList();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ACTIVE PATIENT QUEUE (${activeList.length})',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: activeList.isEmpty
                ? _buildEmptyQueueState()
                : ListView.separated(
                    itemCount: activeList.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, i) {
                      final p = activeList[i];
                      final isHigh = p.urgency == 'High';
                      final isConsulting = p.status == 'Consulting';

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isConsulting
                              ? AppColors.surface
                              : AppColors.background.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isConsulting
                                ? AppColors.primary
                                : isHigh
                                ? Colors.orange.withValues(alpha: 0.5)
                                : AppColors.border,
                            width: isConsulting ? 1.5 : 1,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: isConsulting
                                ? AppColors.primary
                                : isHigh
                                ? Colors.orange.withValues(alpha: 0.2)
                                : AppColors.card,
                            child: Text(
                              p.token.split('-').last,
                              style: TextStyle(
                                color: isConsulting
                                    ? Colors.white
                                    : isHigh
                                    ? Colors.orange
                                    : AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  p.name,
                                  style: AppTextStyles.labelMedium.copyWith(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: isHigh
                                      ? Colors.orange.withValues(alpha: 0.15)
                                      : AppColors.surface,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isHigh
                                        ? Colors.orange
                                        : AppColors.border,
                                    width: 0.5,
                                  ),
                                ),
                                child: Text(
                                  p.urgency.toUpperCase(),
                                  style: TextStyle(
                                    color: isHigh
                                        ? Colors.orange
                                        : AppColors.secondaryText,
                                    fontSize: 8.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                '${p.gender} · ${p.age} yrs · Symptom: ${p.symptom}',
                                style: AppTextStyles.bodySmall.copyWith(
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          trailing: isConsulting
                              ? const Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: AppColors.primaryLight,
                                )
                              : IconButton(
                                  icon: const Icon(
                                    Icons.play_circle_outline_rounded,
                                    color: AppColors.success,
                                  ),
                                  onPressed: () {
                                    notifier.startConsultation(p);
                                    _notesController.clear();
                                  },
                                  tooltip: 'Start Consultation',
                                ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsultConsole(
    DoctorDashboardState state,
    DoctorDashboardViewModel notifier,
  ) {
    final patient = state.consultingPatient;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: patient == null
          ? _buildEmptyConsoleState()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildActivePatientHeader(patient),
                const Divider(color: AppColors.border, height: 24),
                Expanded(
                  child: ListView(
                    children: [
                      const Text(
                        'EMR Consultation Notes',
                        style: AppTextStyles.labelMedium,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.background.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: TextField(
                          controller: _notesController,
                          maxLines: 6,
                          style: const TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 13,
                          ),
                          decoration: const InputDecoration(
                            hintText:
                                'Enter clinical history, physical observations, diagnosis...',
                            hintStyle: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 12,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Suggested Action Triggers',
                        style: AppTextStyles.labelMedium,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildActionChip(
                              Icons.medication_outlined,
                              'E-Prescription',
                              Colors.teal,
                              () {},
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildActionChip(
                              Icons.science_outlined,
                              'Order Lab Tests',
                              Colors.purple,
                              () {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildActionChip(
                              Icons.emergency_outlined,
                              'Refer to IPD Ward',
                              Colors.red,
                              () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Triage alert: Referral request routed to IPD admissions desk.',
                                    ),
                                    backgroundColor: AppColors.primary,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildActionChip(
                              Icons.assignment_turned_in_outlined,
                              'Fit Cert / Leave',
                              Colors.orange,
                              () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(color: AppColors.border, height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          // Cancel or suspend consult
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.secondaryText,
                        ),
                        child: const Text('Suspend Consult'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.check_circle_outline_rounded,
                          size: 18,
                        ),
                        label: const Text('Complete Consultation'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.success,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          notifier.completeConsultation(patient.token);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'OPD Consultation for ${patient.name} recorded successfully.',
                              ),
                              backgroundColor: AppColors.success,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildActivePatientHeader(OpdPatient patient) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primary.withValues(alpha: 0.15),
          child: const Icon(
            Icons.person_rounded,
            color: AppColors.primaryLight,
            size: 24,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                patient.name,
                style: AppTextStyles.titleSmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'TOKEN: ${patient.token} · ${patient.gender} · ${patient.age} yrs',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary, width: 0.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'CONSULTING',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 8.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionChip(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyQueueState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.checklist_rtl_rounded,
            size: 48,
            color: AppColors.secondaryText,
          ),
          SizedBox(height: 12),
          Text(
            'Queue Complete',
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'All waiting patients have been consulted.',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyConsoleState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.desk_rounded, size: 48, color: AppColors.secondaryText),
          SizedBox(height: 12),
          Text(
            'Clinical Workspace Active',
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Select a patient from the queue to load workspace.',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 11.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
