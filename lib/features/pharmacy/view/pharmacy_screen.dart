import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/pharmacy/view/tabs/dispense_queue_tab.dart';
import 'package:paracareplus/features/pharmacy/view/tabs/drug_inventory_tab.dart';
import 'package:paracareplus/features/pharmacy/view/tabs/expiry_alerts_tab.dart';
import 'package:paracareplus/features/pharmacy/view/tabs/grn_log_tab.dart';
import 'package:paracareplus/features/pharmacy/view/tabs/purchase_orders_tab.dart';
import 'package:paracareplus/features/pharmacy/view/tabs/rx_validation_tab.dart';
import 'package:paracareplus/features/pharmacy/view/tabs/stat_orders_tab.dart';
import 'package:paracareplus/features/pharmacy/view_model/pharmacy_view_model.dart';

class PharmacyScreen extends ConsumerWidget {
  const PharmacyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(pharmacyTabProvider);

    Widget bodyContent;
    switch (activeTab) {
      case 'Dispense Queue':
        bodyContent = const DispenseQueueTab();
      case 'STAT Orders':
        bodyContent = const StatOrdersTab();
      case 'Rx Validation':
        bodyContent = const RxValidationTab();
      case 'Drug Inventory':
        bodyContent = const DrugInventoryTab();
      case 'Expiry Alerts':
        bodyContent = const ExpiryAlertsTab();
      case 'GRN Log':
        bodyContent = const GrnLogTab();
      case 'Purchase Orders':
        bodyContent = const PurchaseOrdersTab();
      default:
        bodyContent = const DispenseQueueTab();
    }

    final Widget mainContent = Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPharmacyTabBar(ref, activeTab),
            const SizedBox(height: AppSpacing.lg),
            bodyContent,
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Pharmacy Management')),
      body: SafeArea(child: mainContent),
    );
  }

  Widget _buildPharmacyTabBar(WidgetRef ref, String activeTab) {
    const tabs = <String>[
      'Dispense Queue',
      'STAT Orders',
      'Rx Validation',
      'Drug Inventory',
      'Expiry Alerts',
      'GRN Log',
      'Purchase Orders',
    ];

    return Container(
      height: 48,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = activeTab == tab;

          return GestureDetector(
            onTap: () {
              ref.read(pharmacyTabProvider.notifier).state = tab;
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 24),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                tab,
                style: AppTextStyles.labelMedium.copyWith(
                  color: isSelected
                      ? AppColors.primaryText
                      : AppColors.secondaryText,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
