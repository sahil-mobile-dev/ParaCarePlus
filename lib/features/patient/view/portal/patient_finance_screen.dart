import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/finance/active_insurance_grid.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/finance/bills_transactions_table.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/finance/expenditure_flow_sankey_sunburst.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/finance/finance_kpis.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/finance/spend_analytics_charts.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientFinanceScreen extends ConsumerWidget {
  const PatientFinanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayStr = DateFormat('dd MMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientFinance,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.account_balance_wallet_rounded,
              color: AppColors.success,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'Finance & Insurance',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Page Header
              _buildPageHeader(context, todayStr),
              const SizedBox(height: AppSpacing.md),

              // KPI Grid
              const FinanceKpis(),
              const SizedBox(height: AppSpacing.lg),

              // Insurance section header
              const Row(
                children: [
                  Icon(
                    Icons.shield_rounded,
                    color: AppColors.success,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Active Insurance Policies',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              const ActiveInsuranceGrid(),
              const SizedBox(height: AppSpacing.lg),

              // Transactions Table
              const BillsTransactionsTable(),
              const SizedBox(height: AppSpacing.lg),

              // Sankey + Sunburst Chart Panel
              const Row(
                children: [
                  Icon(
                    Icons.query_stats_rounded,
                    color: AppColors.success,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Health Expenditure Flow Analysis',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              const ExpenditureFlowSankeySunburst(),
              const SizedBox(height: AppSpacing.lg),

              // Spend Charts
              const SpendAnalyticsCharts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context, String dateStr) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        final elements = [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.15),
                  border: Border.all(
                    color: AppColors.success.withValues(alpha: 0.3),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.person_rounded,
                      color: AppColors.success,
                      size: 12,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Ramesh Kumar',
                      style: TextStyle(
                        color: AppColors.success,
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.15),
                  border: Border.all(
                    color: AppColors.success.withValues(alpha: 0.3),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      color: AppColors.success,
                      size: 10,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      dateStr,
                      style: const TextStyle(
                        color: AppColors.success,
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.sm),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Opening claim form…'),
                  backgroundColor: AppColors.primaryLight,
                ),
              );
            },
            icon: const Icon(Icons.file_copy_rounded, size: 14),
            label: const Text(
              'File Claim',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success.withValues(alpha: 0.15),
              foregroundColor: AppColors.success,
              elevation: 0,
              side: BorderSide(color: AppColors.success.withValues(alpha: 0.3)),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ];

        return Column(
          children: [
            Row(children: elements),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Financial & Insurance Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
