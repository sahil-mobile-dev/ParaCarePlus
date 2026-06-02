import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/abdm_compliance/view/widgets/abdm_alert_panel.dart';
import 'package:paracareplus/features/abdm_compliance/view/widgets/abdm_chart_panel.dart';
import 'package:paracareplus/features/abdm_compliance/view/widgets/abdm_compliance_matrix.dart';
import 'package:paracareplus/features/abdm_compliance/view/widgets/abdm_district_table.dart';
import 'package:paracareplus/features/abdm_compliance/view/widgets/abdm_fhir_health_panel.dart';
import 'package:paracareplus/features/abdm_compliance/view/widgets/abdm_integration_funnel.dart';
import 'package:paracareplus/features/abdm_compliance/view/widgets/abdm_kpi_card.dart';
import 'package:paracareplus/features/abdm_compliance/view/widgets/abdm_standards_panel.dart';
import 'package:paracareplus/features/abdm_compliance/view/widgets/abdm_ticker.dart';
import 'package:paracareplus/features/abdm_compliance/view_model/abdm_compliance_view_model.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_sidebar.dart';
import 'package:paracareplus/routes/route_names.dart';

class AbdmComplianceScreen extends ConsumerStatefulWidget {
  const AbdmComplianceScreen({super.key});

  @override
  ConsumerState<AbdmComplianceScreen> createState() =>
      _AbdmComplianceScreenState();
}

