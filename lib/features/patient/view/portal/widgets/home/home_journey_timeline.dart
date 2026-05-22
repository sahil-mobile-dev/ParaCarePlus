import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class HomeJourneyTimeline extends ConsumerWidget {
  const HomeJourneyTimeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildChartCard(
      title: 'Medical Journey Timeline',
      icon: Icons.timeline_rounded,
      child: Column(
        children: [
          _buildTimelineItem(
            '12 May 2026',
            'HbA1c Lab Test',
            'Result: 7.4% — Slight elevation. Dr. Negi recommended diet modifications.',
            AppColors.error,
            Icons.science_rounded,
          ),
          _buildTimelineItem(
            '8 May 2026',
            'Teleconsultation — Endocrinology',
            'Dr. Rajesh Kumar reviewed diabetes management plan. Adjusted Metformin.',
            AppColors.primaryLight,
            Icons.video_camera_front_rounded,
          ),
          _buildTimelineItem(
            '2 Apr 2026',
            'Vaccination — COVID Booster (5th dose)',
            'Covaxin administered at Doon Hospital. No adverse reactions.',
            AppColors.success,
            Icons.vaccines_rounded,
          ),
          _buildTimelineItem(
            '15 Jan 2026',
            'Hypertension Diagnosis',
            'BP consistently 140/90. Started Amlodipine 5mg & lifestyle changes.',
            Colors.orange,
            Icons.health_and_safety_rounded,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    String date,
    String title,
    String body,
    Color color,
    IconData icon, {
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: Icon(icon, color: Colors.white, size: 10),
              ),
              if (!isLast)
                Expanded(child: Container(width: 1.5, color: AppColors.border)),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 8,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    body,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 9,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard({
    required String title,
    required IconData icon,
    required Widget child,
    Color color = AppColors.primaryLight,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
