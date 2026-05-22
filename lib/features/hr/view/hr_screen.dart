import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_sidebar.dart';
import 'package:paracareplus/features/hr/view/tabs/attendance_tab.dart';
import 'package:paracareplus/features/hr/view/tabs/dashboard_tab.dart';
import 'package:paracareplus/features/hr/view/tabs/directory_tab.dart';
import 'package:paracareplus/features/hr/view/tabs/leave_tab.dart';
import 'package:paracareplus/features/hr/view/tabs/payroll_tab.dart';
import 'package:paracareplus/features/hr/view/tabs/recruitment_tab.dart';
import 'package:paracareplus/features/hr/view/tabs/reports_tab.dart';
import 'package:paracareplus/features/hr/view/tabs/training_tab.dart';
import 'package:paracareplus/features/hr/view_model/hr_view_model.dart';

class HrScreen extends ConsumerWidget {
  const HrScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(hrTabProvider);
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 1200;

    Widget bodyContent;
    switch (activeTab) {
      case 'Dashboard':
        bodyContent = const DashboardTab();
      case 'Directory':
        bodyContent = const DirectoryTab();
      case 'Attendance':
        bodyContent = const AttendanceTab();
      case 'Leave & Shifts':
        bodyContent = const LeaveTab();
      case 'Payroll':
        bodyContent = const PayrollTab();
      case 'Recruitment':
        bodyContent = const RecruitmentTab();
      case 'Training / CME':
        bodyContent = const TrainingTab();
      case 'Reports':
        bodyContent = const ReportsTab();
      default:
        bodyContent = const DashboardTab();
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
            _buildHrTabBar(ref, activeTab),
            const SizedBox(height: AppSpacing.lg),
            bodyContent,
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Human Resource & Payroll Management'),
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
              'Total Enterprise Staff',
              '342',
              AppColors.primary,
              Icons.groups_rounded,
            ),
            _telemetryCard(
              'Active On Duty',
              '184',
              AppColors.success,
              Icons.badge_rounded,
            ),
            _telemetryCard(
              'On Authorized Leave',
              '12',
              AppColors.error,
              Icons.beach_access_rounded,
            ),
            _telemetryCard(
              'Open Openings',
              '08',
              AppColors.secondaryAccent,
              Icons.work_rounded,
            ),
            _telemetryCard(
              'CME Compliance',
              '88.5%',
              AppColors.primaryLight,
              Icons.verified_user_rounded,
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

  Widget _buildHrTabBar(WidgetRef ref, String activeTab) {
    final tabs = <String>[
      'Dashboard',
      'Directory',
      'Attendance',
      'Leave & Shifts',
      'Payroll',
      'Recruitment',
      'Training / CME',
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
              ref.read(hrTabProvider.notifier).state = tab;
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
