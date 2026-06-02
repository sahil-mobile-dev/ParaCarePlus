import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/hr/view_model/hr_view_model.dart';
import 'package:paracareplus/features/hr/model/hr_model.dart';

class TrainingTab extends ConsumerStatefulWidget {
  const TrainingTab({super.key});

  @override
  ConsumerState<TrainingTab> createState() => _TrainingTabState();
}

class _TrainingTabState extends ConsumerState<TrainingTab> {
  final List<Map<String, dynamic>> _safetyMatrix = [
    {'dept': 'Emergency & Trauma', 'rate': 0.94, 'color': AppColors.success},
    {'dept': 'Intensive Care Unit (ICU)', 'rate': 0.88, 'color': AppColors.primary},
    {'dept': 'Operating Theatres (OT)', 'rate': 0.96, 'color': AppColors.success},
    {'dept': 'Outpatient Clinic (OPD)', 'rate': 0.72, 'color': AppColors.secondaryAccent},
  ];

  void _addCourse() {
    final topicController = TextEditingController();
    final trainerController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: const Text('Create Training Program', style: AppTextStyles.titleMedium),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: topicController,
                decoration: const InputDecoration(labelText: 'Program / Course Title'),
                style: const TextStyle(color: AppColors.primaryText),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: trainerController,
                decoration: const InputDecoration(labelText: 'Trainer / Speaker'),
                style: const TextStyle(color: AppColors.primaryText),
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
                final topic = topicController.text.trim();
                final trainer = trainerController.text.trim();
                if (topic.isNotEmpty && trainer.isNotEmpty) {
                  ref.read(hrProvider.notifier).scheduleTraining(
                    topic: topic,
                    trainer: trainer,
                    schedule: 'May 28, 2026',
                    time: '3 hours',
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.success,
                      content: Text('Course $topic registered successfully!'),
                    ),
                  );
                }
              },
              child: const Text('Register'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final courses = ref.watch(hrProvider.select((s) => s.trainingList));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: _metricCard('Active CME Programs', '${courses.length}', 'Annual Credentials', AppColors.primary, Icons.school_rounded),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _metricCard('Compliance Threshold', '88.5%', 'Required: 85%', AppColors.secondaryAccent, Icons.verified_user_rounded),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _buildCoursesCard(courses),
        const SizedBox(height: AppSpacing.lg),
        _buildComplianceMatrixCard(),
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

  Widget _buildCoursesCard(List<TrainingItem> courses) {
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
                  Text('Active Training Programs & CME', style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('Ongoing medical and regulatory compliance courses', style: TextStyle(color: AppColors.secondaryText, fontSize: 10)),
                ],
              ),
              ElevatedButton.icon(
                onPressed: _addCourse,
                icon: const Icon(Icons.add, size: 14),
                label: const Text('Add Course', style: TextStyle(fontSize: 11)),
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
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final crs = courses[index];
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
                          Text(crs.topic, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 2),
                          Text('Trainer: ${crs.trainer} | Duration: ${crs.time}', style: AppTextStyles.bodySmall),
                          const SizedBox(height: 4),
                          Text('Schedule: ${crs.schedule} | Enrolled: ${crs.enrolledCount}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondaryText)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                      ),
                      child: Text(crs.status, style: const TextStyle(color: AppColors.success, fontSize: 9, fontWeight: FontWeight.bold)),
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
          Text('Clinical Safety & License Matrix', style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold)),
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
                      Text('${(rate * 100).toStringAsFixed(0)}% Compliance', style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.bold)),
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
        ],
      ),
    );
  }
}
