import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/features/hospital_performance/view/widgets/charts/hosp_adm_dis_chart.dart';
import 'package:paracareplus/features/hospital_performance/view/widgets/charts/hosp_bed_occupancy_trend_chart.dart';
import 'package:paracareplus/features/hospital_performance/view/widgets/charts/hosp_dept_bed_chart.dart';
import 'package:paracareplus/features/hospital_performance/view/widgets/charts/hosp_equipment_uptime_chart.dart';
import 'package:paracareplus/features/hospital_performance/view/widgets/charts/hosp_patient_funnel_chart.dart';
import 'package:paracareplus/features/hospital_performance/view/widgets/charts/hosp_referral_trend_chart.dart';
import 'package:paracareplus/features/hospital_performance/view/widgets/charts/hosp_revenue_chart.dart';
import 'package:paracareplus/features/hospital_performance/view/widgets/charts/hosp_sunburst_beds_chart.dart';
import 'package:paracareplus/features/hospital_performance/view/widgets/charts/hosp_sunburst_caseload_chart.dart';
import 'package:paracareplus/features/hospital_performance/view/widgets/charts/hosp_sunburst_revenue_chart.dart';
import 'package:paracareplus/features/hospital_performance/view/widgets/hospital_performance_alert_panel.dart';
import 'package:paracareplus/features/hospital_performance/view/widgets/hospital_performance_kpi_card.dart';
import 'package:paracareplus/features/hospital_performance/view/widgets/hospital_performance_scorecard_table.dart';
import 'package:paracareplus/features/hospital_performance/view/widgets/hospital_performance_ticker.dart';
import 'package:paracareplus/features/hospital_performance/view_model/hospital_performance_view_model.dart';
import 'package:paracareplus/routes/route_names.dart';

class HospitalPerformanceScreen extends ConsumerStatefulWidget {
  const HospitalPerformanceScreen({super.key});

  @override
  ConsumerState<HospitalPerformanceScreen> createState() =>
      _HospitalPerformanceScreenState();
}

