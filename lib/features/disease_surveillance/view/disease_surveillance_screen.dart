import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_sidebar.dart';
import 'package:paracareplus/features/disease_surveillance/view/widgets/charts/cfr_trends_chart.dart';
import 'package:paracareplus/features/disease_surveillance/view/widgets/charts/dengue_weekly_chart.dart';
import 'package:paracareplus/features/disease_surveillance/view/widgets/charts/disease_incidence_trend_chart.dart';
import 'package:paracareplus/features/disease_surveillance/view/widgets/charts/malaria_species_chart.dart';
import 'package:paracareplus/features/disease_surveillance/view/widgets/charts/ncd_burden_chart.dart';
import 'package:paracareplus/features/disease_surveillance/view/widgets/charts/vaccination_coverage_chart.dart';
import 'package:paracareplus/features/disease_surveillance/view/widgets/charts/waterborne_trends_chart.dart';
import 'package:paracareplus/features/disease_surveillance/view/widgets/disease_surveillance_alert_panel.dart';
import 'package:paracareplus/features/disease_surveillance/view/widgets/disease_surveillance_gis_map.dart';
import 'package:paracareplus/features/disease_surveillance/view/widgets/disease_surveillance_heatmap_panel.dart';
import 'package:paracareplus/features/disease_surveillance/view/widgets/disease_surveillance_kpi_card.dart';
import 'package:paracareplus/features/disease_surveillance/view/widgets/disease_surveillance_outbreak_table.dart';
import 'package:paracareplus/features/disease_surveillance/view/widgets/disease_surveillance_ticker.dart';
import 'package:paracareplus/features/disease_surveillance/view_model/disease_surveillance_view_model.dart';
import 'package:paracareplus/routes/route_names.dart';

class DiseaseSurveillanceScreen extends ConsumerStatefulWidget {
  const DiseaseSurveillanceScreen({super.key});

  @override
  ConsumerState<DiseaseSurveillanceScreen> createState() =>
      _DiseaseSurveillanceScreenState();
}

