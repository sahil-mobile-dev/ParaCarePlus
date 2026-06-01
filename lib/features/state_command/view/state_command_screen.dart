import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_sidebar.dart';
import 'package:paracareplus/features/state_command/view/widgets/state_command_alert_panel.dart';
import 'package:paracareplus/features/state_command/view/widgets/state_command_chart_panel.dart';
import 'package:paracareplus/features/state_command/view/widgets/state_command_district_table.dart';
import 'package:paracareplus/features/state_command/view/widgets/state_command_kpi_card.dart';
import 'package:paracareplus/features/state_command/view/widgets/state_command_sunburst_panel.dart';
import 'package:paracareplus/features/state_command/view/widgets/state_command_ticker.dart';
import 'package:paracareplus/features/state_command/view_model/state_command_view_model.dart';
import 'package:paracareplus/routes/route_names.dart';

class StateCommandScreen extends ConsumerStatefulWidget {
  const StateCommandScreen({super.key});

  @override
  ConsumerState<StateCommandScreen> createState() => _StateCommandScreenState();
}

class _StateCommandScreenState extends ConsumerState<StateCommandScreen> {
  late final Timer _clockTimer;
  String _timeString = '';
  String? _selectedGisDistrict;

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
        _timeString = '⏱ $hour:$min:$sec $amPm';
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
          'Generating comprehensive Executive State Health Intelligence Report PDF for NHM & Health Secretary Office. This document incorporates 36 core KPIs, AI-forecast models, GIS maps, and active surveillance alerts.',
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
                    'State Health Intelligence Report downloaded successfully.',
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
    final commandState = ref.watch(stateCommandProvider);

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
                  const StateCommandTicker(),
                  Expanded(
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFilterBar(context, commandState),
                              const SizedBox(height: AppSpacing.lg),
                              _buildKpiSections(commandState),
                              const SizedBox(height: AppSpacing.xl),
                              _buildAiSnapshotPanel(),
                              const SizedBox(height: AppSpacing.xl),
                              _buildChartsSection(),
                              const SizedBox(height: AppSpacing.xl),
                              _buildSunburstSection(),
                              const SizedBox(height: AppSpacing.xl),
                              _buildGisMapSection(),
                              const SizedBox(height: AppSpacing.xl),
                              const StateCommandDistrictTable(),
                              const SizedBox(height: AppSpacing.xl),
                              _buildAlertsSection(commandState),
                              const SizedBox(height: AppSpacing.xxl),
                              _buildFooter(),
                            ],
                          ),
                        ),
                        if (commandState.isRefreshing)
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
                                    'Syncing State Health Intelligence Telemetry...',
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

  // --- TOPBAR ---
  Widget _buildTopbar(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 760;

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primaryLight, Color(0xFF00897B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(9),
            ),
            alignment: Alignment.center,
            child: const Text('🎯', style: TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Executive State Health Command Center',
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: isMobile ? 12 : 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'ParaCare+ HIMS v3.1 — Uttarakhand State Health Intelligence',
                  style: TextStyle(
                    fontSize: isMobile ? 8.5 : 10,
                    color: Colors.white54,
                    fontFamily: AppTextStyles.fontFamily,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (!isMobile) ...[
            _buildHeaderBadge(const Color(0xFF4CAF50), '🟢 Live Data'),
            const SizedBox(width: 8),
            _buildHeaderBadge(const Color(0xFF1565C0), '🏛️ 1,847 Facilities'),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                _timeString,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
          IconButton(
            icon: const Icon(Icons.grid_view, color: Colors.white70, size: 20),
            tooltip: 'All Dashboards',
            onPressed: () => context.pushNamed(RouteNames.dashboardHub),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBadge(Color col, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: col.withValues(alpha: 0.1),
        border: Border.all(color: col.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: col.withValues(alpha: 0.9),
          fontSize: 10,
          fontWeight: FontWeight.bold,
          fontFamily: AppTextStyles.fontFamily,
        ),
      ),
    );
  }

  // --- FILTER BAR ---
  Widget _buildFilterBar(BuildContext context, StateCommandState state) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 760;

    const dropdownStyle = TextStyle(
      fontSize: 11,
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontFamily: AppTextStyles.fontFamily,
    );

    Widget buildDropdownCard({
      required String value,
      required List<String> items,
      required ValueChanged<String?> onChanged,
    }) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        height: 36,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            dropdownColor: AppColors.surface,
            style: dropdownStyle,
            items: items
                .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      );
    }

    final barContent = [
      const Text(
        'FILTERS:',
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          color: AppColors.secondaryText,
          letterSpacing: 0.5,
        ),
      ),
      const SizedBox(width: 8),
      buildDropdownCard(
        value: state.selectedDistrict,
        items: [
          'All Districts',
          'Dehradun',
          'Haridwar',
          'Nainital',
          'Almora',
          'Pithoragarh',
          'Uttarkashi',
          'Chamoli',
          'Rudraprayag',
          'Tehri',
          'Champawat',
          'Bageshwar',
          'Rishikesh',
        ],
        onChanged: (val) {
          if (val != null) {
            ref.read(stateCommandProvider.notifier).changeDistrict(val);
          }
        },
      ),
      const SizedBox(width: 6),
      buildDropdownCard(
        value: state.selectedFacilityType,
        items: [
          'All Facility Types',
          'Medical College',
          'District Hospital',
          'CHC',
          'PHC',
          'Sub-Centre',
          'Private Empanelled',
        ],
        onChanged: (val) {
          if (val != null) {
            ref.read(stateCommandProvider.notifier).changeFacilityType(val);
          }
        },
      ),
      const SizedBox(width: 6),
      buildDropdownCard(
        value: state.selectedTimePeriod,
        items: [
          'This Month — May 2025',
          'April 2025',
          'Q1 2025',
          'FY 2024-25',
          'Last 7 Days',
          'Today',
        ],
        onChanged: (val) {
          if (val != null) {
            ref.read(stateCommandProvider.notifier).changeTimePeriod(val);
          }
        },
      ),
      const SizedBox(width: 6),
      buildDropdownCard(
        value: state.selectedScheme,
        items: [
          'All Schemes',
          'Ayushman Bharat',
          'CGHS',
          'ESI',
          'State Health Scheme',
          'General / OPD',
        ],
        onChanged: (val) {
          if (val != null) {
            ref.read(stateCommandProvider.notifier).changeScheme(val);
          }
        },
      ),
      if (!isMobile) ...[
        const Spacer(),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          ),
          icon: const Icon(Icons.sync, size: 14),
          label: const Text(
            'Refresh',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
          onPressed: () => ref.read(stateCommandProvider.notifier).refresh(),
        ),
        const SizedBox(width: 6),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00695C),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          ),
          icon: const Icon(Icons.download, size: 14),
          label: const Text(
            'Export',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _showExportDialog(context),
        ),
      ],
    ];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
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
                  children: barContent.take(10).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      icon: const Icon(Icons.sync, size: 13),
                      label: const Text(
                        'Refresh',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () =>
                          ref.read(stateCommandProvider.notifier).refresh(),
                    ),
                    const SizedBox(width: 6),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00695C),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      icon: const Icon(Icons.download, size: 13),
                      label: const Text(
                        'Export',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () => _showExportDialog(context),
                    ),
                  ],
                ),
              ],
            )
          : Row(children: barContent),
    );
  }

  // --- KPI SECTION GRID ---
  Widget _buildKpiGrid({
    required List<StateCommandKpiCard> cards,
    int columns = 6,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final cols = w < 500 ? 2 : (w < 850 ? 3 : columns);
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cards.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.6,
          ),
          itemBuilder: (context, index) => cards[index],
        );
      },
    );
  }

  Widget _buildKpiSections(StateCommandState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Patient & Facility
        _buildSectionTitle('🏥', 'Patient & Facility Metrics'),
        _buildKpiGrid(
          cards: [
            const StateCommandKpiCard(
              title: 'Registered Patients',
              value: '48.2L',
              subText: '↑ 12% this month',
              emoji: '👤',
              colorTheme: 'blue',
              trendUp: true,
            ),
            const StateCommandKpiCard(
              title: 'ABHA Linked Patients',
              value: '31.7L',
              subText: '65.8% coverage',
              emoji: '🔗',
              colorTheme: 'teal',
            ),
            const StateCommandKpiCard(
              title: 'ABDM Consent Success',
              value: '94.3%',
              subText: '↑ 2.1% this week',
              emoji: '✅',
              colorTheme: 'green',
              trendUp: true,
            ),
            const StateCommandKpiCard(
              title: 'Active Hospitals',
              value: '247',
              subText: 'Dist. + Med Colleges',
              emoji: '🏥',
              colorTheme: 'gold',
            ),
            const StateCommandKpiCard(
              title: 'Active PHC / CHC',
              value: '1,600',
              subText: '1,847 total facilities',
              emoji: '🏘️',
              colorTheme: 'purple',
            ),
            StateCommandKpiCard(
              title: 'Daily OPD Count',
              value: state.liveOpdCount.toString().replaceAllMapped(
                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                (m) => '${m[1]},',
              ),
              subText: '↑ 5.2% vs yesterday',
              emoji: '🩺',
              colorTheme: 'blue',
              trendUp: true,
            ),
          ],
        ),
        const SizedBox(height: 18),

        // Clinical Ops
        _buildSectionTitle('🛏️', 'Clinical Operations'),
        _buildKpiGrid(
          cards: [
            const StateCommandKpiCard(
              title: 'Daily IPD Admissions',
              value: '3,241',
              subText: '↓ 1.3% reduction',
              emoji: '🛏️',
              colorTheme: 'teal',
              trendUp: false,
            ),
            const StateCommandKpiCard(
              title: 'Bed Occupancy %',
              value: '87.4%',
              subText: '⚠ Critical zones: 3',
              emoji: '📊',
              colorTheme: 'red',
              trendUp: false,
            ),
            const StateCommandKpiCard(
              title: 'ICU Occupancy %',
              value: '91.2%',
              subText: '⚠ Near capacity',
              emoji: '🆘',
              colorTheme: 'red',
              trendUp: false,
            ),
            const StateCommandKpiCard(
              title: 'Ventilator Util',
              value: '68.7%',
              subText: 'State avg workload',
              emoji: '💨',
              colorTheme: 'purple',
            ),
            const StateCommandKpiCard(
              title: 'Emergency Caseload',
              value: '1,847',
              subText: 'Today across state',
              emoji: '🚨',
              colorTheme: 'gold',
            ),
            const StateCommandKpiCard(
              title: 'Avg Wait Time',
              value: '22 min',
              subText: '↓ 4 min improvement',
              emoji: '⏱',
              colorTheme: 'pink',
              trendUp: true,
            ),
          ],
        ),
        const SizedBox(height: 18),

        // Maternal Child Disease
        _buildSectionTitle('🤰', 'Maternal, Child & Disease'),
        _buildKpiGrid(
          columns: 4,
          cards: [
            const StateCommandKpiCard(
              title: 'MMR (per 1L births)',
              value: '89',
              subText: '↓ 7 pts vs last yr',
              emoji: '🤰',
              colorTheme: 'pink',
              trendUp: true,
            ),
            const StateCommandKpiCard(
              title: 'IMR (per 1K births)',
              value: '28',
              subText: '↓ 2 pts reduction',
              emoji: '👶',
              colorTheme: 'teal',
              trendUp: true,
            ),
            const StateCommandKpiCard(
              title: 'Outbreak Alerts',
              value: '7',
              subText: '3 critical alerts active',
              emoji: '🦠',
              colorTheme: 'red',
              trendUp: false,
            ),
            const StateCommandKpiCard(
              title: 'High-Risk Pregnancies',
              value: '1,423',
              subText: 'Active flagged cases',
              emoji: '🤰',
              colorTheme: 'gold',
            ),
            const StateCommandKpiCard(
              title: 'Telemedicine Consults',
              value: '1,247',
              subText: 'Record high usage',
              emoji: '📹',
              colorTheme: 'blue',
            ),
            const StateCommandKpiCard(
              title: 'Medicine Availability',
              value: '91.3%',
              subText: '7 CHC acute shortage',
              emoji: '💊',
              colorTheme: 'green',
            ),
            const StateCommandKpiCard(
              title: 'Readmission Rate',
              value: '4.8%',
              subText: '30-day readmissions',
              emoji: '🔁',
              colorTheme: 'purple',
            ),
            const StateCommandKpiCard(
              title: 'Digital Prescription',
              value: '78.4%',
              subText: '↑ 5.2% compliance',
              emoji: '📡',
              colorTheme: 'cyan',
              trendUp: true,
            ),
          ],
        ),
        const SizedBox(height: 18),

        // Finance AB
        _buildSectionTitle('💰', 'Finance, Claims & Performance'),
        _buildKpiGrid(
          cards: [
            const StateCommandKpiCard(
              title: 'Avg Claim Settlement',
              value: '4.2 days',
              subText: '↓ 0.8 days latency',
              emoji: '💵',
              colorTheme: 'green',
              trendUp: true,
            ),
            const StateCommandKpiCard(
              title: 'ePrescr Compliance',
              value: '82.1%',
              subText: '↑ 3.4% adoption',
              emoji: '📡',
              colorTheme: 'blue',
              trendUp: true,
            ),
            const StateCommandKpiCard(
              title: 'Doctor Prod Index',
              value: '7.8',
              subText: 'Scale of 10 average',
              emoji: '🩺',
              colorTheme: 'teal',
            ),
            const StateCommandKpiCard(
              title: 'Patient Satisfaction',
              value: '4.3 / 5',
              subText: '↑ 0.2 increase',
              emoji: '⭐',
              colorTheme: 'gold',
              trendUp: true,
            ),
            const StateCommandKpiCard(
              title: 'Ambulance Response',
              value: '17 min',
              subText: 'State average urban',
              emoji: '🚑',
              colorTheme: 'green',
            ),
            const StateCommandKpiCard(
              title: 'Referral Success',
              value: '96.8%',
              subText: 'Within SLA margins',
              emoji: '🔀',
              colorTheme: 'purple',
            ),
          ],
        ),
        const SizedBox(height: 18),

        // AI predicted
        _buildSectionTitle('🤖', 'AI-Predicted Health Intelligence'),
        _buildKpiGrid(
          columns: 4,
          cards: [
            const StateCommandKpiCard(
              title: 'Predicted Outbreak Risk',
              value: '7.4/10',
              subText: 'High — Nainital & Pithoragarh',
              emoji: '🔮',
              colorTheme: 'purple',
              isAi: true,
            ),
            const StateCommandKpiCard(
              title: 'Predicted Bed Need (+7d)',
              value: '+412',
              subText: 'Extra beds requirement',
              emoji: '🛏',
              colorTheme: 'purple',
              isAi: true,
            ),
            const StateCommandKpiCard(
              title: 'High-Risk Patients',
              value: '3,847',
              subText: 'Flagged by ML model today',
              emoji: '👤',
              colorTheme: 'purple',
              isAi: true,
            ),
            const StateCommandKpiCard(
              title: 'Infra Utilization Index',
              value: '0.82',
              subText: 'Strain predicted in 4 dist.',
              emoji: '📈',
              colorTheme: 'purple',
              isAi: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String emoji, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 15)),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: AppColors.secondaryText,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(child: Divider(color: Color(0x15FFFFFF), height: 1)),
        ],
      ),
    );
  }

  // --- AI SNAPSHOT PANEL ---
  Widget _buildAiSnapshotPanel() {
    final aiKpis = [
      {'val': '7.4/10', 'label': 'Outbreak Risk', 'risk': '🔴 HIGH'},
      {'val': '+412', 'label': 'Bed Demand +7d', 'risk': '🟡 WATCH'},
      {'val': '18.3%', 'label': 'Readmission Risk', 'risk': '🟡 MODERATE'},
      {'val': '₹4.7Cr', 'label': 'AI Fraud Flagged', 'risk': '🔴 REVIEW'},
      {'val': '23', 'label': 'Shortage Pred.', 'risk': '🔴 7 DAYS'},
      {'val': '94.2%', 'label': 'Mortality Acc.', 'risk': '🟢 MODEL OK'},
      {'val': '3,847', 'label': 'High-Risk Patients', 'risk': '🟡 FLAGGED'},
      {'val': '91%', 'label': 'Referral Optim.', 'risk': '🟢 GOOD'},
    ];

    Color getRiskColor(String risk) {
      if (risk.contains('HIGH') ||
          risk.contains('REVIEW') ||
          risk.contains('7 DAYS')) {
        return AppColors.error;
      }
      if (risk.contains('WATCH') ||
          risk.contains('MODERATE') ||
          risk.contains('FLAGGED')) {
        return AppColors.secondaryAccent;
      }
      return AppColors.success;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4A148C).withValues(alpha: 0.25),
            const Color(0xFF311B92).withValues(alpha: 0.15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF673AB7).withValues(alpha: 0.35),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.psychology, color: Color(0xFFCE93D8), size: 20),
              const SizedBox(width: 8),
              Text(
                'AI Predictive Healthcare Intelligence — Live Snapshot',
                style: AppTextStyles.labelLarge.copyWith(
                  color: const Color(0xFFCE93D8),
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final cols = w < 480 ? 2 : (w < 850 ? 4 : 8);
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: aiKpis.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  final kpi = aiKpis[index];
                  final riskCol = getRiskColor(kpi['risk']!);

                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF673AB7).withValues(alpha: 0.12),
                      border: Border.all(
                        color: const Color(0xFF673AB7).withValues(alpha: 0.2),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          kpi['val']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFE1BEE7),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          kpi['label']!.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 7.5,
                            color: Colors.white38,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          kpi['risk']!,
                          style: TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w800,
                            color: riskCol,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // --- CHARTS SECTION ---
  Widget _buildChartsSection() {
    final districts = [
      'D.Dun',
      'H.war',
      'N.tal',
      'Alm',
      'Pith',
      'U.shi',
      'Cham',
      'R.prg',
      'Teh',
      'Pau',
      'Bag',
      'Cham',
      'Rish',
    ];
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final cols = w < 850 ? 1 : 2;

        return Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: cols,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                StateCommandChartPanel(
                  title: '📅 OPD Trend — 30 Days',
                  badgeText: 'Daily',
                  child: CustomLineChart(
                    values: const [
                      12400,
                      13800,
                      12900,
                      14200,
                      13500,
                      15100,
                      14600,
                      13900,
                      14823,
                      14000,
                      15300,
                      14500,
                      15900,
                      13100,
                      14800,
                      13800,
                      14600,
                    ],
                    labels: const ['1 May', '10 May', '20 May', '30 May'],
                    lineColor: const Color(0xFF42A5F5),
                    fillColor: const Color(0xFF42A5F5).withValues(alpha: 0.12),
                    targetValue: 14000,
                  ),
                ),
                StateCommandChartPanel(
                  title: '🛏️ Bed Occupancy by District',
                  badgeText: 'Live',
                  child: CustomBarChart(
                    values: const [
                      92,
                      98,
                      88,
                      82,
                      79,
                      71,
                      74,
                      68,
                      85,
                      80,
                      73,
                      75,
                      87,
                    ],
                    labels: districts,
                    suffix: '%',
                  ),
                ),
                StateCommandChartPanel(
                  title: '💰 Revenue vs AB Claims — Monthly',
                  badgeText: 'FY25',
                  child: CustomBarChart(
                    values: const [
                      14,
                      15,
                      13,
                      16,
                      18,
                      17,
                      19,
                      18,
                      20,
                      19,
                      21,
                      22,
                    ],
                    labels: months,
                    suffix: 'Cr',
                    barColor: AppColors.success,
                  ),
                ),
                const StateCommandChartPanel(
                  title: '👥 Role-wise Staff Status: Total vs Available Today',
                  badgeText: 'Live Status',
                  child: StaffDistributionWidget(),
                ),
                const StateCommandChartPanel(
                  title: '🦠 Disease Burden — Top Categories',
                  badgeText: 'This Month',
                  child: DiseaseBurdenWidget(),
                ),
                StateCommandChartPanel(
                  title: '📡 Telemedicine & Digital Health Adoption',
                  badgeText: 'FY25 Trend',
                  child: CustomLineChart(
                    values: const [
                      420,
                      480,
                      510,
                      580,
                      640,
                      720,
                      810,
                      890,
                      940,
                      1050,
                      1140,
                      1247,
                    ],
                    labels: months,
                    lineColor: const Color(0xFF4DB6AC),
                    fillColor: const Color(0xFF4DB6AC).withValues(alpha: 0.08),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // --- SUNBURST DRILL-DOWN PANEL ROW ---
  Widget _buildSunburstSection() {
    final sb1 = {
      'name': 'Uttarakhand',
      'children': [
        {
          'name': 'Dehradun',
          'children': [
            {
              'name': 'Dist. Hosp.',
              'children': [
                {
                  'name': 'Gen. Med.',
                  'children': [
                    {'name': 'OPD Unit', 'value': 180},
                    {'name': 'IPD Unit', 'value': 120},
                  ],
                },
                {
                  'name': 'Surgery',
                  'children': [
                    {'name': 'OT Unit', 'value': 90},
                    {'name': 'ICU', 'value': 60},
                  ],
                },
              ],
            },
          ],
        },
        {
          'name': 'Haridwar',
          'children': [
            {
              'name': 'Dist. Hosp.',
              'children': [
                {
                  'name': 'Emergency',
                  'children': [
                    {'name': 'Trauma', 'value': 100},
                    {'name': 'Resus', 'value': 60},
                  ],
                },
              ],
            },
          ],
        },
      ],
    };

    final sb3 = {
      'name': 'Health Budget',
      'children': [
        {
          'name': 'NHM',
          'children': [
            {'name': 'RCH', 'value': 320},
            {'name': 'IDSP', 'value': 180},
            {'name': 'Immunise', 'value': 220},
          ],
        },
        {
          'name': 'PMJAY/AB',
          'children': [
            {'name': 'Hospitalise', 'value': 480},
            {'name': 'Day Care', 'value': 120},
          ],
        },
        {
          'name': 'State Budget',
          'children': [
            {'name': 'Salaries', 'value': 620},
            {'name': 'Medicines', 'value': 280},
          ],
        },
      ],
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final cols = w < 850 ? 1 : 2;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('🌀', 'Sunburst Drill-Down Analytics'),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: cols,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: w < 850 ? 2.0 : 1.7,
              children: [
                StateCommandSunburstPanel(
                  title: '🏘️ District ➔ Hospital ➔ Department ➔ Doctor',
                  hierarchyData: sb1,
                ),
                StateCommandSunburstPanel(
                  title: '💰 Health Budget Allocation — Sunburst Drill',
                  hierarchyData: sb3,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // --- GIS MAP SECTION ---
  Widget _buildGisMapSection() {
    final districtsGis = [
      {
        'name': 'Dehradun',
        'x': 0.22,
        'y': 0.32,
        'opd': '4,200',
        'bed': '92%',
        'alert': 'HIGH',
        'color': AppColors.secondaryAccent,
      },
      {
        'name': 'Haridwar',
        'x': 0.26,
        'y': 0.52,
        'opd': '3,100',
        'bed': '98%',
        'alert': 'CRITICAL',
        'color': AppColors.error,
      },
      {
        'name': 'Nainital',
        'x': 0.65,
        'y': 0.72,
        'opd': '1,800',
        'bed': '88%',
        'alert': 'HIGH',
        'color': AppColors.secondaryAccent,
      },
      {
        'name': 'Almora',
        'x': 0.68,
        'y': 0.58,
        'opd': '1,200',
        'bed': '82%',
        'alert': 'MEDIUM',
        'color': AppColors.secondaryAccent,
      },
      {
        'name': 'Pithoragarh',
        'x': 0.85,
        'y': 0.45,
        'opd': '900',
        'bed': '79%',
        'alert': 'HIGH',
        'color': AppColors.secondaryAccent,
      },
      {
        'name': 'Uttarkashi',
        'x': 0.32,
        'y': 0.14,
        'opd': '720',
        'bed': '71%',
        'alert': 'MEDIUM',
        'color': AppColors.secondaryAccent,
      },
      {
        'name': 'Chamoli',
        'x': 0.55,
        'y': 0.28,
        'opd': '680',
        'bed': '74%',
        'alert': 'MEDIUM',
        'color': AppColors.secondaryAccent,
      },
      {
        'name': 'Rudraprayag',
        'x': 0.44,
        'y': 0.34,
        'opd': '480',
        'bed': '68%',
        'alert': 'LOW',
        'color': AppColors.success,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('🗺️', 'Uttarakhand State Health GIS Map'),
        Container(
          height: 380,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Grid background mimicking digital map layout
              Positioned.fill(child: CustomPaint(painter: _GisGridPainter())),
              // State Map outline drawing placeholder (high-quality look)
              const Center(
                child: Opacity(
                  opacity: 0.1,
                  child: Text(
                    'UTTARAKHAND GIS TELEMETRY',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              // Interactive Hotspot Dots
              ...districtsGis.map((d) {
                final x = (d['x'] as num?)?.toDouble() ?? 0.0;
                final y = (d['y'] as num?)?.toDouble() ?? 0.0;
                final col = (d['color'] as Color?) ?? Colors.blue;

                return Positioned(
                  left: x * MediaQuery.of(context).size.width * 0.6,
                  top: y * 340,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedGisDistrict = d['name']?.toString();
                      });
                    },
                    child: Tooltip(
                      message: 'View telemetry for ${d['name']}',
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Ripple animation simulated by static ring
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: col.withValues(alpha: 0.2),
                            ),
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: col,
                              boxShadow: [
                                BoxShadow(
                                  color: col.withValues(alpha: 0.6),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              // Label Tags over map
              ...districtsGis.map((d) {
                final x = (d['x'] as num?)?.toDouble() ?? 0.0;
                final y = (d['y'] as num?)?.toDouble() ?? 0.0;

                return Positioned(
                  left: (x * MediaQuery.of(context).size.width * 0.6) + 16,
                  top: (y * 340) - 4,
                  child: Text(
                    d['name']?.toString() ?? '',
                    style: const TextStyle(
                      fontSize: 8.5,
                      fontWeight: FontWeight.w800,
                      color: Colors.white54,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              // Popup Telemetry overlay card
              if (_selectedGisDistrict != null) ...[
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    width: 220,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.primaryLight.withValues(alpha: 0.5),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedGisDistrict!,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                size: 14,
                                color: Colors.white60,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () =>
                                  setState(() => _selectedGisDistrict = null),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.white12, height: 12),
                        if (_selectedGisDistrict != null) ...[
                          (() {
                            final matchedGis = districtsGis.firstWhere(
                              (x) => x['name'] == _selectedGisDistrict,
                              orElse: () => <String, Object>{},
                            );
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildGisRow(
                                  'Daily OPD',
                                  matchedGis['opd']?.toString() ?? '',
                                ),
                                _buildGisRow(
                                  'Bed Occupancy',
                                  matchedGis['bed']?.toString() ?? '',
                                ),
                                _buildGisRow(
                                  'Alert Level',
                                  matchedGis['alert']?.toString() ?? '',
                                  valColor: matchedGis['color'] as Color?,
                                ),
                              ],
                            );
                          })(),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGisRow(String title, String val, {Color? valColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 10.5,
              color: AppColors.secondaryText,
            ),
          ),
          Text(
            val,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              color: valColor ?? Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // --- ALERTS COLUMN CARD SECTION ---
  Widget _buildAlertsSection(StateCommandState state) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth < 850 ? 1 : 2;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('🚨', 'Active Alerts & Notifications'),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: cols,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.9,
              children: [
                StateCommandAlertPanel(
                  title: '🔴 Critical & High-Priority Alerts',
                  badgeText: '${state.criticalAlerts.length} Active',
                  badgeColor: AppColors.error,
                  alerts: state.criticalAlerts,
                ),
                StateCommandAlertPanel(
                  title: '🟡 Watch & Informational Alerts',
                  badgeText: '${state.watchAlerts.length} Watch',
                  badgeColor: AppColors.secondaryAccent,
                  alerts: state.watchAlerts,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // --- FOOTER ---
  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: Colors.black.withValues(alpha: 0.15),
      padding: const EdgeInsets.all(16),
      child: const Column(
        children: [
          Text(
            'Executive State Health Command Center  |  ParaCare+ v5.0',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: Colors.white60,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '© 2026 Government of Uttarakhand. Secure AES-256 ABDM Compliant Node.',
            style: TextStyle(
              fontSize: 10,
              color: Colors.white24,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}

// --- GIS CANVAS GRID DRAWING ---
class _GisGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..strokeWidth = 1.0;

    // Draw vertical grid lines
    for (var x = 20.0; x < size.width; x += 30.0) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    // Draw horizontal grid lines
    for (var y = 20.0; y < size.height; y += 30.0) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GisGridPainter oldDelegate) => false;
}
