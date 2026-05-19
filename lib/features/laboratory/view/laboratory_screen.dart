import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_sidebar.dart';
import 'package:paracareplus/features/laboratory/view/tabs/critical_alerts_tab.dart';
import 'package:paracareplus/features/laboratory/view/tabs/lab_inventory_tab.dart';
import 'package:paracareplus/features/laboratory/view/tabs/lab_tests_queue_tab.dart';
import 'package:paracareplus/features/laboratory/view/tabs/template_manager_tab.dart';
import 'package:paracareplus/features/laboratory/view_model/laboratory_view_model.dart';

class LaboratoryScreen extends ConsumerWidget {
  const LaboratoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(laboratoryTabProvider);
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 1200;

    Widget bodyContent;
    switch (activeTab) {
      case 'Lab Tests Queue':
        bodyContent = const LabTestsQueueTab();
      case 'Critical Alerts':
        bodyContent = const CriticalAlertsTab();
      case 'Lab Inventory':
        bodyContent = const LabInventoryTab();
      case 'Template Manager':
        bodyContent = const TemplateManagerTab();
      default:
        bodyContent = const LabTestsQueueTab();
    }

    final Widget mainContent = Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLaboratoryTabBar(ref, activeTab),
            const SizedBox(height: AppSpacing.lg),
            bodyContent,
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Laboratory')),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [if (isWide) const AppSidebar(), mainContent],
        ),
      ),
    );
  }

  Widget _buildLaboratoryTabBar(WidgetRef ref, String activeTab) {
    final tabs = <String>[
      'Lab Tests Queue',
      'Critical Alerts',
      'Lab Inventory',
      'Template Manager',
    ];

    return Container(
      height: 48,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = activeTab == tab;

          return GestureDetector(
            onTap: () {
              ref.read(laboratoryTabProvider.notifier).state = tab;
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
