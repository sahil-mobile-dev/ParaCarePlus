import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/state_admin/view/widgets/charts/state_admin_ab_claims_chart.dart';
import 'package:paracareplus/features/state_admin/view/widgets/charts/state_admin_budget_sunburst_chart.dart';
import 'package:paracareplus/features/state_admin/view/widgets/charts/state_admin_disease_burden_chart.dart';
import 'package:paracareplus/features/state_admin/view/widgets/charts/state_admin_mch_indicators_chart.dart';
import 'package:paracareplus/features/state_admin/view/widgets/charts/state_admin_opd_dept_chart.dart';
import 'package:paracareplus/features/state_admin/view/widgets/charts/state_admin_opd_trend_chart.dart';
import 'package:paracareplus/features/state_admin/view/widgets/charts/state_admin_revenue_payer_chart.dart';
import 'package:paracareplus/features/state_admin/view/widgets/state_admin_district_table.dart';
import 'package:paracareplus/features/state_admin/view/widgets/state_admin_gis_map.dart';
import 'package:paracareplus/features/state_admin/view/widgets/state_admin_kpi_card.dart';
import 'package:paracareplus/features/state_admin/view/widgets/state_admin_mini_stats.dart';
import 'package:paracareplus/features/state_admin/view/widgets/state_admin_sidebar.dart';
import 'package:paracareplus/features/state_admin/view/widgets/state_admin_ticker.dart';
import 'package:paracareplus/features/state_admin/view_model/state_admin_view_model.dart';
import 'package:paracareplus/routes/route_names.dart';

class StateAdminOverviewScreen extends ConsumerStatefulWidget {
  const StateAdminOverviewScreen({super.key});

  @override
  ConsumerState<StateAdminOverviewScreen> createState() =>
      _StateAdminOverviewScreenState();
}

