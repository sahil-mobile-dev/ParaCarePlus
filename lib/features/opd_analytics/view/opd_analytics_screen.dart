import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_sidebar.dart';
import 'package:paracareplus/features/opd_analytics/view/widgets/charts/opd_consultation_trend_chart.dart';
import 'package:paracareplus/features/opd_analytics/view/widgets/charts/opd_counter_hour_heatmap.dart';
import 'package:paracareplus/features/opd_analytics/view/widgets/charts/opd_demographics_chart.dart';
import 'package:paracareplus/features/opd_analytics/view/widgets/charts/opd_hourly_load_chart.dart';
import 'package:paracareplus/features/opd_analytics/view/widgets/charts/opd_queue_congestion_chart.dart';
import 'package:paracareplus/features/opd_analytics/view/widgets/charts/opd_rush_hour_heatmap.dart';
import 'package:paracareplus/features/opd_analytics/view/widgets/charts/opd_specialty_demand_chart.dart';
import 'package:paracareplus/features/opd_analytics/view/widgets/charts/opd_specialty_weekday_heatmap.dart';
import 'package:paracareplus/features/opd_analytics/view/widgets/opd_analytics_alert_panel.dart';
import 'package:paracareplus/features/opd_analytics/view/widgets/opd_analytics_doctor_table.dart';
import 'package:paracareplus/features/opd_analytics/view/widgets/opd_analytics_kpi_card.dart';
import 'package:paracareplus/features/opd_analytics/view/widgets/opd_analytics_live_strip.dart';
import 'package:paracareplus/features/opd_analytics/view/widgets/opd_analytics_ticker.dart';
import 'package:paracareplus/features/opd_analytics/view_model/opd_analytics_view_model.dart';
import 'package:paracareplus/routes/route_names.dart';

class OpdAnalyticsScreen extends ConsumerStatefulWidget {
  const OpdAnalyticsScreen({super.key});

  @override
  ConsumerState<OpdAnalyticsScreen> createState() => _OpdAnalyticsScreenState();
}

