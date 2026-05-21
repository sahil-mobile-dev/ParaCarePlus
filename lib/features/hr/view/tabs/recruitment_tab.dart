import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class RecruitmentTab extends StatefulWidget {
  const RecruitmentTab({super.key});

  @override
  State<RecruitmentTab> createState() => _RecruitmentTabState();
}

class _RecruitmentTabState extends State<RecruitmentTab> {
  final List<Map<String, dynamic>> _openings = [
    {
      'title': 'Senior Resident - Cardiology',
      'dept': 'Cardiology',
      'experience': '5+ Years MD/DM',
      'applicants': 14,
      'status': 'Active',
      'statusColor': AppColors.success,
    },
    {
      'title': 'Intensive Care Nurse (ICU)',
      'dept': 'Nursing Support',
      'experience': '2+ Years B.Sc/GNM',
      'applicants': 28,
      'status': 'Urgent',
      'statusColor': AppColors.error,
    },
    {
      'title': 'Senior Radiographer (CT/MRI)',
      'dept': 'Radiology',
      'experience': '3+ Years BMRIT',
      'applicants': 9,
      'status': 'Active',
      'statusColor': AppColors.success,
    },
    {
      'title': 'Medical Billing Supervisor',
      'dept': 'Billing Operations',
      'experience': '4+ Years Finance/MHA',
      'applicants': 6,
      'status': 'On Hold',
      'statusColor': AppColors.secondaryAccent,
    },
  ];

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
    {
      'candidate': 'Raman Malhotra',
      'role': 'Senior Radiographer',
      'panel': 'Dr. Meera Gupta (HOD)',
      'time': 'May 23, 11:15 AM',
      'stage': 'Modality Demo',
      'status': 'Scheduled',
      'statusColor': AppColors.primary,
    },
  ];

  void _scheduleInterview() {
    showDialog(
      context: context,
      builder: (context) {
        String name = '';
        String role = 'Intensive Care Nurse';
        String time = 'May 24, 03:00 PM';
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            'Schedule Interview',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.primaryText,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Candidate Name',
                  labelStyle: TextStyle(color: AppColors.secondaryText),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
                style: const TextStyle(color: AppColors.primaryText),
                onChanged: (val) => name = val,
              ),
              const SizedBox(height: AppSpacing.md),
              DropdownButtonFormField<String>(
                value: role,
                dropdownColor: AppColors.surface,
                decoration: const InputDecoration(
                  labelText: 'Opening Role',
                  labelStyle: TextStyle(color: AppColors.secondaryText),
                ),
                style: const TextStyle(color: AppColors.primaryText),
                items: const [
                  DropdownMenuItem(
                    value: 'Intensive Care Nurse',
                    child: Text('Intensive Care Nurse'),
                  ),
                  DropdownMenuItem(
                    value: 'Senior Resident - Cardiology',
                    child: Text('Senior Resident - Cardiology'),
                  ),
                  DropdownMenuItem(
                    value: 'Senior Radiographer',
                    child: Text('Senior Radiographer'),
                  ),
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
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.secondaryText),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              onPressed: () {
                if (name.isNotEmpty) {
                  setState(() {
                    _interviews.add({
                      'candidate': name,
                      'role': role,
                      'panel': 'Dr. Rohan Mehra / HOD',
                      'time': time,
                      'stage': 'Preliminary Assessment',
                      'status': 'Scheduled',
                      'statusColor': AppColors.primary,
                    });
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.success,
                      content: Text(
                        'Interview successfully scheduled for $name!',
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                'Schedule',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: _metricCard(
                'Clinical Openings',
                '${_openings.length}',
                '03 Urgent Positions',
                AppColors.primary,
                Icons.work_rounded,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _metricCard(
                'Active Applicants',
                '57',
                '+14 Today',
                AppColors.success,
                Icons.people_outline_rounded,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(
              child: _metricCard(
                'Interviews Booked',
                '${_interviews.length}',
                'Next 48 Hours',
                AppColors.secondaryAccent,
                Icons.event_available_rounded,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _metricCard(
                'Offer Letters Sent',
                '03',
                'Awaiting Signoff',
                AppColors.primaryLight,
                Icons.mark_email_read_rounded,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.lg),
        _buildClinicalOpeningsCard(),
        const SizedBox(height: AppSpacing.lg),
        _buildInterviewScheduleCard(),
      ],
    );
  }

  Widget _metricCard(
    String label,
    String value,
    String sub,
    Color color,
    IconData icon,
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
            child: Icon(icon, color: color, size: 24),
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
                Text(
                  value,
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  sub,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClinicalOpeningsCard() {
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
            'Clinical Job Openings',
            style: AppTextStyles.labelLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Active recruitments across healthcare roles',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _openings.length,
            itemBuilder: (context, index) {
              final job = _openings[index];
              final title = job['title'] as String;
              final dept = job['dept'] as String;
              final experience = job['experience'] as String;
              final applicants = job['applicants'] as int;
              final status = job['status'] as String;
              final statusColor = job['statusColor'] as Color;
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
                          Text(
                            title,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$dept | $experience',
                            style: AppTextStyles.bodySmall,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '$applicants applicants received',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: statusColor.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Interview Calendars & Pipeline',
                    style: AppTextStyles.labelLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Upcoming interviews and assessments',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: _scheduleInterview,
                icon: const Icon(Icons.add, size: 14),
                label: const Text('Schedule', style: TextStyle(fontSize: 11)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
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
              final stage = inter['stage'] as String;
              final panel = inter['panel'] as String;
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
                      child: Icon(
                        Icons.videocam_rounded,
                        color: AppColors.primary,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            candidate,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$role | $stage',
                            style: AppTextStyles.bodySmall,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Panel: $panel',
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.secondaryText,
                            ),
                          ),
                          Text(
                            time,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.secondaryAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (status == 'Scheduled')
                          TextButton(
                            onPressed: () {
                              setState(() {
                                inter['status'] = 'Completed';
                                inter['statusColor'] = AppColors.success;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: AppColors.success,
                                  content: Text(
                                    'Interview marked as Completed!',
                                  ),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                            ),
                            child: const Text(
                              'Mark Complete',
                              style: TextStyle(
                                color: AppColors.success,
                                fontSize: 10,
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
      ),
    );
  }
}
