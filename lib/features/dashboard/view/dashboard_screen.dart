import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/view/widgets/activity_feed.dart';
import 'package:paracareplus/features/dashboard/view/widgets/alert_banner.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_header.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_sidebar.dart';
import 'package:paracareplus/features/dashboard/view/widgets/critical_patients_table.dart';
import 'package:paracareplus/features/dashboard/view/widgets/dashboard_metric_tile.dart';
import 'package:paracareplus/features/dashboard/view/widgets/module_status_grid.dart';
import 'package:paracareplus/features/dashboard/view/widgets/pending_tasks_list.dart';
import 'package:paracareplus/features/dashboard/view/widgets/quick_action_grid.dart';
import 'package:paracareplus/features/dashboard/view/widgets/staff_on_duty_list.dart';
import 'package:paracareplus/features/dashboard/view_model/dashboard_view_model.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardViewModelProvider);
    final isWideScreen = MediaQuery.of(context).size.width > 1200;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(),
      drawer: isWideScreen ? null : const Drawer(child: AppSidebar()),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sidebar - permanently visible on wide screens
            if (isWideScreen) const AppSidebar(),

            // Main Content Area
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: dashboardState.when(
                      data: (state) =>
                          _buildScrollableBody(context, ref, state),
                      loading: () => const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                      error: (err, stack) => _buildErrorState(ref, err),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableBody(
    BuildContext context,
    WidgetRef ref,
    DashboardState state,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopActionsRow(),
          const SizedBox(height: AppSpacing.md),

          // Alert Section
          ...state.alerts.map((alert) => AlertBanner(alert: alert)),

          const SizedBox(height: AppSpacing.md),

          // Metrics Grid
          _buildMetricsGrid(state),

          const SizedBox(height: AppSpacing.lg),

          const Text('Quick Actions', style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSpacing.md),
          const QuickActionGrid(),

          const SizedBox(height: AppSpacing.lg),

          // Charts and Data Section
          _buildDataSection(context, state),

          const SizedBox(height: AppSpacing.xl),

          ModuleStatusGrid(modules: state.moduleStatus),

          const SizedBox(height: AppSpacing.xl),
        ],
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
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Executive Dashboard', style: AppTextStyles.titleMedium),
              ],
            ),
            Row(
              children: [
                _buildActionBtn(Icons.refresh_rounded, 'Refresh'),
                const SizedBox(width: 8),
                _buildActionBtn(Icons.print_outlined, 'Print Report'),
                const SizedBox(width: 8),
                _buildActionBtn(
                  Icons.add_box_rounded,
                  'New Patient',
                  isPrimary: true,
                ),
              ],
            ),
          ],
        ),
        Text(
          'Monitor Hospital Enterprise Operations Overview | Real-time Data',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildActionBtn(
    IconData icon,
    String label, {
    bool isPrimary = false,
  }) {
    return IconButton(
      onPressed: () {},
      icon: Icon(icon, size: 18),
      // label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? AppColors.primary : AppColors.card,
        foregroundColor: isPrimary ? Colors.white : AppColors.primaryText,
        side: isPrimary ? null : const BorderSide(color: AppColors.border),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildMetricsGrid(DashboardState state) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: AppSpacing.md,
      mainAxisSpacing: AppSpacing.md,
      childAspectRatio: 1.75,
      children: [
        DashboardMetricTile(
          title: 'Today OPD',
          value: '${state.stats.totalOpdToday}',
          icon: Icons.person_add_rounded,
          trend: '+12% from yesterday',
        ),
        DashboardMetricTile(
          title: 'Current Bed Occupancy',
          value: '${state.stats.totalIpdAdmissions}',
          icon: Icons.hotel_rounded,
          color: Colors.orange,
        ),
        DashboardMetricTile(
          title: 'Emergency Cases',
          value: '${state.stats.activeEmergencyCases}',
          icon: Icons.emergency_rounded,
          color: AppColors.error,
        ),
        DashboardMetricTile(
          title: 'Discharged Today',
          value: '${state.stats.dischargedToday}',
          icon: Icons.exit_to_app_rounded,
          color: AppColors.success,
        ),
        DashboardMetricTile(
          title: 'Lab Tests Today',
          value: '${state.stats.labTestsToday}',
          icon: Icons.science_rounded,
          color: Colors.purple,
        ),
        DashboardMetricTile(
          title: 'Total Revenue',
          value: state.stats.totalRevenue,
          icon: Icons.payments_rounded,
          trend: state.stats.revenueTrend,
          color: Colors.green,
        ),
        DashboardMetricTile(
          title: 'Active Ambulances',
          value: '${state.stats.totalAmbulancesOnDuty}',
          icon: Icons.local_shipping_rounded,
          color: Colors.blue,
        ),
        DashboardMetricTile(
          title: 'Bed Occupancy',
          value: '${(state.stats.bedOccupancyRate * 100).toInt()}%',
          icon: Icons.pie_chart_rounded,
          color: Colors.indigo,
        ),
      ],
    );
  }

  Widget _buildDataSection(BuildContext context, DashboardState state) {
    final isWide = MediaQuery.of(context).size.width > 1200;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              CriticalPatientsTable(patients: state.criticalPatients),
              const SizedBox(height: AppSpacing.lg),
              if (!isWide) ...[
                const PendingTasksList(),
                const SizedBox(height: AppSpacing.lg),
                StaffOnDutyList(staff: state.staffOnDuty),
              ],
            ],
          ),
        ),
        if (isWide) ...[
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              children: [
                const PendingTasksList(),
                const SizedBox(height: AppSpacing.lg),
                StaffOnDutyList(staff: state.staffOnDuty),
                const SizedBox(height: AppSpacing.lg),
                ActivityFeed(items: state.activityFeed),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildErrorState(WidgetRef ref, Object err) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: AppColors.error,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading dashboard: $err',
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>
                ref.read(dashboardViewModelProvider.notifier).refresh(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
