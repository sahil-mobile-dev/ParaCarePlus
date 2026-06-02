import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/features/abdm_compliance/model/abdm_compliance_model.dart';

class AbdmComplianceState {
  const AbdmComplianceState({
    required this.selectedDistrict,
    required this.selectedFacilityType,
    required this.selectedTimePeriod,
    required this.selectedModule,
    required this.isRefreshing,
    required this.sortBy,
    required this.abhaMetrics,
    required this.ecosystemMetrics,
    required this.apiPerformance,
    required this.fhirEndpoints,
    required this.journeySteps,
    required this.complianceMatrix,
    required this.districts,
    required this.criticalAlerts,
    required this.watchAlerts,
    required this.tickerAlerts,
  });

  final String selectedDistrict;
  final String selectedFacilityType;
  final String selectedTimePeriod;
  final String selectedModule;
  final bool isRefreshing;
  final String sortBy;
  final AbhaMetrics abhaMetrics;
  final EcosystemMetrics ecosystemMetrics;
  final ApiPerformanceMetrics apiPerformance;
  final List<FhirApiEndpoint> fhirEndpoints;
  final List<JourneyStep> journeySteps;
  final List<ComplianceMatrixRow> complianceMatrix;
  final List<DistrictAbdmScorecard> districts;
  final List<ComplianceAlert> criticalAlerts;
  final List<ComplianceAlert> watchAlerts;
  final List<ComplianceAlert> tickerAlerts;

  AbdmComplianceState copyWith({
    String? selectedDistrict,
    String? selectedFacilityType,
    String? selectedTimePeriod,
    String? selectedModule,
    bool? isRefreshing,
    String? sortBy,
    AbhaMetrics? abhaMetrics,
    EcosystemMetrics? ecosystemMetrics,
    ApiPerformanceMetrics? apiPerformance,
    List<FhirApiEndpoint>? fhirEndpoints,
    List<JourneyStep>? journeySteps,
    List<ComplianceMatrixRow>? complianceMatrix,
    List<DistrictAbdmScorecard>? districts,
    List<ComplianceAlert>? criticalAlerts,
    List<ComplianceAlert>? watchAlerts,
    List<ComplianceAlert>? tickerAlerts,
  }) {
    return AbdmComplianceState(
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedFacilityType: selectedFacilityType ?? this.selectedFacilityType,
      selectedTimePeriod: selectedTimePeriod ?? this.selectedTimePeriod,
      selectedModule: selectedModule ?? this.selectedModule,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      sortBy: sortBy ?? this.sortBy,
      abhaMetrics: abhaMetrics ?? this.abhaMetrics,
      ecosystemMetrics: ecosystemMetrics ?? this.ecosystemMetrics,
      apiPerformance: apiPerformance ?? this.apiPerformance,
      fhirEndpoints: fhirEndpoints ?? this.fhirEndpoints,
      journeySteps: journeySteps ?? this.journeySteps,
      complianceMatrix: complianceMatrix ?? this.complianceMatrix,
      districts: districts ?? this.districts,
      criticalAlerts: criticalAlerts ?? this.criticalAlerts,
      watchAlerts: watchAlerts ?? this.watchAlerts,
      tickerAlerts: tickerAlerts ?? this.tickerAlerts,
    );
  }
}

class AbdmComplianceNotifier extends StateNotifier<AbdmComplianceState> {
  AbdmComplianceNotifier()
    : super(
        AbdmComplianceState(
          selectedDistrict: 'All Districts',
          selectedFacilityType: 'All Facility Types',
          selectedTimePeriod: 'Last 30 Days',
          selectedModule: 'All ABDM Modules',
          isRefreshing: false,
          sortBy: 'Score',
          abhaMetrics: _initialAbhaMetrics,
          ecosystemMetrics: _initialEcosystemMetrics,
          apiPerformance: _initialApiPerformance,
          fhirEndpoints: _initialFhirEndpoints,
          journeySteps: _initialJourneySteps,
          complianceMatrix: _initialComplianceMatrix,
          districts: _initialDistricts,
          criticalAlerts: _initialCriticalAlerts,
          watchAlerts: _initialWatchAlerts,
          tickerAlerts: _initialTickerAlerts,
        ),
      ) {
    _startSimulations();
  }

