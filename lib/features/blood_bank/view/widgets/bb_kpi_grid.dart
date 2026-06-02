import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class BbKpiGrid extends StatelessWidget {
  const BbKpiGrid({
    required this.totalUnits,
    required this.registeredDonors,
    required this.todayDonations,
    required this.pendingRequests,
    required this.expiringSoon,
    super.key,
  });

  final int totalUnits;
  final int registeredDonors;
  final int todayDonations;
  final int pendingRequests;
  final int expiringSoon;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 1000
            ? 5
            : (constraints.maxWidth > 600 ? 3 : 2);

        return GridView.count(
          crossAxisCount: columns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.6,
          children: [
            _buildKpiCard(
              title: 'TOTAL UNITS AVAILABLE',
              value: totalUnits.toString(),
              emoji: '🩸',
              color: const Color(0xFFC62828),
            ),
            _buildKpiCard(
              title: 'REGISTERED DONORS',
              value: registeredDonors.toString(),
              emoji: '👥',
              color: const Color(0xFF2E7D32),
            ),
            _buildKpiCard(
              title: "TODAY'S DONATIONS",
              value: todayDonations.toString(),
              emoji: '🤝',
              color: const Color(0xFF1565C0),
            ),
            _buildKpiCard(
              title: 'PENDING REQUESTS',
              value: pendingRequests.toString(),
              emoji: '📋',
              color: const Color(0xFFE65100),
            ),
            _buildKpiCard(
              title: 'EXPIRING ≤7 DAYS',
              value: expiringSoon.toString(),
              emoji: '⚠️',
              color: const Color(0xFF880E4F),
            ),
          ],
        );
      },
    );
  }

  Widget _buildKpiCard({
    required String title,
    required String value,
    required String emoji,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.secondaryText,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                emoji,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: AppTextStyles.titleLarge.copyWith(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
