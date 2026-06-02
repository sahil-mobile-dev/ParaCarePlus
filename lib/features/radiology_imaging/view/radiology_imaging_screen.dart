import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_sidebar.dart';
import 'package:paracareplus/features/radiology_imaging/view/widgets/radiology_kpi_grid.dart';
import 'package:paracareplus/features/radiology_imaging/view/widgets/radiology_modals.dart';
import 'package:paracareplus/features/radiology_imaging/view/widgets/tabs/radiology_ai_findings_tab.dart';
import 'package:paracareplus/features/radiology_imaging/view/widgets/tabs/radiology_analytics_tab.dart';
import 'package:paracareplus/features/radiology_imaging/view/widgets/tabs/radiology_modalities_tab.dart';
import 'package:paracareplus/features/radiology_imaging/view/widgets/tabs/radiology_protocols_tab.dart';
import 'package:paracareplus/features/radiology_imaging/view/widgets/tabs/radiology_reporting_tab.dart';
import 'package:paracareplus/features/radiology_imaging/view/widgets/tabs/radiology_schedule_tab.dart';
import 'package:paracareplus/features/radiology_imaging/view/widgets/tabs/radiology_worklist_tab.dart';
import 'package:paracareplus/features/radiology_imaging/view_model/radiology_imaging_view_model.dart';
import 'package:paracareplus/routes/route_paths.dart';

class RadiologyImagingScreen extends ConsumerWidget {
  const RadiologyImagingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(radiologyImagingProvider);
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 1200;

    Widget bodyContent;
    switch (state.activeTab) {
      case 'Worklist':
        bodyContent = const RadiologyWorklistTab();
      case 'Schedule':
        bodyContent = const RadiologyScheduleTab();
      case 'Modalities':
        bodyContent = const RadiologyModalitiesTab();
      case 'Reporting':
        bodyContent = const RadiologyReportingTab();
      case 'AI Findings':
        bodyContent = const RadiologyAiFindingsTab();
      case 'Protocols':
        bodyContent = const RadiologyProtocolsTab();
      case 'Analytics':
        bodyContent = const RadiologyAnalyticsTab();
      default:
        bodyContent = const RadiologyWorklistTab();
    }

    final tabs = [
      'Worklist',
      'Schedule',
      'Modalities',
      'Reporting',
      'AI Findings',
      'Protocols',
      'Analytics',
    ];

    final Widget mainBody = Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // RIS Telemetry KPI Grid
              const RadiologyKpiGrid(),
              const SizedBox(height: AppSpacing.lg),

              // Tab Switcher Row
              Container(
                height: 48,
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.border)),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tabs.length,
                  itemBuilder: (context, index) {
                    final tab = tabs[index];
                    final isSelected = state.activeTab == tab;

                    return GestureDetector(
                      onTap: () {
                        ref
                            .read(radiologyImagingProvider.notifier)
                            .selectTab(tab);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 24),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isSelected
                                  ? AppColors.primaryLight
                                  : Colors.transparent,
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
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Tab Body Content
              bodyContent,
              const SizedBox(height: AppSpacing.xxl),

              // Footer
              Center(
                child: Text(
                  'ParaCare+ HMIS v2.0 — Radiology Information System — Uttarakhand State HIMS',
                  style: TextStyle(
                    color: AppColors.secondaryText.withValues(alpha: 0.5),
                    fontSize: 10,
                    fontFamily: AppTextStyles.fontFamily,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (state.isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.5),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go(RoutePaths.dashboardHub),
        ),

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Radiology & Imaging',
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'RIS operational command',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () =>
                ref.read(radiologyImagingProvider.notifier).refresh(),
          ),
          const SizedBox(width: 8),
          IconButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const RadiologyNewOrderModal(),
              );
            },
            icon: const Icon(Icons.add, size: 14, color: Colors.white),
          ),
          const SizedBox(width: 12),
        ],
        backgroundColor: AppColors.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isWide) const AppSidebar(),
            Expanded(child: mainBody),
          ],
        ),
      ),
    );
  }
}
