import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_sidebar.dart';
import 'package:paracareplus/features/blood_bank/view_model/blood_bank_view_model.dart';
import 'package:paracareplus/features/blood_bank/view/widgets/bb_kpi_grid.dart';
import 'package:paracareplus/features/blood_bank/view/widgets/bb_inventory_strip.dart';
import 'package:paracareplus/features/blood_bank/view/widgets/bb_modals.dart';
import 'package:paracareplus/features/blood_bank/view/widgets/tabs/bb_inventory_tab.dart';
import 'package:paracareplus/features/blood_bank/view/widgets/tabs/bb_donors_tab.dart';
import 'package:paracareplus/features/blood_bank/view/widgets/tabs/bb_donations_tab.dart';
import 'package:paracareplus/features/blood_bank/view/widgets/tabs/bb_requests_tab.dart';
import 'package:paracareplus/features/blood_bank/view/widgets/tabs/bb_crossmatch_tab.dart';
import 'package:paracareplus/features/blood_bank/view/widgets/tabs/bb_issue_tab.dart';
import 'package:paracareplus/features/blood_bank/view/widgets/tabs/bb_expiry_tab.dart';
import 'package:paracareplus/features/blood_bank/view/widgets/tabs/bb_reports_tab.dart';

class BloodBankScreen extends ConsumerWidget {
  const BloodBankScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bloodBankProvider);
    final notifier = ref.read(bloodBankProvider.notifier);
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 1200;

    Widget tabBody;
    switch (state.activeTab) {
      case 'Inventory':
        tabBody = const BbInventoryTab();
      case 'Donors':
        tabBody = const BbDonorsTab();
      case 'Donations':
        tabBody = const BbDonationsTab();
      case 'Requests':
        tabBody = const BbRequestsTab();
      case 'Cross-Match':
        tabBody = const BbCrossmatchTab();
      case 'Issue':
        tabBody = const BbIssueTab();
      case 'Expiry':
        tabBody = const BbExpiryTab();
      case 'Reports':
        tabBody = const BbReportsTab();
      default:
        tabBody = const BbInventoryTab();
    }

    final mainContent = Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🩸 Blood Bank Management System',
                      style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ParaCare+ HMIS → Blood Bank Management',
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.secondaryText),
                    ),
                  ],
                ),
                // Actions
                Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF880E4F)),
                      icon: const Icon(Icons.add_rounded, color: Colors.white, size: 16),
                      label: const Text('NEW DONATION', style: TextStyle(color: Colors.white, fontSize: 12)),
                      onPressed: () => BbModals.showRecordDonation(context, ref),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC62828)),
                      icon: const Icon(Icons.volunteer_activism_rounded, color: Colors.white, size: 16),
                      label: const Text('BLOOD REQUEST', style: TextStyle(color: Colors.white, fontSize: 12)),
                      onPressed: () => BbModals.showBloodRequest(context, ref),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Stats Grid
            BbKpiGrid(
              totalUnits: state.stock.length + 277, // Simulated base total
              registeredDonors: state.donors.length + 1243,
              todayDonations: state.donations.length + 8,
              pendingRequests: state.requests.where((r) => r.status != 'Issued' && r.status != 'Transfused').length,
              expiringSoon: state.stock.where((s) => s.daysLeft <= 7).length + 11,
            ),
            const SizedBox(height: AppSpacing.lg),

            // Blood Inventory Group Strip
            BbInventoryStrip(groupsStock: state.groupsStock),
            const SizedBox(height: AppSpacing.lg),

            // Tab Bar Navigation
            _buildTabBar(state.activeTab, notifier),
            const SizedBox(height: AppSpacing.md),

            // Tab view body
            tabBody,
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Row(
          children: [
            if (isWide) const AppSidebar(),
            mainContent,
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(String activeTab, BloodBankNotifier notifier) {
    final tabs = [
      'Inventory',
      'Donors',
      'Donations',
      'Requests',
      'Cross-Match',
      'Issue',
      'Expiry',
      'Reports',
    ];

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1.5)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.map((tab) {
            final isSelected = activeTab == tab;
            return GestureDetector(
              onTap: () => notifier.setTab(tab),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      width: 3.0,
                    ),
                  ),
                ),
                child: Text(
                  tab.toUpperCase(),
                  style: TextStyle(
                    color: isSelected ? AppColors.primaryText : AppColors.secondaryText,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
