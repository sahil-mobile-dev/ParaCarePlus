import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class FinanceKpis extends StatelessWidget {
  const FinanceKpis({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 900
            ? 6
            : (constraints.maxWidth > 600 ? 3 : 2);

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: constraints.maxWidth > 900 ? 1.2 : 1.35,
          children: [
            _buildKpiCard(
              icon: Icons.shield_rounded,
              value: '₹5 Lakh',
              label: 'Total Coverage',
              subText: 'AB-PMJAY + Topup',
              accentColor: AppColors.success,
            ),
            _buildKpiCard(
              icon: Icons.currency_rupee_rounded,
              value: '₹1.2L',
              label: 'Used This Year',
              subText: '₹3.8L remaining',
              accentColor: const Color(0xFF00B4D8), // Accent blue
            ),
            _buildKpiCard(
              icon: Icons.file_copy_rounded,
              value: '4',
              label: 'Claims This Year',
              subText: '3 approved, 1 pending',
              accentColor: const Color(0xFFFFD166), // Yellow
            ),
            _buildKpiCard(
              icon: Icons.receipt_rounded,
              value: '₹28,400',
              label: 'Outstanding Bills',
              subText: '2 invoices pending',
              accentColor: AppColors.primaryLight,
            ),
            _buildKpiCard(
              icon: Icons.medication_rounded,
              value: '₹1,240',
              label: 'Monthly Med Cost',
              subText: 'Post insurance',
              accentColor: const Color(0xFFF77F00), // Orange
            ),
            _buildKpiCard(
              icon: Icons.savings_rounded,
              value: '₹86,200',
              label: 'Total Savings',
              subText: 'This financial year',
              accentColor: const Color(0xFFC77DFF), // Purple
            ),
          ],
        );
      },
    );
  }

  Widget _buildKpiCard({
    required IconData icon,
    required String value,
    required String label,
    required String subText,
    required Color accentColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Top accent strip
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 3,
            child: Container(color: accentColor),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 14, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(icon, color: accentColor, size: 14),
                ),
                const SizedBox(height: 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.secondaryText,
                        fontSize: 9.5,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      subText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 8.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
