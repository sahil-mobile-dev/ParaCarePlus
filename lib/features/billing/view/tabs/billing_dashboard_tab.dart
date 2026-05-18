import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/features/billing/view/widgets/billing_charts.dart';
import 'package:paracareplus/features/billing/view/widgets/billing_kpis.dart';
import 'package:paracareplus/features/billing/view/widgets/recent_transactions_table.dart';

class BillingDashboardTab extends StatelessWidget {
  const BillingDashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        
        if (isWide) {
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    RevenueTrendChart(),
                    SizedBox(height: AppSpacing.lg),
                    RecentTransactionsTable(),
                  ],
                ),
              ),
              SizedBox(width: AppSpacing.lg),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    RevenueByServiceChart(),
                    SizedBox(height: AppSpacing.lg),
                    PaymentModesChart(),
                    SizedBox(height: AppSpacing.lg),
                    BillingKPIsCard(),
                  ],
                ),
              ),
            ],
          );
        }

        // Narrow layout
        return const Column(
          children: [
            RevenueTrendChart(),
            SizedBox(height: AppSpacing.lg),
            RevenueByServiceChart(),
            SizedBox(height: AppSpacing.lg),
            PaymentModesChart(),
            SizedBox(height: AppSpacing.lg),
            BillingKPIsCard(),
            SizedBox(height: AppSpacing.lg),
            RecentTransactionsTable(),
          ],
        );
      },
    );
  }
}
