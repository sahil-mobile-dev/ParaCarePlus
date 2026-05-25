import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class UpcomingVaccinations extends StatelessWidget {
  const UpcomingVaccinations({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                color: AppColors.primaryLight,
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'Upcoming & Overdue Vaccinations',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildUpcomingItem(
                context: context,
                name: 'Tdap Booster',
                desc:
                    'Tetanus, Diphtheria, Pertussis — Adult Booster (Every 10 yrs)',
                statusText: 'Overdue',
                dueDateText: 'Due: Mar 2026',
                statusColor: AppColors.error,
                buttonText: 'Book Now',
              ),
              const SizedBox(height: 10),
              _buildUpcomingItem(
                context: context,
                name: 'Influenza (Annual)',
                desc: 'Annual Flu Shot — Recommended before monsoon season',
                statusText: 'Due Soon',
                dueDateText: 'Due: Jun 2026',
                statusColor: AppColors.secondaryAccent,
                buttonText: 'Schedule',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingItem({
    required BuildContext context,
    required String name,
    required String desc,
    required String statusText,
    required String dueDateText,
    required Color statusColor,
    required String buttonText,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.vaccines_outlined,
              color: statusColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.secondaryText,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                statusText,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                dueDateText,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Booking appointment for $name...'),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: statusColor.withValues(alpha: 0.5)),
              foregroundColor: statusColor,
              backgroundColor: statusColor.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
