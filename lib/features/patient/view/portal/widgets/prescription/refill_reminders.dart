import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class RefillReminders extends StatelessWidget {
  const RefillReminders({super.key});

  void _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 900
            ? 4
            : (constraints.maxWidth > 500 ? 2 : 1);

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: AppSpacing.sm,
          mainAxisSpacing: AppSpacing.sm,
          childAspectRatio: 1.5,
          children: [
            _buildReminderCard(
              context,
              name: 'Amlodipine 5mg',
              daysText: '⚠ 6 days remaining',
              daysColor: AppColors.error,
              progress: 0.2,
              progressColor: AppColors.error,
              buttonText: 'Order Refill',
              buttonBg: AppColors.error.withValues(alpha: 0.1),
              buttonBorder: AppColors.error.withValues(alpha: 0.2),
              onTap: () => _showToast(context, 'Ordering Amlodipine refill...'),
            ),
            _buildReminderCard(
              context,
              name: 'Metformin 500mg',
              daysText: '10 days remaining',
              daysColor: AppColors.secondaryAccent,
              progress: 0.35,
              progressColor: AppColors.secondaryAccent,
              buttonText: 'Order Refill',
              buttonBg: AppColors.secondaryAccent.withValues(alpha: 0.1),
              buttonBorder: AppColors.secondaryAccent.withValues(alpha: 0.2),
              onTap: () => _showToast(context, 'Ordering Metformin refill...'),
            ),
            _buildReminderCard(
              context,
              name: 'Atorvastatin 10mg',
              daysText: '16 days remaining',
              daysColor: AppColors.primaryLight,
              progress: 0.55,
              progressColor: AppColors.primaryLight,
              buttonText: 'Set Reminder',
              buttonBg: AppColors.primaryLight.withValues(alpha: 0.1),
              buttonBorder: AppColors.primaryLight.withValues(alpha: 0.2),
              onTap: () =>
                  _showToast(context, 'Scheduled Atorvastatin reminder...'),
            ),
            _buildReminderCard(
              context,
              name: 'Vitamin D3 1000 IU',
              daysText: '21 days remaining',
              daysColor: AppColors.success,
              progress: 0.7,
              progressColor: AppColors.success,
              buttonText: 'Set Reminder',
              buttonBg: AppColors.success.withValues(alpha: 0.1),
              buttonBorder: AppColors.success.withValues(alpha: 0.2),
              onTap: () => _showToast(context, 'Vitamin D3 reminder set...'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReminderCard(
    BuildContext context, {
    required String name,
    required String daysText,
    required Color daysColor,
    required double progress,
    required Color progressColor,
    required String buttonText,
    required Color buttonBg,
    required Color buttonBorder,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF112240),
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                color: progressColor,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            daysText,
            style: TextStyle(
              color: daysColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonBg,
              foregroundColor: daysColor,
              side: BorderSide(color: buttonBorder),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(vertical: 4),
            ),
            onPressed: onTap,
            child: Text(
              buttonText,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
