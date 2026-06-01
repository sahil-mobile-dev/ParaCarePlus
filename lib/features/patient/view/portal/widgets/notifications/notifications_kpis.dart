import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class NotificationsKpis extends StatelessWidget {
  const NotificationsKpis({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            _KpiCard(
              label: 'Critical Alerts',
              value: '2',
              sub: 'Require immediate action',
              color: AppColors.error,
              icon: Icons.warning_amber_rounded,
            ),
            SizedBox(width: 10),
            _KpiCard(
              label: 'Warnings',
              value: '5',
              sub: 'Action needed 24–48 hrs',
              color: AppColors.secondaryAccent,
              icon: Icons.error_outline_rounded,
            ),
          ],
        ),
        SizedBox(height: AppSpacing.md),
        Row(
          children: [
            _KpiCard(
              label: 'Informational',
              value: '14',
              sub: 'Appointments, labs, reports',
              color: AppColors.primaryLight,
              icon: Icons.info_outline_rounded,
            ),
            SizedBox(width: 10),
            _KpiCard(
              label: 'Resolved Today',
              value: '8',
              sub: 'Acknowledged and actioned',
              color: AppColors.success,
              icon: Icons.check_circle_outline_rounded,
            ),
          ],
        ),
        SizedBox(height: AppSpacing.md),
        Row(
          children: [
            _KpiCard(
              label: 'AI-Generated Alerts',
              value: '4',
              sub: 'Smart prediction & anomaly',
              color: Color(0xFFC77DFF),
              icon: Icons.smart_toy_outlined,
            ),
          ],
        ),
      ],
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({
    required this.label,
    required this.value,
    required this.sub,
    required this.color,
    required this.icon,
  });

  final String label;
  final String value;
  final String sub;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          border: Border(
            top: BorderSide(color: color),
            left: const BorderSide(color: AppColors.border),
            right: const BorderSide(color: AppColors.border),
            bottom: const BorderSide(color: AppColors.border),
          ),
        ),
        // decoration: BoxDecoration(
        //   color: AppColors.card,
        //   borderRadius: BorderRadius.circular(12),
        //   border: Border(
        //     top: BorderSide(color: color, width: 3),
        //     left: const BorderSide(color: AppColors.border),
        //     right: const BorderSide(color: AppColors.border),
        //     bottom: const BorderSide(color: AppColors.border),
        //   ),
        // ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  sub,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Icon(icon, color: color.withValues(alpha: 0.15), size: 32),
            ),
          ],
        ),
      ),
    );
  }
}
