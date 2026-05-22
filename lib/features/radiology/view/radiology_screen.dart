import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_sidebar.dart';
import 'package:paracareplus/features/radiology/view/tabs/ai_findings_tab.dart';
import 'package:paracareplus/features/radiology/view/tabs/analytics_tab.dart';
import 'package:paracareplus/features/radiology/view/tabs/completed_reports_tab.dart';
import 'package:paracareplus/features/radiology/view/tabs/modality_control_tab.dart';
import 'package:paracareplus/features/radiology/view/tabs/protocols_tab.dart';
import 'package:paracareplus/features/radiology/view/tabs/reporting_tab.dart';
import 'package:paracareplus/features/radiology/view/tabs/schedule_tab.dart';
import 'package:paracareplus/features/radiology/view/tabs/worklist_tab.dart';
import 'package:paracareplus/features/radiology/view_model/radiology_view_model.dart';

class RadiologyScreen extends ConsumerWidget {
  const RadiologyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(radiologyTabProvider);
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 1200;

    Widget bodyContent;
    switch (activeTab) {
      case 'Worklist':
        bodyContent = const WorklistTab();
      case 'Schedule':
        bodyContent = const ScheduleTab();
      case 'Protocols':
        bodyContent = const ProtocolsTab();
      case 'Reporting':
        bodyContent = const ReportingTab();
      case 'Completed Reports':
        bodyContent = const CompletedReportsTab();
      case 'AI Findings':
        bodyContent = const AiFindingsTab();
      case 'Modality Control':
        bodyContent = const ModalityControlTab();
      case 'Analytics':
        bodyContent = const AnalyticsTab();
      default:
        bodyContent = const WorklistTab();
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
            _buildRadiologyTabBar(ref, activeTab),
            const SizedBox(height: AppSpacing.lg),
            bodyContent,
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Radiology & Imaging Information System (RIS)'),
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
              'Total Daily Scans',
              '48',
              AppColors.primary,
              Icons.camera_rounded,
            ),
            _telemetryCard(
              'Scans In Queue',
              '08',
              AppColors.secondaryAccent,
              Icons.hourglass_empty_rounded,
            ),
            _telemetryCard(
              'AI Brain Alerts',
              '02',
              AppColors.error,
              Icons.psychology_rounded,
            ),
            _telemetryCard(
              'Completed Reports',
              '36',
              AppColors.success,
              Icons.assignment_turned_in_rounded,
            ),
            _telemetryCard(
              'Mean TAT',
              '34 mins',
              AppColors.success,
              Icons.timer_outlined,
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

  Widget _buildRadiologyTabBar(WidgetRef ref, String activeTab) {
    final tabs = <String>[
      'Worklist',
      'Schedule',
      'Protocols',
      'Reporting',
      'Completed Reports',
      'AI Findings',
      'Modality Control',
      'Analytics',
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
          final isAlert = tab == 'AI Findings';

          return GestureDetector(
            onTap: () {
              ref.read(radiologyTabProvider.notifier).state = tab;
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
              child: Row(
                children: [
                  if (isAlert)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Icon(
                        Icons.psychology_rounded,
                        color: isSelected
                            ? AppColors.secondaryAccent
                            : AppColors.secondaryText,
                        size: 14,
                      ),
                    ),
                  Text(
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
