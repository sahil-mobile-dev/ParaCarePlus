import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class BillingKPIsCard extends StatelessWidget {
  const BillingKPIsCard({super.key});

  @override
  Widget build(BuildContext context) {
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
          const Row(
            children: [
              Icon(Icons.speed_rounded, size: 20, color: AppColors.success),
              SizedBox(width: 8),
              Text("Today's KPIs", style: AppTextStyles.titleSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildKpiRow('Average Bill Value', '₹1,425'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(color: AppColors.border, height: 1),
          ),
          _buildKpiRow(
            'Collection Rate',
            '87.4%',
            valueColor: AppColors.success,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(color: AppColors.border, height: 1),
          ),
          _buildKpiRow(
            'Concession Given',
            '₹8,200',
            valueColor: AppColors.secondaryAccent,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(color: AppColors.border, height: 1),
          ),
          _buildKpiRow('Cashless Transactions', '42'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(color: AppColors.border, height: 1),
          ),
          _buildKpiRow('New Deposits', '₹15,000'),
        ],
      ),
    );
  }

  Widget _buildKpiRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.secondaryText,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.titleSmall.copyWith(
            color: valueColor ?? AppColors.primaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
