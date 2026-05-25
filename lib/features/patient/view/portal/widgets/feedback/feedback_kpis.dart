import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class FeedbackKpis extends StatelessWidget {
  const FeedbackKpis({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            _KpiCard(
              label: 'Overall Experience Score',
              value: '4.6',
              denom: '/5',
              sub: 'Based on 18 feedback submissions',
              color: AppColors.secondaryAccent,
              icon: Icons.star_rounded,
            ),
            SizedBox(width: 14),

            _KpiCard(
              label: 'Feedbacks Submitted',
              value: '18',
              sub: 'Across 6 departments · Since 2023',
              color: AppColors.primaryLight,
              icon: Icons.rate_review_outlined,
            ),
          ],
        ),
        SizedBox(height: AppSpacing.md),
        Row(
          children: [
            _KpiCard(
              label: 'NPS Score',
              value: '+72',
              sub: 'Promoters 84% · Detractors 12%',
              color: AppColors.success,
              icon: Icons.thumb_up_outlined,
            ),
            SizedBox(width: 14),
            _KpiCard(
              label: 'Hospital Response Rate',
              value: '94%',
              sub: 'Avg response time: 6.2 hours',
              color: Color(0xFFC77DFF),
              icon: Icons.reply_all_rounded,
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
    this.denom,
  });

  final String label;
  final String value;
  final String? denom;
  final String sub;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                if (denom != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      denom!,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
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
      ),
    );
  }
}
