import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class TrainingTab extends StatefulWidget {
  const TrainingTab({super.key});

  @override
  State<TrainingTab> createState() => _TrainingTabState();
}

class _TrainingTabState extends State<TrainingTab> {
  final List<Map<String, dynamic>> _courses = [
    {
      'title': 'Advanced Cardiac Life Support (ACLS)',
      'code': 'CME-ACLS-2026',
      'credits': '8.0 CME Hours',
      'enrolled': 45,
      'completed': 38,
      'dueDate': 'June 15, 2026',
      'status': 'Active',
      'statusColor': AppColors.success,
    },
    {
      'title': 'HIPAA & Patient Data Security (Annual)',
      'code': 'COMP-HIPAA-26',
      'credits': '2.0 Comp Hours',
      'enrolled': 342,
      'completed': 298,
      'dueDate': 'June 30, 2026',
      'status': 'Mandatory',
      'statusColor': AppColors.error,
    },
    {
      'title': 'ICU Ventilator & Critical Care Protocols',
      'code': 'CME-VENT-2026',
      'credits': '6.0 CME Hours',
      'enrolled': 24,
      'completed': 20,
      'dueDate': 'July 10, 2026',
      'status': 'Active',
      'statusColor': AppColors.success,
    },
    {
      'title': 'Infection Prevention & Bio-waste Disposal',
      'code': 'COMP-INF-2026',
      'credits': '3.0 Comp Hours',
      'enrolled': 180,
      'completed': 142,
      'dueDate': 'June 25, 2026',
      'status': 'Mandatory',
      'statusColor': AppColors.error,
    },
  ];

  final List<Map<String, dynamic>> _safetyMatrix = [
    {'dept': 'Emergency & Trauma', 'rate': 0.94, 'color': AppColors.success},
    {
      'dept': 'Intensive Care Unit (ICU)',
      'rate': 0.88,
      'color': AppColors.primary,
    },
    {
      'dept': 'Operating Theatres (OT)',
      'rate': 0.96,
      'color': AppColors.success,
    },
    {
      'dept': 'Outpatient Clinic (OPD)',
      'rate': 0.72,
      'color': AppColors.secondaryAccent,
    },
    {
      'dept': 'Pharmacy & Stores',
      'rate': 0.80,
      'color': AppColors.primaryLight,
    },
  ];

  void _addCourse() {
    showDialog(
      context: context,
      builder: (context) {
        var title = '';
        var code = '';
        const credits = '4.0 CME Hours';
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            'Create Training Program',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.primaryText,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Program / Course Title',
                  labelStyle: TextStyle(color: AppColors.secondaryText),
                ),
                style: const TextStyle(color: AppColors.primaryText),
                onChanged: (val) => title = val,
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Course Code (e.g. CME-102)',
                  labelStyle: TextStyle(color: AppColors.secondaryText),
                ),
                style: const TextStyle(color: AppColors.primaryText),
                onChanged: (val) => code = val,
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
                if (title.isNotEmpty && code.isNotEmpty) {
                  setState(() {
                    _courses.add({
                      'title': title,
                      'code': code,
                      'credits': credits,
                      'enrolled': 1,
                      'completed': 0,
                      'dueDate': 'August 01, 2026',
                      'status': 'Active',
                      'statusColor': AppColors.success,
                    });
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.success,
                      content: Text('Course $code registered successfully!'),
                    ),
                  );
                }
              },
              child: const Text(
                'Register',
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
                'Active CME Programs',
                '${_courses.length}',
                'Annual Credentials',
                AppColors.primary,
                Icons.school_rounded,
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: _metricCard(
                'Compliance Threshold',
                '88.5%',
                'Required: 85%',
                AppColors.secondaryAccent,
                Icons.verified_user_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _metricCard(
                'Staff Enrolled',
                '342',
                'Active Learners',
                AppColors.success,
                Icons.menu_book_rounded,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _metricCard(
                'CME Hours Awarded',
                '1,420 hrs',
                'This Quarter',
                AppColors.primaryLight,
                Icons.workspace_premium_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _buildCoursesCard(),
        const SizedBox(height: AppSpacing.lg),
        _buildComplianceMatrixCard(),
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

  Widget _buildCoursesCard() {
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
                    'Active Training Programs & CME',
                    style: AppTextStyles.labelLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Ongoing medical and regulatory compliance courses',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: _addCourse,
                icon: const Icon(Icons.add, size: 14),
                label: const Text('Add Course', style: TextStyle(fontSize: 11)),
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
            itemCount: _courses.length,
            itemBuilder: (context, index) {
              final crs = _courses[index];
              final title = crs['title'] as String;
              final code = crs['code'] as String;
              final credits = crs['credits'] as String;
              final enrolled = crs['enrolled'] as int;
              final completed = crs['completed'] as int;
              final dueDate = crs['dueDate'] as String;
              final status = crs['status'] as String;
              final statusColor = crs['statusColor'] as Color;
              final ratio = enrolled > 0 ? (completed / enrolled) : 0.0;
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
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
                              const SizedBox(height: 2),
                              Text(
                                '$code | $credits',
                                style: AppTextStyles.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
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
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Completion Rate: $completed/$enrolled Staff',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.secondaryText,
                          ),
                        ),
                        Text(
                          '${(ratio * 100).toStringAsFixed(0)}%',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    LinearProgressIndicator(
                      value: ratio,
                      backgroundColor: AppColors.card,
                      valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                      minHeight: 4,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Due Date: $dueDate',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.secondaryText,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              if (completed < enrolled) {
                                crs['completed'] = completed + 1;
                              }
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.success,
                                content: Text(
                                  'Enrolled staff progress logged for $code!',
                                ),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                          ),
                          child: const Text(
                            'Log Completion',
                            style: TextStyle(
                              color: AppColors.primary,
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

  Widget _buildComplianceMatrixCard() {
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
            'Clinical Safety & License Matrix',
            style: AppTextStyles.labelLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Verification rates for compulsory certificates and licenses',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 16),
          ..._safetyMatrix.map((item) {
            final color = item['color'] as Color;
            final dept = item['dept'] as String;
            final rate = item['rate'] as double;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.shield_outlined, color: color, size: 16),
                          const SizedBox(width: 8),
                          Text(dept, style: AppTextStyles.bodyMedium),
                        ],
                      ),
                      Text(
                        '${(rate * 100).toStringAsFixed(0)}% Compliance',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: rate,
                    backgroundColor: AppColors.background,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.secondaryAccent,
                  size: 20,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Annual nursing and paramedic license audits scheduled for June 08. Ensure all credentials are uploaded in Directory Profile panels before deadline.',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
