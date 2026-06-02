import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_sidebar.dart';
import 'package:paracareplus/features/inventory/view/tabs/assets_tab.dart';
import 'package:paracareplus/features/inventory/view/tabs/expiry_tab.dart';
import 'package:paracareplus/features/inventory/view/tabs/grn_tab.dart';
import 'package:paracareplus/features/inventory/view/tabs/indent_tab.dart';
import 'package:paracareplus/features/inventory/view/tabs/po_tab.dart';
import 'package:paracareplus/features/inventory/view/tabs/reports_tab.dart';
import 'package:paracareplus/features/inventory/view/tabs/stock_tab.dart';
import 'package:paracareplus/features/inventory/view/tabs/vendor_tab.dart';
import 'package:paracareplus/features/inventory/view_model/inventory_view_model.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(inventoryTabProvider);
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 1200;

    Widget bodyContent;
    switch (activeTab) {
      case 'Stock':
        bodyContent = const StockTab();
      case 'Indent':
        bodyContent = const IndentTab();
      case 'GRN':
        bodyContent = const GrnTab();
      case 'Purchase Orders':
        bodyContent = const PoTab();
      case 'Vendors':
        bodyContent = const VendorTab();
      case 'Assets':
        bodyContent = const AssetsTab();
      case 'Expiry':
        bodyContent = const ExpiryTab();
      case 'Reports':
        bodyContent = const ReportsTab();
      default:
        bodyContent = const StockTab();
    }

    final Widget mainContent = Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.md),
            _buildTelemetryGrid(),
            const SizedBox(height: AppSpacing.xl),
            _buildInventoryTabBar(ref, activeTab),
            const SizedBox(height: AppSpacing.lg),
            bodyContent,
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Inventory & Store Management'),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [if (isWide) const AppSidebar(), mainContent],
        ),
      ),
    );
  }

  Widget _buildTelemetryGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 900
            ? 5
            : (constraints.maxWidth > 600 ? 3 : 2);
        return GridView.count(
          crossAxisCount: columns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.6,
          children: [
            _telemetryCard(
              'Total Items',
              '1,842',
              AppColors.primary,
              Icons.inventory_2_rounded,
            ),
            _telemetryCard(
              'Stock Value',
              '₹42L',
              AppColors.success,
              Icons.currency_rupee_rounded,
            ),
            _telemetryCard(
              'Low Stock Alerts',
              '34',
              AppColors.secondaryAccent,
              Icons.warning_rounded,
            ),
            _telemetryCard(
              'Expiring ≤30 Days',
              '18',
              AppColors.error,
              Icons.timer_rounded,
            ),
            _telemetryCard(
              'Open POs',
              '8',
              AppColors.primaryLight,
              Icons.receipt_long_rounded,
            ),
          ],
        );
      },
    );
  }

  Widget _telemetryCard(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(icon, color: color, size: 16),
            ],
          ),
          Text(
            value,
            style: AppTextStyles.titleLarge.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryTabBar(WidgetRef ref, String activeTab) {
    final tabs = <String>[
      'Stock',
      'Indent',
      'GRN',
      'Purchase Orders',
      'Vendors',
      'Assets',
      'Expiry',
      'Reports',
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
              ref.read(inventoryTabProvider.notifier).state = tab;
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
