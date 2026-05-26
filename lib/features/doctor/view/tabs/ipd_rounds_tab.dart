import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/doctor/view_model/doctor_dashboard_view_model.dart';

class IpdRoundsTab extends ConsumerStatefulWidget {
  const IpdRoundsTab({super.key});

  @override
  ConsumerState<IpdRoundsTab> createState() => _IpdRoundsTabState();
}

class _IpdRoundsTabState extends ConsumerState<IpdRoundsTab> {
  IpdPatient? _selectedPatient;
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _selectPatient(IpdPatient patient) {
    setState(() {
      _selectedPatient = patient;
      _notesController.text = patient.clinicalNotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(doctorDashboardViewModelProvider);
    final notifier = ref.read(doctorDashboardViewModelProvider.notifier);

    // Synchronize selected patient if state updates
    if (_selectedPatient != null) {
      final match = state.ipdPatients.firstWhere(
        (p) => p.bed == _selectedPatient!.bed,
        orElse: () => _selectedPatient!,
      );
      _selectedPatient = match;
    } else if (state.ipdPatients.isNotEmpty) {
      _selectedPatient = state.ipdPatients[0];
      _notesController.text = _selectedPatient!.clinicalNotes;
    }

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
                      // Left side - Patient checklist
                      Expanded(
                        flex: 10,
                        child: _buildPatientList(state),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      // Right side - Rounds details sheet
                      Expanded(
                        flex: 12,
                        child: _buildRoundsDetailsSheet(notifier),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: _buildPatientList(state),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Expanded(
                        child: _buildRoundsDetailsSheet(notifier),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(DoctorDashboardState state) {
    final pendingRounds = state.ipdPatients.where((p) => p.roundStatus == 'Pending').length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('IPD Ward Rounds Tracker', style: AppTextStyles.titleMedium),
        const SizedBox(height: 2),
        Text(
          'Check active ward admissions. $pendingRounds patients pending clinical rounds today.',
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondaryText),
        ),
      ],
    );
  }

  Widget _buildPatientList(DoctorDashboardState state) {
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
            'WARD CHECKLIST (${state.ipdPatients.length})',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: ListView.separated(
              itemCount: state.ipdPatients.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final p = state.ipdPatients[i];
                final isSelected = _selectedPatient?.bed == p.bed;
                final isCritical = p.vitalsStatus == 'Critical';
                final isWarning = p.vitalsStatus == 'Warning';
                final isDone = p.roundStatus == 'Done';

                var statusColor = AppColors.success;
                if (isCritical) {
                  statusColor = AppColors.error;
                } else if (isWarning) {
                  statusColor = Colors.orange;
                }

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.surface : AppColors.background.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : isCritical
                              ? AppColors.error.withValues(alpha: 0.5)
                              : AppColors.border,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    onTap: () => _selectPatient(p),
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
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: isDone ? AppColors.success.withValues(alpha: 0.15) : Colors.orange.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isDone ? AppColors.success : Colors.orange,
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            isDone ? 'ROUND COMPLETED' : 'PENDING',
                            style: TextStyle(
                              color: isDone ? AppColors.success : Colors.orange,
                              fontSize: 8,
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
                        Row(
                          children: [
                            Text(
                              p.bed,
                              style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                            ),
                            const Spacer(),
                            Text(
                              'Vitals: ',
                              style: AppTextStyles.bodySmall.copyWith(fontSize: 10),
                            ),
                            Text(
                              '${p.systolicBP}/${p.diastolicBP} BP · ${p.pulse} HR',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.5,
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
          ),
        ],
      ),
    );
  }

  Widget _buildRoundsDetailsSheet(DoctorDashboardViewModel notifier) {
    if (_selectedPatient == null) return const SizedBox();

    final p = _selectedPatient!;
    final isCritical = p.vitalsStatus == 'Critical';
    final isWarning = p.vitalsStatus == 'Warning';

    var vitalsColor = AppColors.success;
    if (isCritical) {
      vitalsColor = AppColors.error;
    } else if (isWarning) {
      vitalsColor = Colors.orange;
    }

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
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.surface,
                child: Text(
                  p.gender == 'Male' ? 'M' : 'F',
                  style: const TextStyle(color: AppColors.primaryLight, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.name, style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text(
                      '${p.gender} · ${p.age} yrs · Bed: ${p.bed}',
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondaryText),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.border, height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildSectionHeader('Clinical Diagnosis'),
                const SizedBox(height: 6),
                Text(
                  p.diagnosis,
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryText, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                _buildSectionHeader('Current Vital Signs Monitor'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildVitalIndicator(
                        Icons.favorite_rounded,
                        'PULSE RATE',
                        '${p.pulse} bpm',
                        vitalsColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildVitalIndicator(
                        Icons.bloodtype_rounded,
                        'BLOOD PRESSURE',
                        '${p.systolicBP}/${p.diastolicBP} mmHg',
                        vitalsColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSectionHeader('Daily Rounds Progress Note'),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: TextField(
                    controller: _notesController,
                    maxLines: 5,
                    style: const TextStyle(color: AppColors.primaryText, fontSize: 12.5),
                    decoration: const InputDecoration(
                      hintText: 'Enter specific treatment adjustments or rounds updates...',
                      hintStyle: TextStyle(color: AppColors.secondaryText, fontSize: 11.5),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.border, height: 20),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  icon: const Icon(Icons.exit_to_app_rounded, size: 18, color: AppColors.success),
                  label: const Text('Discharge Fit', style: TextStyle(color: AppColors.success)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Discharge routing order queued for Patient ${p.name}.'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save_rounded, size: 18),
                  label: const Text('Save & Record Round'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    notifier.updateClinicalNotes(p.bed, _notesController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Round notes updated for Bed: ${p.bed}'),
                        backgroundColor: AppColors.primary,
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

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: AppTextStyles.labelSmall.copyWith(
        color: AppColors.secondaryText,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildVitalIndicator(IconData icon, String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Text(
                title,
                style: AppTextStyles.labelSmall.copyWith(fontSize: 8.5),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