class _OpdAnalyticsScreenState extends ConsumerState<OpdAnalyticsScreen>
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
    await ref.read(opdAnalyticsProvider.notifier).refresh();
    _syncAnimationController.stop();
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 1200;
    final state = ref.watch(opdAnalyticsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isWideScreen) const AppSidebar(),
            Expanded(
              child: Column(
                children: [
                  _buildTopbar(context),
                  const OpdAnalyticsTicker(),
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
                                'OPD Performance KPIs — Real-time',
                                'Live',
                              ),
                              _buildKpis(state),
                              const SizedBox(height: AppSpacing.lg),
                              const OpdAnalyticsLiveStrip(),
                              const SizedBox(height: AppSpacing.xl),
                              _buildChartsSection1(),
                              const SizedBox(height: AppSpacing.xl),
                              _buildChartsSection2(),
                              const SizedBox(height: AppSpacing.xl),
                              _buildChartsSection3(),
                              const SizedBox(height: AppSpacing.xl),
                              _buildHeatmapsSection(),
                              const SizedBox(height: AppSpacing.xl),
                              const OpdAnalyticsDoctorTable(),
                              const SizedBox(height: AppSpacing.xl),
                              const OpdAnalyticsAlertPanel(),
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
                                    'Syncing OPD Analytics Telemetry...',
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

  Widget _buildTopbar(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
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
              const Icon(Icons.people, color: AppColors.primaryLight, size: 22),
              const SizedBox(width: 8),
              const Text(
                'OPD Analytics Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF006064).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'OPD · Queue · Specialty',
                  style: TextStyle(
                    color: Color(0xFF00B4D8),
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
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
                      'LIVE OPD',
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

  Widget _buildFilterBar(BuildContext context, OpdAnalyticsState state) {
    final notifier = ref.read(opdAnalyticsProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.filter_list,
            color: AppColors.secondaryText,
            size: 16,
          ),
          const SizedBox(width: 8),
          const Text(
            'FILTERS:',
            style: TextStyle(
              color: AppColors.secondaryText,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          _buildDropdown(
            value: state.selectedFacility,
            items: [
              'All Facilities',
              'AIIMS Rishikesh',
              'Doon Hospital',
              'Haldwani Base',
            ],
            onChanged: (val) => notifier.changeFacility(val!),
          ),
          const SizedBox(width: 8),
          _buildDropdown(
            value: state.selectedSpecialty,
            items: [
              'All Specialties',
              'General Medicine',
              'Orthopaedics',
              'Gynaecology',
            ],
            onChanged: (val) => notifier.changeSpecialty(val!),
          ),
          const SizedBox(width: 8),
          _buildDropdown(
            value: state.selectedDistrict,
            items: ['All Districts', 'Dehradun', 'Haridwar', 'Nainital'],
            onChanged: (val) => notifier.changeDistrict(val!),
          ),
          const SizedBox(width: 8),
          _buildDropdown(
            value: state.selectedTimeframe,
            items: ['Today', 'Last 7 Days', 'Last 30 Days'],
            onChanged: (val) => notifier.changeTimeframe(val!),
          ),
          const Spacer(),
          _buildStatusChip('52,840 Today', AppColors.success),
          const SizedBox(width: 8),
          _buildStatusChip('3 Overcrowded OPDs', AppColors.secondaryAccent),
          const SizedBox(width: 8),
          _buildStatusChip('Avg Wait: 28 min', AppColors.primaryLight),
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

  Widget _buildKpis(OpdAnalyticsState state) {
    return Column(
      children: [
        GridView.count(
          crossAxisCount: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.4,
          children: [
            OpdAnalyticsKpiCard(
              title: 'Total OPD Today',
              value: state.kpis.totalOpdToday.toString(),
              subtitle: 'All facilities combined',
              icon: Icons.people,
              colorTheme: AppColors.primaryLight,
              progressPercent: 0.88,
              deltaText: '+4.7% vs avg',
              deltaType: 'up',
            ),
            OpdAnalyticsKpiCard(
              title: 'Avg Patient Wait Time',
              value: '${state.kpis.avgWaitTimeMinutes} min',
              subtitle: 'State-wide average today',
              icon: Icons.hourglass_empty,
              colorTheme: AppColors.success,
              progressPercent: 0.44,
              deltaText: '-4 min vs last week',
              deltaType: 'up',
            ),
            OpdAnalyticsKpiCard(
              title: 'Avg Consultation Time',
              value: '${state.kpis.avgConsultationTimeMinutes} min',
              subtitle: 'Doctor-patient time',
              icon: Icons.healing,
              colorTheme: Colors.purpleAccent,
              progressPercent: 0.56,
              deltaText: '+0.6 min improved',
              deltaType: 'up',
            ),
            OpdAnalyticsKpiCard(
              title: 'New vs Revisit Ratio',
              value: state.kpis.newVsRevisitRatio,
              subtitle: 'New : Follow-up patients',
              icon: Icons.loop,
              colorTheme: AppColors.secondaryAccent,
              progressPercent: 0.62,
              deltaText: 'Stable pattern',
              deltaType: 'stable',
            ),
            OpdAnalyticsKpiCard(
              title: 'ePrescription Rate',
              value:
                  '${state.kpis.ePrescriptionRatePercent.toStringAsFixed(1)}%',
              subtitle: 'Digital prescriptions issued',
              icon: Icons.receipt_long,
              colorTheme: AppColors.success,
              progressPercent: 0.65,
              deltaText: '+7.2% QoQ',
              deltaType: 'up',
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        GridView.count(
          crossAxisCount: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.4,
          children: [
            OpdAnalyticsKpiCard(
              title: 'ABHA Scan & Share %',
              value: '${state.kpis.abhaScanSharePercent.toStringAsFixed(1)}%',
              subtitle: 'Registrations via ABHA scan',
              icon: Icons.qr_code_scanner,
              colorTheme: AppColors.primaryLight,
              progressPercent: state.kpis.abhaScanSharePercent / 100,
              deltaText: '+4.3% MoM',
              deltaType: 'up',
            ),
            OpdAnalyticsKpiCard(
              title: 'Telemedicine OPD',
              value: state.kpis.telemedicineOpdCount.toString(),
              subtitle: 'eSanjeevani today',
              icon: Icons.video_call,
              colorTheme: Colors.orangeAccent,
              progressPercent: 0.34,
              deltaText: '+18.4% vs last month',
              deltaType: 'up',
            ),
            OpdAnalyticsKpiCard(
              title: 'OPD → IPD Conversion',
              value:
                  '${state.kpis.opdToIpdConversionPercent.toStringAsFixed(1)}%',
              subtitle: 'OPD patients admitted to IPD',
              icon: Icons.drive_file_move,
              colorTheme: AppColors.error,
              progressPercent: 0.07,
              deltaText: 'Stable ±0.4%',
              deltaType: 'stable',
            ),
            OpdAnalyticsKpiCard(
              title: 'OPD CSAT Score',
              value: '${state.kpis.opdCsatScore.toStringAsFixed(1)}/5',
              subtitle: 'Patient satisfaction (OPD)',
              icon: Icons.star,
              colorTheme: AppColors.success,
              progressPercent: 0.8,
              deltaText: '+0.1 vs last quarter',
              deltaType: 'up',
            ),
            OpdAnalyticsKpiCard(
              title: 'OPD Lab Referral Rate',
              value:
                  '${state.kpis.opdLabReferralRatePercent.toStringAsFixed(1)}%',
              subtitle: 'Patients referred for tests',
              icon: Icons.science,
              colorTheme: Colors.purpleAccent,
              progressPercent: 0.38,
              deltaText: 'Within normal range',
              deltaType: 'stable',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChartsSection1() {
    return const SizedBox(height: 280, child: OpdHourlyLoadChart());
  }

  Widget _buildChartsSection2() {
    return const SizedBox(
      height: 320,
      child: Row(
        children: [
          Expanded(child: OpdSpecialtyDemandChart()),
          SizedBox(width: AppSpacing.md),
          Expanded(child: OpdConsultationTrendChart()),
        ],
      ),
    );
  }

  Widget _buildChartsSection3() {
    return const SizedBox(
      height: 300,
      child: Row(
        children: [
          Expanded(flex: 3, child: OpdQueueCongestionChart()),
          SizedBox(width: AppSpacing.md),
          Expanded(flex: 2, child: OpdDemographicsChart()),
        ],
      ),
    );
  }

  Widget _buildHeatmapsSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Live Congestion Heatmaps',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '— Heat intensity analytics',
              style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 340,
          child: Row(
            children: [
              Expanded(child: OpdRushHourHeatmap()),
              SizedBox(width: AppSpacing.md),
              Expanded(child: OpdSpecialtyWeekdayHeatmap()),
              SizedBox(width: AppSpacing.md),
              Expanded(child: OpdCounterHourHeatmap()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ParaCare+ Uttarakhand · OPD Analytics Dashboard · HIMS v3.2',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
          ),
          Row(
            children: [
              Text(
                'State OPD Today: ',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
              ),
              Text(
                '52,840',
                style: TextStyle(
                  color: AppColors.success,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 16),
              Text(
                'Avg Wait: ',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
              ),
              Text(
                '28 min',
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