  Timer? _liveTimer;
  final _random = Random();

  void _startSimulations() {
    _liveTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      // Periodic live data simulations
      final currentGenerated = state.abhaMetrics.totalGenerated;
      final extraGenerated = _random.nextDouble() * 0.05 + 0.01;
      final newGenerated = currentGenerated + extraGenerated;

      final extraLinked = extraGenerated * 0.63;
      final newLinked = state.abhaMetrics.linkedEmr + extraLinked;

      final currentRequests = state.ecosystemMetrics.consentRequests;
      final extraRequests = _random.nextInt(5) + 1;
      final newRequests = currentRequests + extraRequests;

      final newLatency =
          (state.apiPerformance.latencyMs + _random.nextInt(20) - 10).clamp(
            195,
            245,
          );

      state = state.copyWith(
        abhaMetrics: state.abhaMetrics.copyWith(
          totalGenerated: newGenerated,
          linkedEmr: newLinked,
        ),
        ecosystemMetrics: state.ecosystemMetrics.copyWith(
          consentRequests: newRequests,
        ),
        apiPerformance: state.apiPerformance.copyWith(latencyMs: newLatency),
      );
    });
  }

  void changeDistrict(String val) {
    state = state.copyWith(selectedDistrict: val);
  }

  void changeFacilityType(String val) {
    state = state.copyWith(selectedFacilityType: val);
  }

  void changeTimePeriod(String val) {
    state = state.copyWith(selectedTimePeriod: val);
  }

  void changeModule(String val) {
    state = state.copyWith(selectedModule: val);
  }

  void sortDistricts(String sortBy) {
    final list = List<DistrictAbdmScorecard>.from(state.districts);
    if (sortBy == 'District') {
      list.sort((a, b) => a.name.compareTo(b.name));
    } else if (sortBy == 'ABHA') {
      list.sort(
        (a, b) => b.abhaCoveragePercent.compareTo(a.abhaCoveragePercent),
      );
    } else if (sortBy == 'EMR') {
      list.sort((a, b) => b.emrLinkedPercent.compareTo(a.emrLinkedPercent));
    } else if (sortBy == 'Consent') {
      list.sort((a, b) => b.consentRatePercent.compareTo(a.consentRatePercent));
    } else if (sortBy == 'HIP') {
      list.sort((a, b) => b.hipFacilitiesCount.compareTo(a.hipFacilitiesCount));
    } else if (sortBy == 'HIU') {
      list.sort((a, b) => b.hiuTxnsCount.compareTo(a.hiuTxnsCount));
    } else if (sortBy == 'Uptime') {
      list.sort((a, b) => b.apiUptimePercent.compareTo(a.apiUptimePercent));
    } else if (sortBy == 'ePresc') {
      list.sort(
        (a, b) => b.ePrescriptionPercent.compareTo(a.ePrescriptionPercent),
      );
    } else if (sortBy == 'S&S') {
      list.sort(
        (a, b) => b.scanAndSharePercent.compareTo(a.scanAndSharePercent),
      );
    } else if (sortBy == 'AB+ABDM') {
      list.sort((a, b) => b.abAbdmPercent.compareTo(a.abAbdmPercent));
    } else if (sortBy == 'Score') {
      list.sort((a, b) => b.score.compareTo(a.score));
    }
    state = state.copyWith(sortBy: sortBy, districts: list);
  }

  Future<void> refresh() async {
    if (state.isRefreshing) return;
    state = state.copyWith(isRefreshing: true);

    await Future<void>.delayed(const Duration(milliseconds: 1000));

    final updatedDistricts = state.districts.map((d) {
      final coverageOffset = _random.nextDouble() * 2 - 1;
      final scoreOffset = _random.nextInt(3) - 1;
      final newScore = (d.score + scoreOffset).clamp(40, 95);

      return d.copyWith(
        abhaCoveragePercent: (d.abhaCoveragePercent + coverageOffset).clamp(
          40.0,
          99.0,
        ),
        score: newScore,
        grade: newScore >= 80
            ? 'A'
            : (newScore >= 70 ? 'B' : (newScore >= 60 ? 'C' : 'D')),
      );
    }).toList();

    state = state.copyWith(
      isRefreshing: false,
      districts: updatedDistricts,
      apiPerformance: state.apiPerformance.copyWith(
        successRate: (99.0 + _random.nextDouble() * 0.9).clamp(98.5, 99.9),
      ),
    );

    sortDistricts(state.sortBy);
  }

  @override
  void dispose() {
    _liveTimer?.cancel();
    super.dispose();
  }

  // --- Static Initial Mock Data ---

  static const AbhaMetrics _initialAbhaMetrics = AbhaMetrics(
    totalGenerated: 38.7,
    linkedEmr: 24.2,
    linkedEmrPercent: 62.5,
    digitalHealthIdCoverage: 73.4,
    scanAndShareOpdAdoption: 58.9,
    tokenBasedOpdRegistrations: 1.84,
  );

  static const EcosystemMetrics _initialEcosystemMetrics = EcosystemMetrics(
    consentRequests: 847291,
    consentApprovalRate: 87.3,
    consentDenialRate: 8.4,
    consentPendingRate: 4.3,
    hipRegisteredFacilities: 1247,
    hiuTransactions: 3.21,
    healthRecordExchanges: 234817,
    ePrescriptionExchangePercent: 64.7,
  );

  static const ApiPerformanceMetrics _initialApiPerformance =
      ApiPerformanceMetrics(
        successRate: 99.3,
        latencyMs: 214,
        healthLockerSyncPercent: 96.8,
        ayushmanAbdmMappingPercent: 81.2,
      );

  static const List<FhirApiEndpoint> _initialFhirEndpoints = [
    FhirApiEndpoint(
      name: 'ABHA Gateway',
      endpoint: '/v0.5/users/auth/on-init',
      latencyMs: 142,
      uptimePercent: 99.8,
      status: 'ok',
    ),
    FhirApiEndpoint(
      name: 'NHA Central Registry',
      endpoint: '/v1.0/registry/search',
      latencyMs: 189,
      uptimePercent: 99.7,
      status: 'ok',
    ),
    FhirApiEndpoint(
      name: 'Consent Manager',
      endpoint: '/v0.5/consent-requests/init',
      latencyMs: 245,
      uptimePercent: 98.4,
      status: 'ok',
    ),
    FhirApiEndpoint(
      name: 'Health Locker Sync',
      endpoint: '/v0.5/health-information/share',
      latencyMs: 312,
      uptimePercent: 97.9,
      status: 'ok',
    ),
    FhirApiEndpoint(
      name: 'eSanjeevani Bridge',
      endpoint: '/v1.0/esanjeevani/teleconsult',
      latencyMs: 480,
      uptimePercent: 94.2,
      status: 'warn',
    ),
    FhirApiEndpoint(
      name: 'HIP Service Endpoint',
      endpoint: '/v0.5/hip/record-share',
      latencyMs: 198,
      uptimePercent: 99.1,
      status: 'ok',
    ),
    FhirApiEndpoint(
      name: 'HIU Service Endpoint',
      endpoint: '/v0.5/hiu/data-transfer',
      latencyMs: 210,
      uptimePercent: 98.8,
      status: 'ok',
    ),
    FhirApiEndpoint(
      name: 'Pithoragarh DH Endpoint',
      endpoint: '/v0.5/fhir/pit-dh/transfer',
      latencyMs: 1250,
      uptimePercent: 82.5,
      status: 'err',
    ),
  ];

  static final List<JourneyStep> _initialJourneySteps = [
    const JourneyStep(
      label: 'OPD Footfall',
      count: '6.48L',
      pct: '100%',
      icon: '👥',
      color: Colors.blue,
    ),
    const JourneyStep(
      label: 'ABHA Generated',
      count: '4.82L',
      pct: '74.3%',
      icon: '📇',
      color: Colors.teal,
    ),
    const JourneyStep(
      label: 'EMR Linked',
      count: '3.01L',
      pct: '62.4%',
      icon: '🔗',
      color: Colors.green,
    ),
    const JourneyStep(
      label: 'Consent Requested',
      count: '2.42L',
      pct: '80.3%',
      icon: '🤝',
      color: Colors.purple,
    ),
    const JourneyStep(
      label: 'Record Shared',
      count: '2.11L',
      pct: '87.1%',
      icon: '📂',
      color: Colors.cyan,
    ),
  ];

  static const List<ComplianceMatrixRow> _initialComplianceMatrix = [
    ComplianceMatrixRow(
      module: 'ABHA Generation',
      facilitiesCount: 1240,
      compliancePercent: 92.4,
      score: 'A',
      trend: 'up',
      status: 'Full',
      lastAudit: '20 min ago',
    ),
    ComplianceMatrixRow(
      module: 'Consent Manager M2',
      facilitiesCount: 1047,
      compliancePercent: 84.1,
      score: 'B',
      trend: 'up',
      status: 'Full',
      lastAudit: '1 hr ago',
    ),
    ComplianceMatrixRow(
      module: 'Health Locker M3',
      facilitiesCount: 840,
      compliancePercent: 78.3,
      score: 'B',
      trend: 'stable',
      status: 'Partial',
      lastAudit: '2 hr ago',
    ),
    ComplianceMatrixRow(
      module: 'HIP Facility Linkage',
      facilitiesCount: 1247,
      compliancePercent: 96.8,
      score: 'A',
      trend: 'up',
      status: 'Full',
      lastAudit: '10 min ago',
    ),
    ComplianceMatrixRow(
      module: 'HIU Consultation System',
      facilitiesCount: 420,
      compliancePercent: 54.2,
      score: 'D',
      trend: 'down',
      status: 'Degraded',
      lastAudit: '4 hr ago',
    ),
    ComplianceMatrixRow(
      module: 'ePrescription Exchange',
      facilitiesCount: 842,
      compliancePercent: 68.7,
      score: 'C',
      trend: 'stable',
      status: 'Partial',
      lastAudit: '3 hr ago',
    ),
    ComplianceMatrixRow(
      module: 'Scan & Share Gateway',
      facilitiesCount: 1102,
      compliancePercent: 89.2,
      score: 'A',
      trend: 'up',
      status: 'Full',
      lastAudit: '15 min ago',
    ),
  ];

  static const List<DistrictAbdmScorecard> _initialDistricts = [
    DistrictAbdmScorecard(
      name: 'Dehradun',
      abhaCoveragePercent: 84.2,
      emrLinkedPercent: 72.4,
      consentRatePercent: 89.5,
      hipFacilitiesCount: 147,
      hiuTxnsCount: 48900,
      apiUptimePercent: 99.8,
      ePrescriptionPercent: 74.3,
      scanAndSharePercent: 81.2,
      abAbdmPercent: 88.5,
      grade: 'A',
      score: 84,
    ),
    DistrictAbdmScorecard(
      name: 'Haridwar',
      abhaCoveragePercent: 79.1,
      emrLinkedPercent: 61.2,
      consentRatePercent: 84.3,
      hipFacilitiesCount: 124,
      hiuTxnsCount: 39400,
      apiUptimePercent: 99.4,
      ePrescriptionPercent: 68.2,
      scanAndSharePercent: 72.4,
      abAbdmPercent: 81.4,
      grade: 'B',
      score: 79,
    ),
    DistrictAbdmScorecard(
      name: 'Nainital',
      abhaCoveragePercent: 81.4,
      emrLinkedPercent: 65.8,
      consentRatePercent: 87.2,
      hipFacilitiesCount: 98,
      hiuTxnsCount: 31200,
      apiUptimePercent: 99.6,
      ePrescriptionPercent: 70.1,
      scanAndSharePercent: 76.5,
      abAbdmPercent: 84.2,
      grade: 'B',
      score: 81,
    ),
    DistrictAbdmScorecard(
      name: 'Udham Singh Nagar',
      abhaCoveragePercent: 76.8,
      emrLinkedPercent: 58.9,
      consentRatePercent: 81.1,
      hipFacilitiesCount: 112,
      hiuTxnsCount: 28900,
      apiUptimePercent: 99.1,
      ePrescriptionPercent: 61.4,
      scanAndSharePercent: 69.8,
      abAbdmPercent: 79.5,
      grade: 'B',
      score: 76,
    ),
    DistrictAbdmScorecard(
      name: 'Almora',
      abhaCoveragePercent: 70.2,
      emrLinkedPercent: 52.4,
      consentRatePercent: 78.5,
      hipFacilitiesCount: 84,
      hiuTxnsCount: 14200,
      apiUptimePercent: 98.7,
      ePrescriptionPercent: 54.8,
      scanAndSharePercent: 58.2,
      abAbdmPercent: 72.1,
      grade: 'C',
      score: 70,
    ),
    DistrictAbdmScorecard(
      name: 'Pauri Garhwal',
      abhaCoveragePercent: 68.4,
      emrLinkedPercent: 49.8,
      consentRatePercent: 75.2,
      hipFacilitiesCount: 96,
      hiuTxnsCount: 12100,
      apiUptimePercent: 98.2,
      ePrescriptionPercent: 51.2,
      scanAndSharePercent: 54.9,
      abAbdmPercent: 69.8,
      grade: 'C',
      score: 68,
    ),
    DistrictAbdmScorecard(
      name: 'Tehri Garhwal',
      abhaCoveragePercent: 72.1,
      emrLinkedPercent: 54.1,
      consentRatePercent: 80.3,
      hipFacilitiesCount: 78,
      hiuTxnsCount: 15400,
      apiUptimePercent: 98.9,
      ePrescriptionPercent: 58.1,
      scanAndSharePercent: 62.4,
      abAbdmPercent: 74.3,
      grade: 'C',
      score: 72,
    ),
    DistrictAbdmScorecard(
      name: 'Chamoli',
      abhaCoveragePercent: 65.4,
      emrLinkedPercent: 44.2,
      consentRatePercent: 71.8,
      hipFacilitiesCount: 72,
      hiuTxnsCount: 9800,
      apiUptimePercent: 97.4,
      ePrescriptionPercent: 46.5,
      scanAndSharePercent: 50.1,
      abAbdmPercent: 64.2,
      grade: 'C',
      score: 65,
    ),
    DistrictAbdmScorecard(
      name: 'Rudraprayag',
      abhaCoveragePercent: 61.2,
      emrLinkedPercent: 40.5,
      consentRatePercent: 68.4,
      hipFacilitiesCount: 42,
      hiuTxnsCount: 6500,
      apiUptimePercent: 96.8,
      ePrescriptionPercent: 41.2,
      scanAndSharePercent: 45.8,
      abAbdmPercent: 59.4,
      grade: 'D',
      score: 61,
    ),
    DistrictAbdmScorecard(
      name: 'Uttarkashi',
      abhaCoveragePercent: 63.8,
      emrLinkedPercent: 42.1,
      consentRatePercent: 70.2,
      hipFacilitiesCount: 68,
      hiuTxnsCount: 8400,
      apiUptimePercent: 97.1,
      ePrescriptionPercent: 43.8,
      scanAndSharePercent: 48.2,
      abAbdmPercent: 61.8,
      grade: 'C',
      score: 63,
    ),
    DistrictAbdmScorecard(
      name: 'Pithoragarh',
      abhaCoveragePercent: 58.5,
      emrLinkedPercent: 38.2,
      consentRatePercent: 65.1,
      hipFacilitiesCount: 88,
      hiuTxnsCount: 7200,
      apiUptimePercent: 92.5,
      ePrescriptionPercent: 37.4,
      scanAndSharePercent: 41.5,
      abAbdmPercent: 56.2,
      grade: 'D',
      score: 58,
    ),
    DistrictAbdmScorecard(
      name: 'Bageshwar',
      abhaCoveragePercent: 55.1,
      emrLinkedPercent: 34.9,
      consentRatePercent: 61.4,
      hipFacilitiesCount: 54,
      hiuTxnsCount: 5100,
      apiUptimePercent: 96.2,
      ePrescriptionPercent: 34.2,
      scanAndSharePercent: 39.8,
      abAbdmPercent: 52.4,
      grade: 'D',
      score: 55,
    ),
    DistrictAbdmScorecard(
      name: 'Champawat',
      abhaCoveragePercent: 57.3,
      emrLinkedPercent: 36.1,
      consentRatePercent: 63.9,
      hipFacilitiesCount: 58,
      hiuTxnsCount: 5800,
      apiUptimePercent: 96.5,
      ePrescriptionPercent: 36.1,
      scanAndSharePercent: 41.2,
      abAbdmPercent: 54.8,
      grade: 'D',
      score: 57,
    ),
  ];

  static const List<ComplianceAlert> _initialCriticalAlerts = [
    ComplianceAlert(
      message:
          'Pithoragarh Dist. Hospital — FHIR endpoint timeout · 3 retries failed',
      cls: 'crit',
      time: '2 min ago',
    ),
    ComplianceAlert(
      message:
          'Haridwar CHC cluster — Consent module v2.1 upgrade pending (NHA deadline: May 20)',
      cls: 'crit',
      time: '8 min ago',
    ),
    ComplianceAlert(
      message:
          'Rudrapur DH — Key observ. diagnostics failing SNOMED CT validator',
      cls: 'crit',
      time: '15 min ago',
    ),
  ];

  static const List<ComplianceAlert> _initialWatchAlerts = [
    ComplianceAlert(
      message:
          'eSanjeevani ABDM bridge — Partial connectivity · Monitoring active',
      cls: 'warn',
      time: '30 min ago',
    ),
    ComplianceAlert(
      message: 'Chamoli PHCs — Scan & Share QR code sync degradation (12 PHCs)',
      cls: 'warn',
      time: '1 hr ago',
    ),
    ComplianceAlert(
      message: 'Bageshwar CHC — Uptime dropped below 95% SLA target (94.2%)',
      cls: 'warn',
      time: '2 hr ago',
    ),
  ];

  static const List<ComplianceAlert> _initialTickerAlerts = [
    ComplianceAlert(
      message: 'ABHA Gateway — Operational · 99.7% uptime',
      cls: 'ok',
      time: '',
    ),
    ComplianceAlert(
      message:
          'Haridwar CHC cluster — Consent module v2.1 upgrade pending (NHA deadline: May 20)',
      cls: 'warn',
      time: '',
    ),
    ComplianceAlert(
      message: 'NHA Central Registry sync — Completed 09:14 · 2,34,817 bundles',
      cls: 'ok',
      time: '',
    ),
    ComplianceAlert(
      message:
          'Pithoragarh Dist. Hospital — FHIR endpoint timeout · 3 retries failed',
      cls: 'err',
      time: '',
    ),
    ComplianceAlert(
      message: 'Health Locker — 2,34,817 records exchanged today',
      cls: 'ok',
      time: '',
    ),
    ComplianceAlert(
      message:
          'eSanjeevani ABDM bridge — Partial connectivity · Monitoring active',
      cls: 'warn',
      time: '',
    ),
    ComplianceAlert(
      message: 'ICD-11 terminology update — 14,302 codes synced',
      cls: 'ok',
      time: '',
    ),
    ComplianceAlert(
      message: 'HIP registration — 3 new facilities onboarded today',
      cls: 'ok',
      time: '',
    ),
  ];
}

final abdmComplianceProvider =
    StateNotifierProvider<AbdmComplianceNotifier, AbdmComplianceState>((ref) {
      return AbdmComplianceNotifier();
    });
