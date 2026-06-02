import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class RadiologyScheduleTab extends StatelessWidget {
  const RadiologyScheduleTab({super.key});

  @override
  Widget build(BuildContext context) {
    final times = ['08:00 AM', '09:00 AM', '10:00 AM', '11:00 AM', '12:00 PM', '01:00 PM'];
    final days = ['Mon 7', 'Tue 8', 'Wed 9', 'Thu 10', 'Fri 11', 'Sat 12', 'Sun 13'];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_month_rounded, color: AppColors.primaryLight, size: 16),
              const SizedBox(width: 8),
              const Text(
                'WEEKLY SCAN SCHEDULE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: AppColors.secondaryText,
                  fontFamily: AppTextStyles.fontFamily,
                ),
              ),
              const Spacer(),
              Text(
                'Apr 7 — Apr 13, 2026',
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 900,
              child: Column(
                children: [
                  // Days Header
                  Row(
                    children: [
                      const SizedBox(width: 80),
                      ...days.map((d) => Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.2),
                                border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
                              ),
                              child: Text(
                                d,
                                style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ],
                  ),
                  // Time Rows
                  ...times.map((time) {
                    return Row(
                      children: [
                        // Time label
                        SizedBox(
                          width: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              time,
                              style: const TextStyle(color: AppColors.secondaryText, fontSize: 9.5, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                        // Daily slots
                        ...List.generate(7, (dayIdx) {
                          // Mock booked appointments
                          Widget? apptWidget;
                          if (time == '09:00 AM' && dayIdx == 0) {
                            apptWidget = _apptCard('CT Chest - Ramesh K.', AppColors.error);
                          } else if (time == '10:00 AM' && dayIdx == 2) {
                            apptWidget = _apptCard('MRI Brain - Savita D.', AppColors.primaryLight);
                          } else if (time == '11:00 AM' && dayIdx == 4) {
                            apptWidget = _apptCard('USG Abdomen - Anita T.', AppColors.success);
                          }

                          return Expanded(
                            child: Container(
                              height: 52,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
                              ),
                              padding: const EdgeInsets.all(2),
                              child: apptWidget ?? const SizedBox(),
                            ),
                          );
                        }),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _apptCard(String title, Color color) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(color: color, fontSize: 8.5, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
