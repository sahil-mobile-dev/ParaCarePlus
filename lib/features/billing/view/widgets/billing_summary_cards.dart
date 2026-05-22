import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class BillingSummaryCards extends StatelessWidget {
  const BillingSummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1000
            ? 5
            : constraints.maxWidth > 600
            ? 3
            : 2;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.55,
          children: const [
            _SummaryCard(
              title: "Today's Revenue",
              value: '₹1.24L',
              trend: '↑ 12% vs yest',
            ),
            _SummaryCard(
              title: 'Bills Generated',
              value: '87',
              subtitle: 'OPD: 64 | IPD: 23',
              icon: Icons.receipt_long_rounded,
              iconColor: AppColors.primary,
            ),
            _SummaryCard(
              title: 'Pending Payments',
              value: '₹38K',
              subtitle: '14 bills unpaid',
              valueColor: AppColors.secondaryAccent,
              icon: Icons.pending_actions_rounded,
              iconColor: AppColors.secondaryAccent,
            ),
            _SummaryCard(
              title: 'Insurance Claims',
              value: '₹2.1L',
              subtitle: '8 under process',
              valueColor: Colors.purple,
              icon: Icons.shield_rounded,
              iconColor: Colors.purple,
            ),
            _SummaryCard(
              title: 'Overdue >30 Days',
              value: '₹12K',
              subtitle: '5 patients',
              valueColor: AppColors.error,
              icon: Icons.warning_rounded,
              iconColor: AppColors.error,
            ),
          ],
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    this.subtitle,
    this.trend,
    this.trendUp = true,
    this.icon,
    this.iconColor,
    this.valueColor,
  });
  final String title;
  final String value;
  final String? subtitle;
  final String? trend;
  final bool trendUp;
  final IconData? icon;
  final Color? iconColor;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.secondaryText,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (icon != null)
                Icon(
                  icon,
                  size: 20,
                  color:
                      iconColor?.withValues(alpha: 0.5) ??
                      AppColors.secondaryText,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: AppTextStyles.titleLarge.copyWith(
                  color: valueColor ?? AppColors.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (trend != null) ...[
                const SizedBox(width: 8),
                Text(
                  trend!,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: trendUp ? AppColors.success : AppColors.error,
                    fontSize: 10,
                  ),
                ),
              ],
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.secondaryText,
                fontSize: 11,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