class _HospitalPerformanceScreenState
    extends ConsumerState<HospitalPerformanceScreen>
    with SingleTickerProviderStateMixin {
  late final Timer _clockTimer;
  String _timeString = '';
  late final AnimationController _syncAnimationController;

  @override
  void initState() {
    super.initState();
    _updateClock();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateClock();
    });
    _syncAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
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
        _timeString = '⏱ $hour:$min:$sec $amPm';
      });
    }
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    _syncAnimationController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    await _syncAnimationController.repeat();
    await ref.read(hospitalPerformanceProvider.notifier).refresh();
    _syncAnimationController.stop();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hospitalPerformanceProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopbar(context),
            const HospitalPerformanceTicker(),
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
                        _buildSectionHeader(
                          'Capacity & Utilisation KPIs',
                          'Live',
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        _buildCapacityKpis(state),
                        const SizedBox(height: AppSpacing.lg),
                        _buildSectionHeader('Clinical Activity KPIs', 'Today'),
                        _buildClinicalKpis(state),
                        const SizedBox(height: AppSpacing.lg),
                        _buildSectionHeader(
                          'Quality & Outcome KPIs',
                          'NHM Benchmarks',
                        ),
                        _buildQualityKpis(state),
                        const SizedBox(height: AppSpacing.xl),
                        _buildChartsSection1(),
                        const SizedBox(height: AppSpacing.xl),
                        _buildChartsSection2(),
                        const SizedBox(height: AppSpacing.xl),
                        _buildChartsSection3(),
                        const SizedBox(height: AppSpacing.xl),
                        _buildSunburstSection(),
                        const SizedBox(height: AppSpacing.xl),
                        const HospitalPerformanceScorecardTable(),
                        const SizedBox(height: AppSpacing.xl),
                        const HospitalPerformanceAlertPanel(),
                        const SizedBox(height: AppSpacing.xxl),
                        _buildFooter(),
                      ],
                    ),
                  ),
                  if (state.isRefreshing)
                    ColoredBox(
                      color: Colors.black.withValues(alpha: 0.6),
                      child: const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(
                              color: AppColors.primaryLight,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Syncing Hospital Performance Data...',
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
    );
  }

  Widget _buildTopbar(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.primaryLight,
                ),
                onPressed: () => context.goNamed(RouteNames.dashboardHub),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.local_hospital,
                color: AppColors.primaryLight,
                size: 22,
              ),
              const SizedBox(width: 8),
              const Text(
                'Hospital Performance Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'HIMS · HMIS · NHM',
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  border: Border.all(
                    color: AppColors.success.withValues(alpha: 0.3),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'LIVE',
                      style: TextStyle(
                        color: AppColors.success,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                _timeString,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 11.5,
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                  foregroundColor: AppColors.primaryLight,
                  side: const BorderSide(color: AppColors.border),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                onPressed: _handleRefresh,
                icon: RotationTransition(
                  turns: _syncAnimationController,
                  child: const Icon(Icons.sync, size: 14),
                ),
                label: const Text('Refresh', style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context, HospitalPerformanceState state) {
    final notifier = ref.read(hospitalPerformanceProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildDropdown(
                value: state.selectedHospital,
                items: [
                  'All Hospitals',
                  'AIIMS Rishikesh',
                  'Doon Hospital',
                  'Haldwani Base Hospital',
                ],
                onChanged: (val) => notifier.changeHospital(val!),
              ),
              const SizedBox(width: 8),
              _buildDropdown(
                value: state.selectedFacilityType,
                items: [
                  'All Facility Types',
                  'Medical College Hospital',
                  'District Hospital',
                ],
                onChanged: (val) => notifier.changeFacilityType(val!),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildDropdown(
                value: state.selectedDistrict,
                items: ['All Districts', 'Dehradun', 'Haridwar', 'Nainital'],
                onChanged: (val) => notifier.changeDistrict(val!),
              ),
              const SizedBox(width: 8),
              _buildDropdown(
                value: state.selectedTimePeriod,
                items: ['Last 30 Days', 'Last 7 Days', 'Last 90 Days'],
                onChanged: (val) => notifier.changeTimePeriod(val!),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.filter_list,
                color: AppColors.secondaryText,
                size: 16,
              ),
              const SizedBox(width: 8),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStatusChip('14 NABH Accredited', AppColors.success),
              const SizedBox(width: 8),
              _buildStatusChip('3 Overcrowded', AppColors.secondaryAccent),
              const SizedBox(width: 8),
              _buildStatusChip('2 Equipment Down', AppColors.error),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: AppColors.surface,
          style: const TextStyle(color: Colors.white, fontSize: 11.5),
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem(value: item, child: Text(item));
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String badge) {
    return Row(
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.border.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.primaryLight.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            badge,
            style: const TextStyle(
              color: AppColors.primaryLight,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCapacityKpis(HospitalPerformanceState state) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSpacing.md,
      mainAxisSpacing: AppSpacing.md,
      childAspectRatio: 1.2,
      children: [
        HospitalPerformanceKpiCard(
          title: 'Active Hospitals',
          value: state.kpis.activeHospitals.toString(),
          subtitle: 'Functional reporting facilities',
          icon: Icons.local_hospital,
          colorTheme: AppColors.primaryLight,
          progressPercent: 0.82,
          deltaText: '+3 this month',
          deltaType: 'up',
        ),
        HospitalPerformanceKpiCard(
          title: 'Total Sanctioned Beds',
          value: state.kpis.totalBeds.toString(),
          subtitle: 'All facility levels',
          icon: Icons.bed,
          colorTheme: AppColors.primaryLight,
          progressPercent: 0.75,
          deltaText: '+240 new beds added',
          deltaType: 'up',
        ),
        HospitalPerformanceKpiCard(
          title: 'Overall Bed Occupancy %',
          value: '${state.kpis.bedOccupancyPercent.toStringAsFixed(1)}%',
          subtitle: 'Occupied / Functional beds',
          icon: Icons.percent,
          colorTheme: AppColors.secondaryAccent,
          progressPercent: state.kpis.bedOccupancyPercent / 100,
          deltaText: '±1.2% stable',
          deltaType: 'stable',
        ),
        HospitalPerformanceKpiCard(
          title: 'ICU Occupancy %',
          value: '${state.kpis.icuOccupancyPercent.toStringAsFixed(1)}%',
          subtitle: '1,284 ICU beds total',
          icon: Icons.personal_injury,
          colorTheme: AppColors.error,
          progressPercent: state.kpis.icuOccupancyPercent / 100,
          deltaText: '+2.1% vs yesterday',
          deltaType: 'up',
        ),
        HospitalPerformanceKpiCard(
          title: 'OT Utilisation %',
          value: '${state.kpis.otUtilisationPercent.toStringAsFixed(1)}%',
          subtitle: 'Operating theatre efficiency',
          icon: Icons.cut,
          colorTheme: Colors.purpleAccent,
          progressPercent: state.kpis.otUtilisationPercent / 100,
          deltaText: '+3.2% vs last month',
          deltaType: 'up',
        ),
        HospitalPerformanceKpiCard(
          title: 'Ventilator Utilisation %',
          value:
              '${state.kpis.ventilatorUtilisationPercent.toStringAsFixed(1)}%',
          subtitle: '842 ventilators total',
          icon: Icons.air,
          colorTheme: AppColors.success,
          progressPercent: state.kpis.ventilatorUtilisationPercent / 100,
          deltaText: 'Stable',
          deltaType: 'stable',
        ),
      ],
    );
  }

  Widget _buildClinicalKpis(HospitalPerformanceState state) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSpacing.md,
      mainAxisSpacing: AppSpacing.md,
      childAspectRatio: 1.25,
      children: [
        HospitalPerformanceKpiCard(
          title: 'Daily OPD (State)',
          value: state.kpis.dailyOpd.toString(),
          subtitle: 'All facilities combined',
          icon: Icons.people,
          colorTheme: AppColors.success,
          progressPercent: 0.88,
          deltaText: '+4.7% vs avg',
          deltaType: 'up',
        ),
        HospitalPerformanceKpiCard(
          title: 'Daily IPD Admissions',
          value: state.kpis.dailyIpdAdmissions.toString(),
          subtitle: 'New admissions today',
          icon: Icons.airline_seat_flat_angled,
          colorTheme: AppColors.primaryLight,
          progressPercent: 0.76,
          deltaText: '+2.3% vs avg',
          deltaType: 'up',
        ),
        HospitalPerformanceKpiCard(
          title: 'Daily Discharges',
          value: state.kpis.dailyDischarges.toString(),
          subtitle: 'Planned + Emergency',
          icon: Icons.logout,
          colorTheme: AppColors.success,
          progressPercent: 0.74,
          deltaText: 'On track',
          deltaType: 'up',
        ),
        HospitalPerformanceKpiCard(
          title: 'Surgeries Performed Today',
          value: state.kpis.surgeriesToday.toString(),
          subtitle: 'Elective + Emergency',
          icon: Icons.healing,
          colorTheme: Colors.purpleAccent,
          progressPercent: 0.83,
          deltaText: '+8.1% vs last week',
          deltaType: 'up',
        ),
        HospitalPerformanceKpiCard(
          title: 'Avg Length of Stay',
          value: '${state.kpis.avgLengthOfStay.toStringAsFixed(1)}d',
          subtitle: 'Target: <4.5d',
          icon: Icons.timer,
          colorTheme: AppColors.secondaryAccent,
          progressPercent: 0.57,
          deltaText: '-0.3d improved',
          deltaType: 'up',
        ),
        HospitalPerformanceKpiCard(
          title: 'Referrals Out (MTD)',
          value: state.kpis.referralsOutMtd.toString(),
          subtitle: 'Inter-hospital referrals',
          icon: Icons.share,
          colorTheme: AppColors.primaryLight,
          progressPercent: 0.65,
          deltaText: '84% acceptance rate',
          deltaType: 'up',
        ),
      ],
    );
  }

  Widget _buildQualityKpis(HospitalPerformanceState state) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSpacing.md,
      mainAxisSpacing: AppSpacing.md,
      childAspectRatio: 1.25,
      children: [
        HospitalPerformanceKpiCard(
          title: 'Patient Satisfaction',
          value: '${state.kpis.patientSatisfactionScore.toStringAsFixed(1)}/5',
          subtitle: 'State-wide average CSAT',
          icon: Icons.star,
          colorTheme: AppColors.success,
          progressPercent: 0.82,
          deltaText: '+0.2 vs last quarter',
          deltaType: 'up',
        ),
        HospitalPerformanceKpiCard(
          title: 'Readmission Rate (30d)',
          value: '${state.kpis.readmissionRate30Day.toStringAsFixed(1)}%',
          subtitle: 'Target: <5.0%',
          icon: Icons.keyboard_return,
          colorTheme: AppColors.error,
          progressPercent: 0.42,
          deltaText: 'Below benchmark',
          deltaType: 'up',
        ),
        HospitalPerformanceKpiCard(
          title: 'Hospital-Acquired Inf.',
          value:
              '${state.kpis.hospitalAcquiredInfectionsRate.toStringAsFixed(1)}%',
          subtitle: 'HAI rate per admissions',
          icon: Icons.bug_report,
          colorTheme: AppColors.secondaryAccent,
          progressPercent: 0.08,
          deltaText: '-0.1% improved',
          deltaType: 'up',
        ),
        HospitalPerformanceKpiCard(
          title: 'NABH Accredited Facilities',
          value: state.kpis.nabhAccreditedCount.toString(),
          subtitle: 'Out of 247 facilities',
          icon: Icons.verified,
          colorTheme: Colors.purpleAccent,
          progressPercent: 0.56,
          deltaText: '+2 this year',
          deltaType: 'up',
        ),
        HospitalPerformanceKpiCard(
          title: 'Equipment Uptime %',
          value: '${state.kpis.equipmentUptimePercent.toStringAsFixed(1)}%',
          subtitle: 'Critical medical equipment',
          icon: Icons.settings,
          colorTheme: AppColors.success,
          progressPercent: state.kpis.equipmentUptimePercent / 100,
          deltaText: '2 units offline',
          deltaType: 'stable',
        ),
      ],
    );
  }

  Widget _buildChartsSection1() {
    return const SizedBox(height: 280, child: HospBedOccupancyTrendChart());
  }

  Widget _buildChartsSection2() {
    return const Column(
      children: [
        SizedBox(height: 400, child: HospDeptBedChart()),
        SizedBox(height: AppSpacing.md),
        SizedBox(height: 320, child: HospPatientFunnelChart()),
      ],
    );
  }

  Widget _buildChartsSection3() {
    return const Column(
      children: [
        SizedBox(height: 320, child: HospAdmDisChart()),
        SizedBox(height: AppSpacing.md),
        SizedBox(height: 320, child: HospRevenueChart()),
        SizedBox(height: AppSpacing.md),
        SizedBox(height: 320, child: HospEquipmentUptimeChart()),
        SizedBox(height: AppSpacing.md),
        SizedBox(height: 220, child: HospReferralTrendChart()),
      ],
    );
  }

  Widget _buildSunburstSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Advanced Sunburst Analytics',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '— Hierarchical Drill-down',
              style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.md),
        SizedBox(height: 350, child: HospSunburstCaseloadChart()),
        SizedBox(height: AppSpacing.md),

        SizedBox(height: 350, child: HospSunburstRevenueChart()),
        SizedBox(height: AppSpacing.md),

        SizedBox(height: 350, child: HospSunburstBedsChart()),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ParaCare+ Uttarakhand · Hospital Performance Dashboard · HIMS · HMIS · NHM v3.2',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
          ),
          Row(
            children: [
              Text(
                'Active Facilities: ',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
              ),
              Text(
                '247',
                style: TextStyle(
                  color: AppColors.success,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 16),
              Text(
                'State Occupancy: ',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
              ),
              Text(
                '74.3%',
                style: TextStyle(
                  color: AppColors.secondaryAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
