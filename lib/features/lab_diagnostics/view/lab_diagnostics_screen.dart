import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_sidebar.dart';
import 'package:paracareplus/features/lab_diagnostics/view_model/lab_diagnostics_view_model.dart';
import 'package:paracareplus/features/lab_diagnostics/view/widgets/lab_kpi_grid.dart';
import 'package:paracareplus/features/lab_diagnostics/view/widgets/lab_modals.dart';
import 'package:paracareplus/features/lab_diagnostics/view/widgets/tabs/sample_queue_tab.dart';
import 'package:paracareplus/features/lab_diagnostics/view/widgets/tabs/urgent_stat_tab.dart';
import 'package:paracareplus/features/lab_diagnostics/view/widgets/tabs/result_entry_tab.dart';
import 'package:paracareplus/features/lab_diagnostics/view/widgets/tabs/critical_values_tab.dart';
import 'package:paracareplus/features/lab_diagnostics/view/widgets/tabs/reports_tab.dart';
import 'package:paracareplus/features/lab_diagnostics/view/widgets/tabs/tat_analytics_tab.dart';
import 'package:paracareplus/features/lab_diagnostics/view/widgets/tabs/analyzer_config_tab.dart';

class LabDiagnosticsScreen extends ConsumerWidget {
  const LabDiagnosticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(labDiagnosticsProvider);
    final notifier = ref.read(labDiagnosticsProvider.notifier);
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 1200;

    Widget tabBody;
    switch (state.activeTab) {
      case 'Sample Queue':
        tabBody = const SampleQueueTab();
      case 'Urgent/STAT':
        tabBody = const UrgentStatTab();
      case 'Result Entry':
        tabBody = const ResultEntryTab();
      case 'Critical Values':
        tabBody = const CriticalValuesTab();
      case 'Reports':
        tabBody = const ReportsTab();
      case 'TAT Analytics':
        tabBody = const TatAnalyticsTab();
      case 'Analyzer Config':
        tabBody = const AnalyzerConfigTab();
      default:
        tabBody = const SampleQueueTab();
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
                      '🧪 Laboratory Information System (LIS)',
                      style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Sample Management · Test Processing · Results · Reports · TAT Analytics',
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.secondaryText),
                    ),
                  ],
                ),
                // Actions
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                      onPressed: () => notifier.setTab('Urgent/STAT'),
                      child: const Text('🚨 URGENT TEST', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                      onPressed: () => LabModals.showNewSample(context, ref),
                      child: const Text('🧫 NEW SAMPLE', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
                      onPressed: () => notifier.setTab('Result Entry'),
                      child: const Text('📊 ENTER RESULT', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Stats Grid
            LabKpiGrid(
              samplesQueue: state.samples.where((s) => s.status != 'completed').length,
              urgentCount: state.urgentTests.length,
              criticalCount: state.criticalValues.where((c) => !c.acknowledged).length,
              completedCount: state.reports.length + state.samples.where((s) => s.status == 'completed').length,
              avgTat: '4.2h',
              qualityScore: '98.4%',
            ),
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

  Widget _buildTabBar(String activeTab, LabDiagnosticsNotifier notifier) {
    final tabs = [
      'Sample Queue',
      'Urgent/STAT',
      'Result Entry',
      'Critical Values',
      'Reports',
      'TAT Analytics',
      'Analyzer Config',
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