class _StateAdminOverviewScreenState
    extends ConsumerState<StateAdminOverviewScreen> {
  late final Timer _clockTimer;
  String _timeString = '';

  @override
  void initState() {
    super.initState();
    _updateClock();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateClock();
    });
  }

  void _updateClock() {
    final now = DateTime.now();
    final hour = now.hour > 12
        ? now.hour - 12
        : (now.hour == 0 ? 12 : now.hour);
    final amPm = now.hour >= 12 ? 'PM' : 'AM';
    final min = now.minute.toString().padLeft(2, '0');
    final sec = now.second.toString().padLeft(2, '0');

    if (mounted) {
      setState(() {
        _timeString = '$hour:$min:$sec $amPm';
      });
    }
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }

  void _showExportDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
        title: const Row(
          children: [
            Text('📥', style: TextStyle(fontSize: 24)),
            SizedBox(width: 10),
            Text('Export Report', style: AppTextStyles.titleSmall),
          ],
        ),
        content: const Text(
          'Generating executive Uttarakhand State Health Administration metrics PDF. This document covers connected facilities scorecard, revenues, expenditures, MCH indicators, and workforce distributions.',
          style: TextStyle(
            color: AppColors.secondaryText,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.secondaryText),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'State Health Administration Report downloaded successfully.',
                  ),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Download PDF'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 1200;
    final state = ref.watch(stateAdminProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isWideScreen) const StateAdminSidebar(),
            Expanded(
              child: Column(
                children: [
                  _buildTopbar(context, state),
                  const StateAdminTicker(),
                  Expanded(
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFilterBar(context, state),
                              const SizedBox(height: AppSpacing.lg),
                              _buildActiveTabContent(state),
                              const SizedBox(height: AppSpacing.xxl),
                              _buildFooter(),
                            ],
                          ),
                        ),
                        if (state.isRefreshing)
                          ColoredBox(
                            color: Colors.black.withValues(alpha: 0.65),
                            child: const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(
                                    color: AppColors.primaryLight,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Syncing State Administration Command Telemetry...',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
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

  Widget _buildTopbar(BuildContext context, StateAdminState state) {
    final isMobile = MediaQuery.of(context).size.width < 760;

    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.primaryLight),
            onPressed: () => context.pushNamed(RouteNames.dashboardHub),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              children: [
                const Text('🏛️', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'State Admin Overview',
                        style: AppTextStyles.labelLarge.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: isMobile ? 12.5 : 15,
                        ),
                      ),
                      if (!isMobile)
                        const Text(
                          'Office of Health Secretary & SHA — Uttarakhand Health Command Centre',
                          style: TextStyle(
                            fontSize: 9.5,
                            color: Colors.white54,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isMobile) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.35),
                ),
              ),
              child: const Row(
                children: [
                  _LiveDot(),
                  SizedBox(width: 6),
                  Text(
                    'LIVE SYNCED',
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Text(
              _timeString,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 14),
          ],
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.primaryLight),
            onPressed: () => ref.read(stateAdminProvider.notifier).refresh(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context, StateAdminState state) {
    final isMobile = MediaQuery.of(context).size.width < 760;

    Widget buildDropdown(
      String val,
      List<String> items,
      ValueChanged<String?> onChange,
    ) {
      return Container(
        height: 34,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.border),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: val,
            dropdownColor: AppColors.surface,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            items: items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: onChange,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          const Text(
            'FILTERS:',
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(width: 8),
          buildDropdown(
            state.selectedYear,
            ['FY 2024-25', 'FY 2023-24', 'FY 2022-23'],
            (v) => v != null
                ? ref.read(stateAdminProvider.notifier).changeYear(v)
                : null,
          ),
          const SizedBox(width: 6),
          buildDropdown(
            state.selectedMonth,
            ['all', 'Mar', 'Apr', 'May', 'Jun'],
            (v) => v != null
                ? ref.read(stateAdminProvider.notifier).changeMonth(v)
                : null,
          ),
          if (!isMobile) ...[
            const SizedBox(width: 6),
            buildDropdown(
              state.selectedDistrict,
              ['All Districts', 'Dehradun', 'Haridwar', 'Nainital', 'Almora'],
              (v) => v != null
                  ? ref.read(stateAdminProvider.notifier).changeDistrict(v)
                  : null,
            ),
            const SizedBox(width: 6),
            buildDropdown(
              state.selectedFacilityType,
              [
                'All Facility Types',
                'Medical College',
                'District Hospital',
                'CHC',
                'PHC',
              ],
              (v) => v != null
                  ? ref.read(stateAdminProvider.notifier).changeFacilityType(v)
                  : null,
            ),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00695C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
              ),
              icon: const Icon(Icons.download, size: 13),
              label: const Text(
                'Export',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              onPressed: () => _showExportDialog(context),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActiveTabContent(StateAdminState state) {
    switch (state.activeTab) {
      case 'map':
        return const StateAdminGisMap();
      case 'districts':
        return const StateAdminDistrictTable();
      case 'opd':
        return const Column(
          children: [
            StateAdminMiniStats(
              stats: [
                {
                  'label': 'OPD Today (State)',
                  'value': '68,241',
                  'color': Color(0xFF60A5FA),
                },
                {
                  'label': 'IPD Active Admissions',
                  'value': '12,847',
                  'color': Color(0xFF4DB6AC),
                },
                {
                  'label': 'Bed Occupancy %',
                  'value': '74%',
                  'color': AppColors.success,
                },
                {
                  'label': 'Avg Length of Stay',
                  'value': '4.2 Days',
                  'color': AppColors.secondaryAccent,
                },
              ],
            ),
            SizedBox(height: AppSpacing.lg),
            StateAdminOpdDeptChart(),
          ],
        );
      case 'disease':
        return const Column(
          children: [
            StateAdminMiniStats(
              stats: [
                {
                  'label': 'Dengue Active (7d)',
                  'value': '47',
                  'color': AppColors.error,
                },
                {
                  'label': 'Malaria Active (7d)',
                  'value': '23',
                  'color': AppColors.secondaryAccent,
                },
                {
                  'label': 'Active TB cases YTD',
                  'value': '4,218',
                  'color': AppColors.error,
                },
                {
                  'label': 'Hypertension Screened',
                  'value': '26K',
                  'color': AppColors.success,
                },
              ],
            ),
            SizedBox(height: AppSpacing.lg),
            StateAdminDiseaseBurdenChart(),
          ],
        );
      case 'mch':
        return const Column(
          children: [
            StateAdminMiniStats(
              stats: [
                {
                  'label': 'Deliveries (MTD)',
                  'value': '3,847',
                  'color': Color(0xFFF48FB1),
                },
                {
                  'label': 'Institutional Deliveries',
                  'value': '87.1%',
                  'color': AppColors.success,
                },
                {
                  'label': 'ANC 4+ Coverage',
                  'value': '94.3%',
                  'color': AppColors.success,
                },
                {
                  'label': 'Full Immunisation rate',
                  'value': '94.7%',
                  'color': AppColors.success,
                },
              ],
            ),
            SizedBox(height: AppSpacing.lg),
            StateAdminMchIndicatorsChart(),
          ],
        );
      case 'revenue':
        return const Column(
          children: [
            StateAdminMiniStats(
              stats: [
                {
                  'label': 'Revenue MTD (State)',
                  'value': '₹42.7 Cr',
                  'color': Color(0xFFFFCA28),
                },
                {
                  'label': 'OPD Collections MTD',
                  'value': '₹6.1 Cr',
                  'color': Color(0xFFFFCA28),
                },
                {
                  'label': 'IPD Collections MTD',
                  'value': '₹8.9 Cr',
                  'color': Color(0xFFFFCA28),
                },
                {
                  'label': 'Payer mix: CGHS/ESI',
                  'value': '₹9.2 Cr',
                  'color': Color(0xFFFFCA28),
                },
              ],
            ),
            SizedBox(height: AppSpacing.lg),
            StateAdminRevenuePayerChart(),
          ],
        );
      case 'ab':
        return const Column(
          children: [
            StateAdminMiniStats(
              stats: [
                {
                  'label': 'AB Beneficiaries MTD',
                  'value': '8,341',
                  'color': Color(0xFFCE93D8),
                },
                {
                  'label': 'Approved Claims SHA',
                  'value': '6,847',
                  'color': AppColors.success,
                },
                {
                  'label': 'Pending Claims',
                  'value': '1,247',
                  'color': AppColors.secondaryAccent,
                },
                {
                  'label': 'Rejected / Flagged Claims',
                  'value': '247',
                  'color': AppColors.error,
                },
              ],
            ),
            SizedBox(height: AppSpacing.lg),
            StateAdminAbClaimsChart(),
          ],
        );
      case 'facilities':
        return const StateAdminMiniStats(
          stats: [
            {
              'label': 'Medical Colleges Connected',
              'value': '12',
              'color': Color(0xFFEF5350),
            },
            {
              'label': 'District Hospitals',
              'value': '13',
              'color': Color(0xFF60A5FA),
            },
            {
              'label': 'Community Health Centres',
              'value': '89',
              'color': Color(0xFF26A69A),
            },
            {
              'label': 'Primary Health Centres',
              'value': '348',
              'color': AppColors.success,
            },
            {
              'label': 'Sub-Centres',
              'value': '1,385',
              'color': Color(0xFFFFCA28),
            },
          ],
        );
      case 'overview':
      default:
        return _buildOverviewPanel(state);
    }
  }

  Widget _buildOverviewPanel(StateAdminState state) {
    final cards = <StateAdminKpiCard>[
      StateAdminKpiCard(
        title: 'Total Facilities',
        value: '${state.kpis.totalFacilities}',
        trendText: '↑ 23 onboarded YTD',
        icon: Icons.domain,
        colorTheme: 'sky',
      ),
      StateAdminKpiCard(
        title: 'OPD Today (State)',
        value: '${state.kpis.opdToday}',
        trendText: '↑ 4.2% vs yesterday',
        icon: Icons.personal_injury,
        colorTheme: 'teal',
      ),
      StateAdminKpiCard(
        title: 'IPD Admissions',
        value: '${state.kpis.ipdAdmissions}',
        trendText: 'Bed Occupancy 74%',
        icon: Icons.hotel,
        colorTheme: 'green',
        trendUp: false,
      ),
      StateAdminKpiCard(
        title: 'Emergencies (24h)',
        value: '${state.kpis.emergencies24h}',
        trendText: '↑ 8.1% vs last week',
        icon: Icons.local_hospital,
        colorTheme: 'orange',
      ),
      StateAdminKpiCard(
        title: 'Revenue (MTD)',
        value: '₹${state.kpis.revenueMtdCr}Cr',
        trendText: '↑ 12% vs last month',
        icon: Icons.monetization_on,
        colorTheme: 'gold',
      ),
      StateAdminKpiCard(
        title: 'AB Beneficiaries',
        value: '${state.kpis.abBeneficiaries}',
        trendText: 'Approved this month',
        icon: Icons.medical_services,
        colorTheme: 'purple',
        trendUp: false,
      ),
      StateAdminKpiCard(
        title: 'Maternal Deaths (MTD)',
        value: '${state.kpis.maternalDeathsMtd}',
        trendText: '↓ 3 vs last month',
        icon: Icons.pregnant_woman,
        colorTheme: 'red',
        trendUp: false,
      ),
      StateAdminKpiCard(
        title: 'Active Doctors',
        value: '${state.kpis.activeDoctors}',
        trendText: 'On duty today state-wide',
        icon: Icons.badge,
        colorTheme: 'cyan',
        trendUp: false,
      ),
      StateAdminKpiCard(
        title: '108 Calls (24h)',
        value: '${state.kpis.ambulanceCalls24h}',
        trendText: 'Avg resp: 11.4 min',
        icon: Icons.phone_in_talk,
        colorTheme: 'pink',
        trendUp: false,
      ),
      StateAdminKpiCard(
        title: 'Lab Tests (24h)',
        value: '${state.kpis.labTests24h}',
        trendText: '↑ 6.3% vs yesterday',
        icon: Icons.biotech,
        colorTheme: 'teal',
      ),
      StateAdminKpiCard(
        title: 'Deliveries (MTD)',
        value: '${state.kpis.deliveriesMtd}',
        trendText: 'Inst. delivery 87.1%',
        icon: Icons.child_friendly,
        colorTheme: 'sky',
        trendUp: false,
      ),
      StateAdminKpiCard(
        title: 'AB Claims (Pending)',
        value: '${state.kpis.abClaimsPending}',
        trendText: '₹18.4Cr value reviews',
        icon: Icons.receipt_long,
        colorTheme: 'gold',
        trendUp: false,
      ),
    ];

    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final cols = w < 500 ? 1 : (w < 850 ? 2 : (w < 1250 ? 3 : 6));
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cards.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.45,
              ),
              itemBuilder: (context, index) => cards[index],
            );
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final isMobile = w < 760;

            const ch1 = StateAdminOpdTrendChart();
            const ch2 = StateAdminBudgetSunburstChart();

            return isMobile
                ? const Column(children: [ch1, SizedBox(height: 16), ch2])
                : const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: ch1),
                      SizedBox(width: 16),
                      Expanded(child: ch2),
                    ],
                  );
          },
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ParaCare+ Uttarakhand — State Health Command Center Super Admin Panel',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
          ),
          Text(
            'HMIS Connected — Office of Health Secretary',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _LiveDot extends StatefulWidget {
  const _LiveDot();

  @override
  State<_LiveDot> createState() => _LiveDotState();
}

class _LiveDotState extends State<_LiveDot> {
  double _opacity = 1;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 700), (timer) {
      if (mounted) {
        setState(() {
          _opacity = _opacity == 1.0 ? 0.3 : 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 600),
      child: Container(
        width: 7,
        height: 7,
        decoration: const BoxDecoration(
          color: AppColors.success,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