class _AbdmComplianceScreenState extends ConsumerState<AbdmComplianceScreen> {
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
        _timeString = '⏱ $hour:$min:$sec $amPm';
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
    final abdmState = ref.watch(abdmComplianceProvider);

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
                  const AbdmTicker(),
                  Expanded(
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFilterBar(context, abdmState),
                              const SizedBox(height: AppSpacing.lg),
                              _buildSectionHeader(
                                'ABHA Generation & Coverage',
                                'Live',
                              ),
                              const SizedBox(height: AppSpacing.md),
                              _buildAbhaKpiGrid(context, abdmState),
                              const SizedBox(height: AppSpacing.xl),
                              _buildSectionHeader(
                                'ABDM Ecosystem Metrics',
                                'Real-time',
                              ),
                              const SizedBox(height: AppSpacing.md),
                              _buildEcosystemKpiGrid(context, abdmState),
                              const SizedBox(height: AppSpacing.xl),
                              _buildSectionHeader(
                                'API Performance & Integration Health',
                                'Live Monitor',
                              ),
                              const SizedBox(height: AppSpacing.md),
                              _buildApiKpiGrid(context, abdmState),
                              const SizedBox(height: AppSpacing.xl),
                              _buildSectionHeader(
                                'Ecosystem Analytics & Trends',
                                'Visual Intelligence',
                              ),
                              const SizedBox(height: AppSpacing.md),
                              const AbdmChartPanel(),
                              const SizedBox(height: AppSpacing.xl),
                              const AbdmFhirHealthPanel(),
                              const SizedBox(height: AppSpacing.xl),
                              const AbdmIntegrationFunnel(),
                              const SizedBox(height: AppSpacing.xl),
                              const AbdmComplianceMatrix(),
                              const SizedBox(height: AppSpacing.xl),
                              const AbdmStandardsPanel(),
                              const SizedBox(height: AppSpacing.xl),
                              const AbdmDistrictTable(),
                              const SizedBox(height: AppSpacing.xl),
                              const AbdmAlertPanel(),
                              const SizedBox(height: AppSpacing.xxl),
                              _buildFooter(),
                            ],
                          ),
                        ),
                        if (abdmState.isRefreshing)
                          ColoredBox(
                            color: Colors.black.withValues(alpha: 0.6),
                            child: const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(
                                    color: Color(0xFF00B4D8),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Syncing ABDM Telemetry & NHA Registry...',
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
          // Hub back button
          TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0x2600B4D8),
              foregroundColor: const Color(0xFF00B4D8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            ),
            onPressed: () => context.pushNamed(RouteNames.dashboardHub),
            icon: const Icon(Icons.arrow_back_rounded, size: 14),
            label: const Text(
              'Hub',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Row(
              children: [
                const Text('🔗', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'ABDM Compliance Dashboard',
                              style: AppTextStyles.labelLarge.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: isMobile ? 12 : 15,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (!isMobile) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF1A6B9A),
                                    Color(0xFF0D9488),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'ABDM · ABHA · FHIR R4',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        'ParaCare+ HIMS v3.2 — Uttarakhand Digital Health Mission Status',
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
              ],
            ),
          ),
          // Live Clock, Sync indicator and button
          if (!isMobile) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0x1F00C897),
                border: Border.all(color: const Color(0x4D00C897)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  BoxShapeDot(color: Color(0xFF00C897)),
                  SizedBox(width: 6),
                  Text(
                    'LIVE SYNC',
                    style: TextStyle(
                      color: Color(0xFF00C897),
                      fontSize: 9.5,
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
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 12),
          ],
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: const Color(0x2600B4D8),
              foregroundColor: const Color(0xFF00B4D8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () =>
                ref.read(abdmComplianceProvider.notifier).refresh(),
            icon: const Icon(Icons.refresh_rounded, size: 16),
          ),
        ],
      ),
    );
  }

  // --- FILTER BAR ---
  Widget _buildFilterBar(BuildContext context, AbdmComplianceState abdmState) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 760;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
      ),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.filter_list_rounded,
                color: AppColors.secondaryText,
                size: 14,
              ),
              SizedBox(width: 6),
              Text(
                'FILTERS',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryText,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          // District filter
          _buildFilterDropdown(
            currentValue: abdmState.selectedDistrict,
            items: [
              'All Districts',
              'Dehradun',
              'Haridwar',
              'Nainital',
              'Udham Singh Nagar',
              'Almora',
            ],
            onChanged: (val) {
              if (val != null) {
                ref.read(abdmComplianceProvider.notifier).changeDistrict(val);
              }
            },
          ),
          // Facility filter
          _buildFilterDropdown(
            currentValue: abdmState.selectedFacilityType,
            items: [
              'All Facility Types',
              'District Hospital',
              'CHC',
              'PHC',
              'Medical College',
            ],
            onChanged: (val) {
              if (val != null) {
                ref
                    .read(abdmComplianceProvider.notifier)
                    .changeFacilityType(val);
              }
            },
          ),
          // Timeline filter
          _buildFilterDropdown(
            currentValue: abdmState.selectedTimePeriod,
            items: [
              'Last 30 Days',
              'Last 7 Days',
              'Last 90 Days',
              'FY 2024-25',
            ],
            onChanged: (val) {
              if (val != null) {
                ref.read(abdmComplianceProvider.notifier).changeTimePeriod(val);
              }
            },
          ),
          // Module filter
          _buildFilterDropdown(
            currentValue: abdmState.selectedModule,
            items: [
              'All ABDM Modules',
              'ABHA Generation',
              'Consent Manager',
              'Health Locker',
              'HIP / HIU',
              'ePrescription',
            ],
            onChanged: (val) {
              if (val != null) {
                ref.read(abdmComplianceProvider.notifier).changeModule(val);
              }
            },
          ),
          // Apply button
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A6B9A),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            ),
            onPressed: () =>
                ref.read(abdmComplianceProvider.notifier).refresh(),
            icon: const Icon(Icons.search_rounded, size: 14),
            label: const Text(
              'Apply',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          // Right stats indicators on desktop
          if (!isMobile) ...[
            const SizedBox(width: 10),
            _buildStatusTag('Gateway Online', const Color(0xFF00C897)),
            _buildStatusTag('3 Warnings', const Color(0xFFFFD166)),
            _buildStatusTag('1 Critical', const Color(0xFFFF4D6D)),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterDropdown({
    required String currentValue,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFF112440),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentValue,
          dropdownColor: AppColors.surface,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.secondaryText,
            size: 16,
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            fontFamily: AppTextStyles.fontFamily,
          ),
          items: items.map((val) {
            return DropdownMenuItem<String>(value: val, child: Text(val));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildStatusTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // --- SECTION HEADER ---
  Widget _buildSectionHeader(String title, String badge) {
    return Row(
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: AppColors.secondaryText,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0x3DFFFFFF), Colors.transparent],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0x2600B4D8),
            border: Border.all(color: const Color(0x4D00B4D8)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            badge,
            style: const TextStyle(
              color: Color(0xFF00B4D8),
              fontSize: 8.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // --- KPI GRIDS ---
  Widget _buildAbhaKpiGrid(
    BuildContext context,
    AbdmComplianceState abdmState,
  ) {
    final children = [
      AbdmKpiCard(
        title: 'Total ABHA Generated',
        value: '${abdmState.abhaMetrics.totalGenerated.toStringAsFixed(1)}L',
        subText: '+12,340 today',
        emoji: '📇',
        colorTheme: 'abdm',
        progressPercent: 0.77,
        trendUp: true,
      ),
      AbdmKpiCard(
        title: 'ABHA Linked EMRs',
        value: '${abdmState.abhaMetrics.linkedEmr.toStringAsFixed(1)}L',
        subText: '62.5% of ABHA holders',
        emoji: '🔗',
        colorTheme: 'green',
        progressPercent: 0.62,
        trendUp: true,
      ),
      AbdmKpiCard(
        title: 'Digital Health ID Coverage',
        value:
            '${abdmState.abhaMetrics.digitalHealthIdCoverage.toStringAsFixed(1)}%',
        subText: '+1.2% MoM',
        emoji: '👥',
        colorTheme: 'accent',
        progressPercent: 0.73,
        trendUp: true,
      ),
      AbdmKpiCard(
        title: 'Scan & Share OPD Adoption',
        value:
            '${abdmState.abhaMetrics.scanAndShareOpdAdoption.toStringAsFixed(1)}%',
        subText: '+4.3% last month',
        emoji: '📱',
        colorTheme: 'teal',
        progressPercent: 0.59,
        trendUp: true,
      ),
      AbdmKpiCard(
        title: 'Token-Based OPD Registrations',
        value:
            '${abdmState.abhaMetrics.tokenBasedOpdRegistrations.toStringAsFixed(2)}L',
        subText: '+23.1% MoM',
        emoji: '🎟',
        colorTheme: 'blue',
        progressPercent: 0.68,
        trendUp: true,
      ),
    ];

    return _buildResponsiveGrid(children);
  }

  Widget _buildEcosystemKpiGrid(
    BuildContext context,
    AbdmComplianceState abdmState,
  ) {
    final formattedRequests = abdmState.ecosystemMetrics.consentRequests
        .toString()
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );

    final children = [
      AbdmKpiCard(
        title: 'ABDM Consent Requests',
        value: formattedRequests,
        subText: '+2,103 today',
        emoji: '🤝',
        colorTheme: 'purple',
        progressPercent: 0.84,
        trendUp: true,
      ),
      AbdmKpiCard(
        title: 'Consent Approval Rate',
        value:
            '${abdmState.ecosystemMetrics.consentApprovalRate.toStringAsFixed(1)}%',
        subText: '+2.1% vs last month',
        emoji: '✅',
        colorTheme: 'green',
        progressPercent: 0.87,
        trendUp: true,
      ),
      AbdmKpiCard(
        title: 'Consent Denial Rate',
        value:
            '${abdmState.ecosystemMetrics.consentDenialRate.toStringAsFixed(1)}%',
        subText: 'Stable ±0.3%',
        emoji: '🚫',
        colorTheme: 'red',
        progressPercent: 0.08,
      ),
      AbdmKpiCard(
        title: 'Consent Pending',
        value:
            '${abdmState.ecosystemMetrics.consentPendingRate.toStringAsFixed(1)}%',
        subText: '-0.8% improved',
        emoji: '⏳',
        colorTheme: 'yellow',
        progressPercent: 0.04,
        trendUp: false,
      ),
      AbdmKpiCard(
        title: 'HIP Registered Facilities',
        value: '${abdmState.ecosystemMetrics.hipRegisteredFacilities}',
        subText: '+3 today',
        emoji: '🏥',
        colorTheme: 'accent',
        progressPercent: 0.81,
        trendUp: true,
      ),
      AbdmKpiCard(
        title: 'HIU Transactions',
        value:
            '${abdmState.ecosystemMetrics.hiuTransactions.toStringAsFixed(2)}L',
        subText: '+8,940 today',
        emoji: '🔄',
        colorTheme: 'teal',
        progressPercent: 0.72,
        trendUp: true,
      ),
      AbdmKpiCard(
        title: 'Health Record Exchanges',
        value: abdmState.ecosystemMetrics.healthRecordExchanges
            .toString()
            .replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},',
            ),
        subText: '+31.4% YoY',
        emoji: '📊',
        colorTheme: 'blue',
        progressPercent: 0.88,
        trendUp: true,
      ),
      AbdmKpiCard(
        title: 'ePrescription Exchange %',
        value:
            '${abdmState.ecosystemMetrics.ePrescriptionExchangePercent.toStringAsFixed(1)}%',
        subText: '+7.2% QoQ',
        emoji: '📝',
        colorTheme: 'green',
        progressPercent: 0.65,
        trendUp: true,
      ),
    ];

    return _buildResponsiveGrid(children);
  }

  Widget _buildApiKpiGrid(BuildContext context, AbdmComplianceState abdmState) {
    final children = [
      AbdmKpiCard(
        title: 'ABDM API Success Rate',
        value: '${abdmState.apiPerformance.successRate.toStringAsFixed(1)}%',
        subText: 'SLA target: 99.5%',
        emoji: '📶',
        colorTheme: 'green',
        progressPercent: 0.99,
      ),
      AbdmKpiCard(
        title: 'ABDM Integration Latency',
        value: '${abdmState.apiPerformance.latencyMs}ms',
        subText: 'P95 latency: 480ms',
        emoji: '⏱',
        colorTheme: 'accent',
        progressPercent: 0.65,
        trendUp: false, // Inverted meaning: lower latency is good
      ),
      AbdmKpiCard(
        title: 'Health Locker Sync Status',
        value:
            '${abdmState.apiPerformance.healthLockerSyncPercent.toStringAsFixed(1)}%',
        subText: '22.4K pending sync',
        emoji: '💾',
        colorTheme: 'yellow',
        progressPercent: 0.96,
      ),
      AbdmKpiCard(
        title: 'Ayushman + ABDM Mapping %',
        value:
            '${abdmState.apiPerformance.ayushmanAbdmMappingPercent.toStringAsFixed(1)}%',
        subText: '+3.4% this quarter',
        emoji: '❤️',
        colorTheme: 'teal',
        progressPercent: 0.81,
        trendUp: true,
      ),
    ];

    return _buildResponsiveGrid(children);
  }

  Widget _buildResponsiveGrid(List<Widget> children) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.50,
      ),
      itemCount: children.length,
      itemBuilder: (context, idx) => children[idx],
    );
  }

  // --- FOOTER ---
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0x1F2A4158))),
      ),
      child: const Column(
        children: [
          Text(
            'ParaCare+ Uttarakhand · ABDM Compliance Dashboard · NHA Integration v3.2 · FHIR R4 Compliant',
            style: TextStyle(fontSize: 10, color: AppColors.secondaryText),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              BoxShapeDot(color: AppColors.success),
              SizedBox(width: 6),
              Text(
                'NHA GATEWAY: OPERATIONAL',
                style: TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BoxShapeDot extends StatelessWidget {
  const BoxShapeDot({required this.color, super.key});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}
