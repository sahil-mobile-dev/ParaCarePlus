import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/billing/view/tabs/bill_records_tab.dart';
import 'package:paracareplus/features/billing/view/tabs/insurance_tpa_tab.dart';
import 'package:paracareplus/features/billing/view/tabs/new_bill_tab.dart';
import 'package:paracareplus/features/billing/view/tabs/payments_tab.dart';
import 'package:paracareplus/features/billing/view/tabs/refunds_tab.dart';
import 'package:paracareplus/features/billing/view/tabs/revenue_tab.dart';
import 'package:paracareplus/features/billing/view/tabs/credit_advances_tab.dart';

import 'package:paracareplus/features/billing/view_model/billing_view_model.dart';
import 'package:paracareplus/features/billing/view/tabs/billing_dashboard_tab.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_sidebar.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_header.dart';
import 'package:paracareplus/features/billing/view/widgets/billing_summary_cards.dart';

class BillingScreen extends ConsumerWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWideScreen = MediaQuery.of(context).size.width > 1200;
    final activeTab = ref.watch(billingTabProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(),
      drawer: isWideScreen ? null : const Drawer(child: AppSidebar()),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isWideScreen) const AppSidebar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopActionsRow(),
                    const SizedBox(height: AppSpacing.md),

                    const BillingSummaryCards(),
                    const SizedBox(height: AppSpacing.md),

                    _buildTabBar(ref, activeTab),
                    const SizedBox(height: AppSpacing.lg),

                    _buildDataSection(activeTab),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopActionsRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(
                  'Billing & Finance',
                  style: AppTextStyles.titleMedium,
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.success.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Live',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                _buildActionBtn(Icons.add_rounded, isPrimary: true),
                const SizedBox(width: 8),
                _buildActionBtn(Icons.file_download_outlined),
              ],
            ),
          ],
        ),
        Text(
          'Billing & Finance Management',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildActionBtn(IconData icon, {bool isPrimary = false}) {
    return IconButton(
      onPressed: () {},
      icon: Icon(icon, size: 18),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? AppColors.success : AppColors.card,
        foregroundColor: isPrimary ? Colors.white : AppColors.primaryText,
        side: isPrimary ? null : const BorderSide(color: AppColors.border),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildTabBar(WidgetRef ref, String activeTab) {
    final tabs = [
      {'label': 'Dashboard', 'icon': Icons.dashboard_rounded},
      {'label': '+ New Bill', 'icon': Icons.add_rounded},
      {'label': 'Bill Records', 'icon': Icons.list_alt_rounded},
      {'label': 'Payments', 'icon': Icons.payments_rounded},
      {'label': 'Insurance/TPA', 'icon': Icons.health_and_safety_rounded},
      {'label': 'Credit/Advances', 'icon': Icons.account_balance_rounded},
      {'label': 'Refunds', 'icon': Icons.replay_rounded},
      {'label': 'Revenue', 'icon': Icons.bar_chart_rounded},
    ];
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.map((tab) {
            final isSelected = tab['label'] == activeTab;

            // Adjust the active tab style per the images
            final activeColor =
                tab['label'] == '+ New Bill' ||
                    tab['label'] == 'Payments' ||
                    tab['label'] == 'Bill Records' ||
                    tab['label'] == 'Insurance/TPA'
                ? AppColors.success
                : AppColors.primary;

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () {
                  ref.read(billingTabProvider.notifier).state =
                      tab['label'] as String;
                },
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? activeColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        tab['icon'] as IconData,
                        size: 16,
                        color: isSelected
                            ? Colors.white
                            : AppColors.secondaryText,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        tab['label'] as String,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: isSelected
                              ? Colors.white
                              : AppColors.primaryText,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDataSection(String activeTab) {
    switch (activeTab) {
      case '+ New Bill':
        return const NewBillTab();
      case 'Bill Records':
        return const BillRecordsTab();
      case 'Payments':
        return const PaymentsTab();
      case 'Insurance/TPA':
        return const InsuranceTpaTab();
      case 'Credit/Advances':
        return const CreditAdvancesTab();
      case 'Refunds':
        return const RefundsTab();
      case 'Revenue':
        return const RevenueTab();
      case 'Dashboard':
      default:
        return const BillingDashboardTab();
    }
  }
}
