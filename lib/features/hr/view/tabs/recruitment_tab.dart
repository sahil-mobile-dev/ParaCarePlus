import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/hr/view_model/hr_view_model.dart';
import 'package:paracareplus/features/hr/model/hr_model.dart';

class RecruitmentTab extends ConsumerStatefulWidget {
  const RecruitmentTab({super.key});

  @override
  ConsumerState<RecruitmentTab> createState() => _RecruitmentTabState();
}

class _RecruitmentTabState extends ConsumerState<RecruitmentTab> {
  final List<Map<String, dynamic>> _interviews = [
    {
      'candidate': 'Dr. Nishant Vyas',
      'role': 'Senior Resident - Cardiology',
      'panel': 'Dr. Alok Verma (HOD)',
      'time': 'May 22, 10:30 AM',
      'stage': 'Technical Round',
      'status': 'Scheduled',
      'statusColor': AppColors.primary,
    },
    {
      'candidate': 'Priya Nair',
      'role': 'Intensive Care Nurse',
      'panel': 'Sister Bindu (ANS)',
      'time': 'May 22, 02:00 PM',
      'stage': 'Nursing Competency',
      'status': 'Selected',
      'statusColor': AppColors.success,
    },
  ];

  void _scheduleInterview() {
    final nameController = TextEditingController();
    var role = 'Intensive Care Nurse';

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: const Text('Schedule Interview', style: AppTextStyles.titleMedium),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Candidate Name',
                  labelStyle: TextStyle(color: AppColors.secondaryText),
                ),
                style: const TextStyle(color: AppColors.primaryText),
              ),
              const SizedBox(height: AppSpacing.md),
              DropdownButtonFormField<String>(
                value: role,
                dropdownColor: AppColors.surface,
                decoration: const InputDecoration(labelText: 'Opening Role'),
                style: const TextStyle(color: AppColors.primaryText),
                items: const [
                  DropdownMenuItem(value: 'Intensive Care Nurse', child: Text('Intensive Care Nurse')),
                  DropdownMenuItem(value: 'Senior Resident - Cardiology', child: Text('Senior Resident - Cardiology')),
                ],
                onChanged: (val) {
                  if (val != null) role = val;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: AppColors.secondaryText)),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text.trim();
                if (name.isNotEmpty) {
                  setState(() {
                    _interviews.add({
                      'candidate': name,
                      'role': role,
                      'panel': 'Dr. Rohan Mehra / HOD',
                      'time': 'May 24, 03:00 PM',
                      'stage': 'Preliminary Assessment',
                      'status': 'Scheduled',
                      'statusColor': AppColors.primary,
                    });
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.success,
                      content: Text('Interview scheduled for $name!'),
                    ),
                  );
                }
              },
              child: const Text('Schedule'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final openings = ref.watch(hrProvider.select((s) => s.recruitmentList));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: _metricCard('Clinical Openings', '${openings.length}', 'Active Positions', AppColors.primary, Icons.work_rounded),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _metricCard('Interviews Booked', '${_interviews.length}', 'Next 48 Hours', AppColors.secondaryAccent, Icons.event_available_rounded),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _buildClinicalOpeningsCard(openings),
        const SizedBox(height: AppSpacing.lg),
        _buildInterviewScheduleCard(),
      ],
    );
  }

  Widget _metricCard(String label, String value, String sub, Color color, IconData icon) {
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
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.labelSmall.copyWith(color: AppColors.secondaryText)),
                const SizedBox(height: 4),
                Text(value, style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(sub, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClinicalOpeningsCard(List<RecruitmentItem> openings) {
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
          Text('Clinical Job Openings', style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: openings.length,
            itemBuilder: (context, index) {
              final job = openings[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(job.title, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('${job.department} | ${job.openings} Openings', style: AppTextStyles.bodySmall),
                          const SizedBox(height: 2),
                          Text('${job.applicants} applicants received', style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                      ),
                      child: Text(job.status, style: const TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInterviewScheduleCard() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Interview Calendars & Pipeline', style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: _scheduleInterview,
                icon: const Icon(Icons.add, size: 14),
                label: const Text('Schedule', style: TextStyle(fontSize: 11)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  minimumSize: Size.zero,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _interviews.length,
            itemBuilder: (context, index) {
              final inter = _interviews[index];
              final candidate = inter['candidate'] as String;
              final role = inter['role'] as String;
              final time = inter['time'] as String;
              final status = inter['status'] as String;
              final statusColor = inter['statusColor'] as Color;

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
                      child: Icon(Icons.videocam_rounded, color: AppColors.primary, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(candidate, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                          Text('$role | ${inter['stage']}', style: AppTextStyles.bodySmall),
                          const SizedBox(height: 4),
                          Text(time, style: AppTextStyles.labelSmall.copyWith(color: AppColors.secondaryAccent)),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                          child: Text(status, style: TextStyle(color: statusColor, fontSize: 9, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 8),
                        if (status == 'Scheduled')
                          TextButton(
                            onPressed: () {
                              setState(() {
                                inter['status'] = 'Completed';
                                inter['statusColor'] = AppColors.success;
                              });
                            },
                            child: const Text('Mark Complete', style: TextStyle(color: AppColors.success, fontSize: 10)),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