class _DiseaseSurveillanceScreenState
    extends ConsumerState<DiseaseSurveillanceScreen> {
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

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 1200;
    final state = ref.watch(diseaseSurveillanceProvider);

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
                  const DiseaseSurveillanceTicker(),
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
                              _buildKpiGrid(state),
                              const SizedBox(height: AppSpacing.xl),
                              DiseaseSurveillanceOutbreakTable(
                                outbreaks: state.outbreaks,
                              ),
                              const SizedBox(height: AppSpacing.xl),
                              const DiseaseIncidenceTrendChart(),
                              const SizedBox(height: AppSpacing.xl),
                              _buildTwoColumnCharts(),
                              const SizedBox(height: AppSpacing.xl),
                              const WaterborneTrendsChart(),
                              const SizedBox(height: AppSpacing.xl),
                              const VaccinationCoverageChart(),
                              const SizedBox(height: AppSpacing.xl),
                              const NcdBurdenChart(),
                              const SizedBox(height: AppSpacing.xl),
                              const CfrTrendsChart(),
                              const SizedBox(height: AppSpacing.xl),
                              _buildHeatmapsSection(),
                              const SizedBox(height: AppSpacing.xl),
                              const DiseaseSurveillanceGisMap(),
                              const SizedBox(height: AppSpacing.xl),
                              DiseaseSurveillanceAlertPanel(
                                alerts: state.alerts,
                              ),
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
                                    'Syncing State Disease Surveillance Telemetry...',
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
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary.withValues(alpha: 0.15),
              foregroundColor: AppColors.primaryLight,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
            ),
            icon: const Icon(Icons.arrow_back, size: 13),
            label: const Text(
              'Hub',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
            onPressed: () => context.pushNamed(RouteNames.dashboardHub),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Row(
              children: [
                const Text('🦠', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'State Disease Surveillance',
                        style: AppTextStyles.labelLarge.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: isMobile ? 12.5 : 15,
                        ),
                      ),
                      if (!isMobile)
                        const Text(
                          'IDSP · IHIP · National Health Mission — Uttarakhand',
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
                color: AppColors.error.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.error.withValues(alpha: 0.35),
                ),
              ),
              child: const Row(
                children: [
                  _FlashingDot(),
                  SizedBox(width: 6),
                  Text(
                    'OUTBREAK WATCH',
                    style: TextStyle(
                      color: AppColors.error,
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
            onPressed: () =>
                ref.read(diseaseSurveillanceProvider.notifier).refresh(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context, DiseaseSurveillanceState state) {
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

    final barItems = [
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
        state.selectedDistrict,
        [
          'All Districts',
          'Dehradun',
          'Haridwar',
          'Nainital',
          'Almora',
          'Udham S Nagar',
        ],
        (v) {
          if (v != null) {
            ref.read(diseaseSurveillanceProvider.notifier).changeDistrict(v);
          }
        },
      ),
      const SizedBox(width: 6),
      buildDropdown(
        state.selectedDisease,
        [
          'All Diseases',
          'Dengue',
          'Malaria',
          'Typhoid',
          'Influenza/ILI',
          'Scrub Typhus',
        ],
        (v) {
          if (v != null) {
            ref.read(diseaseSurveillanceProvider.notifier).changeDisease(v);
          }
        },
      ),
      const SizedBox(width: 6),
      buildDropdown(
        state.selectedTimePeriod,
        ['Last 30 Days', 'Last 7 Days', 'Last 90 Days', 'This Year'],
        (v) {
          if (v != null) {
            ref.read(diseaseSurveillanceProvider.notifier).changeTimePeriod(v);
          }
        },
      ),
      const SizedBox(width: 6),
      buildDropdown(
        state.selectedFacilityLevel,
        [
          'All Facility Levels',
          'District Hospital',
          'CHC',
          'PHC',
          'Sub-Centre',
        ],
        (v) {
          if (v != null) {
            ref
                .read(diseaseSurveillanceProvider.notifier)
                .changeFacilityLevel(v);
          }
        },
      ),
      if (!isMobile) ...[
        const Spacer(),
        _buildStatusPill(
          '🚨 ${state.activeOutbreakCount} Active Outbreaks',
          AppColors.error,
        ),
        const SizedBox(width: 6),
        _buildStatusPill('⚠️ 3 Alerts', AppColors.secondaryAccent),
        const SizedBox(width: 6),
        _buildStatusPill('✔️ 8 Districts Clear', AppColors.success),
      ],
    ];

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: barItems.take(10).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildStatusPill(
                      '🚨 ${state.activeOutbreakCount} Active Outbreaks',
                      AppColors.error,
                    ),
                    const SizedBox(width: 6),
                    _buildStatusPill('⚠️ 3 Alerts', AppColors.secondaryAccent),
                  ],
                ),
              ],
            )
          : Row(children: barItems),
    );
  }

  static Widget _buildStatusPill(String label, Color col) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: col.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: col.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: col,
          fontSize: 9,
          fontWeight: FontWeight.bold,
          fontFamily: AppTextStyles.fontFamily,
        ),
      ),
    );
  }

  Widget _buildKpiGrid(DiseaseSurveillanceState state) {
    final cards = <DiseaseSurveillanceKpiCard>[
      DiseaseSurveillanceKpiCard(
        title: 'Active Outbreaks',
        value: '${state.activeOutbreakCount}',
        subText: 'Confirmed across state',
        emoji: '☣️',
        colorTheme: 'red',
        deltaText: '+2 this week',
        progressVal: 0.7,
      ),
      DiseaseSurveillanceKpiCard(
        title: 'New Cases Today',
        value: '${state.newCasesToday}',
        subText: 'Notifiable diseases',
        emoji: '🦠',
        colorTheme: 'orange',
        deltaText: '+18.3% MoM',
        progressVal: 0.55,
      ),
      DiseaseSurveillanceKpiCard(
        title: 'Vector-borne Cases',
        value: '${state.vectorCasesMtd}',
        subText: 'Dengue + Malaria + Scrub',
        emoji: '🦟',
        colorTheme: 'yellow',
        deltaText: '+34% vs last year',
        progressVal: 0.78,
      ),
      DiseaseSurveillanceKpiCard(
        title: 'Water-borne Cases',
        value: '${state.waterCasesMtd}',
        subText: 'Typhoid + Cholera + Hep A',
        emoji: '💧',
        colorTheme: 'teal',
        deltaText: '-12% vs last month',
        deltaUp: false,
        progressVal: 0.35,
      ),
      DiseaseSurveillanceKpiCard(
        title: 'Disease Deaths (MTD)',
        value: '${state.deathsMtd}',
        subText: 'Notifiable causes',
        emoji: '💀',
        colorTheme: 'purple',
        deltaText: '-3 vs last month',
        deltaUp: false,
        progressVal: 0.18,
      ),
      DiseaseSurveillanceKpiCard(
        title: 'RRTs Deployed',
        value: '${state.rrtDeployed}',
        subText: 'Active teams in field',
        emoji: '🛡️',
        colorTheme: 'blue',
        deltaText: '+4 from yesterday',
        progressVal: 0.87,
      ),
      DiseaseSurveillanceKpiCard(
        title: 'Vaccine Coverage',
        value: '${state.vaccinationCoverage}%',
        subText: 'Full immunisation target 90%',
        emoji: '💉',
        colorTheme: 'green',
        deltaText: '+1.3% vs target',
        deltaUp: false,
        progressVal: 0.95,
      ),
      DiseaseSurveillanceKpiCard(
        title: 'TB Active Cases',
        value: '${state.tbActiveCases}',
        subText: 'Under DOTS treatment',
        emoji: '🫁',
        colorTheme: 'red',
        deltaText: '-8.4% YoY',
        deltaUp: false,
        progressVal: 0.42,
      ),
      DiseaseSurveillanceKpiCard(
        title: 'ILI / ARI Cases',
        value: '${state.iliCasesMtd}',
        subText: 'Influenza-like illness reports',
        emoji: '💨',
        colorTheme: 'orange',
        deltaText: '+34% seasonal surge',
        progressVal: 0.68,
      ),
      DiseaseSurveillanceKpiCard(
        title: 'Case Fatality Rate',
        value: '${state.cfrRate}%',
        subText: 'State benchmark <0.5%',
        emoji: '📊',
        colorTheme: 'teal',
        deltaText: '-0.08% lower',
        deltaUp: false,
        progressVal: 0.31,
      ),
      DiseaseSurveillanceKpiCard(
        title: 'Samples Tested',
        value: '${state.samplesTestedMtd}',
        subText: 'Public health + sentinel labs',
        emoji: '🔬',
        colorTheme: 'yellow',
        deltaText: '+11% intensity',
        progressVal: 0.74,
      ),
      DiseaseSurveillanceKpiCard(
        title: 'Containments Active',
        value: '${state.containmentZonesActive}',
        subText: 'Micro-containment zones',
        emoji: '🚩',
        colorTheme: 'blue',
        deltaText: '+3 declared today',
        progressVal: 0.6,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cards.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, index) => cards[index],
        );
      },
    );
  }

  Widget _buildTwoColumnCharts() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final isMobile = w < 760;

        const ch1 = DengueWeeklyChart();
        const ch2 = MalariaSpeciesChart();

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
    );
  }

  Widget _buildHeatmapsSection() {
    final diseases = [
      'Dengue',
      'Malaria',
      'Typhoid',
      'TB',
      'ILI',
      'Scrub',
      'Hep',
      'Cholera',
    ];
    final districts = [
      'Dehradun',
      'Haridwar',
      'Nainital',
      'Almora',
      'Tehri',
      'Chamoli',
      'Pithoragarh',
    ];

    final cells = List.generate(
      districts.length,
      (di) => List.generate(
        diseases.length,
        (dsi) => (di == 1 && dsi == 0)
            ? 0.95
            : (di == 3 && dsi == 5
                  ? 0.88
                  : (0.2 + (di + dsi) * 0.08).clamp(0.1, 0.85)),
      ),
    );

    return DiseaseSurveillanceHeatmapPanel(
      title: 'District × Disease Burden Intensity Matrix',
      subtitle:
          'Heatmap case intensity per 1,00,000 population (IDSP Telemetry)',
      columns: diseases,
      rows: districts,
      cells: cells,
      colorRange: const [
        Color(0xFF0C1F34),
        Color(0xFFFFD166),
        Color(0xFFF59E0B),
        Color(0xFFEF4444),
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
            'ParaCare+ Uttarakhand — Disease Surveillance Command Dashboard',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
          ),
          Text(
            'IDSP · IHIP Connected — Active Outbreak Watch System',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _FlashingDot extends StatefulWidget {
  const _FlashingDot();

  @override
  State<_FlashingDot> createState() => _FlashingDotState();
}

class _FlashingDotState extends State<_FlashingDot> {
  double _opacity = 1;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (mounted) {
        setState(() {
          _opacity = _opacity == 1.0 ? 0.2 : 1.0;
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
      duration: const Duration(milliseconds: 500),
      child: Container(
        width: 7,
        height: 7,
        decoration: const BoxDecoration(
          color: AppColors.error,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
