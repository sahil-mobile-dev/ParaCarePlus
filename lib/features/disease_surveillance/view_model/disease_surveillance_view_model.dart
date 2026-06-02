import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/features/disease_surveillance/model/disease_surveillance_model.dart';

class DiseaseSurveillanceState {
  const DiseaseSurveillanceState({
    required this.selectedDistrict,
    required this.selectedDisease,
    required this.selectedTimePeriod,
    required this.selectedFacilityLevel,
    required this.isRefreshing,
    required this.outbreaks,
    required this.alerts,
    required this.activeOutbreakCount,
    required this.newCasesToday,
    required this.vectorCasesMtd,
    required this.waterCasesMtd,
    required this.deathsMtd,
    required this.rrtDeployed,
    required this.vaccinationCoverage,
    required this.tbActiveCases,
    required this.iliCasesMtd,
    required this.cfrRate,
    required this.samplesTestedMtd,
    required this.containmentZonesActive,
  });

  final String selectedDistrict;
  final String selectedDisease;
  final String selectedTimePeriod;
  final String selectedFacilityLevel;
  final bool isRefreshing;
  final List<OutbreakItem> outbreaks;
  final List<SurveillanceAlert> alerts;

  // 12 KPIs
  final int activeOutbreakCount;
  final int newCasesToday;
  final int vectorCasesMtd;
  final int waterCasesMtd;
  final int deathsMtd;
  final int rrtDeployed;
  final double vaccinationCoverage;
  final int tbActiveCases;
  final int iliCasesMtd;
  final double cfrRate;
  final int samplesTestedMtd;
  final int containmentZonesActive;

  DiseaseSurveillanceState copyWith({
    String? selectedDistrict,
    String? selectedDisease,
    String? selectedTimePeriod,
    String? selectedFacilityLevel,
    bool? isRefreshing,
    List<OutbreakItem>? outbreaks,
    List<SurveillanceAlert>? alerts,
    int? activeOutbreakCount,
    int? newCasesToday,
    int? vectorCasesMtd,
    int? waterCasesMtd,
    int? deathsMtd,
    int? rrtDeployed,
    double? vaccinationCoverage,
    int? tbActiveCases,
    int? iliCasesMtd,
    double? cfrRate,
    int? samplesTestedMtd,
    int? containmentZonesActive,
  }) {
    return DiseaseSurveillanceState(
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedDisease: selectedDisease ?? this.selectedDisease,
      selectedTimePeriod: selectedTimePeriod ?? this.selectedTimePeriod,
      selectedFacilityLevel:
          selectedFacilityLevel ?? this.selectedFacilityLevel,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      outbreaks: outbreaks ?? this.outbreaks,
      alerts: alerts ?? this.alerts,
      activeOutbreakCount: activeOutbreakCount ?? this.activeOutbreakCount,
      newCasesToday: newCasesToday ?? this.newCasesToday,
      vectorCasesMtd: vectorCasesMtd ?? this.vectorCasesMtd,
      waterCasesMtd: waterCasesMtd ?? this.waterCasesMtd,
      deathsMtd: deathsMtd ?? this.deathsMtd,
      rrtDeployed: rrtDeployed ?? this.rrtDeployed,
      vaccinationCoverage: vaccinationCoverage ?? this.vaccinationCoverage,
      tbActiveCases: tbActiveCases ?? this.tbActiveCases,
      iliCasesMtd: iliCasesMtd ?? this.iliCasesMtd,
      cfrRate: cfrRate ?? this.cfrRate,
      samplesTestedMtd: samplesTestedMtd ?? this.samplesTestedMtd,
      containmentZonesActive:
          containmentZonesActive ?? this.containmentZonesActive,
    );
  }
}

class DiseaseSurveillanceNotifier
    extends StateNotifier<DiseaseSurveillanceState> {
  DiseaseSurveillanceNotifier()
    : super(
        DiseaseSurveillanceState(
          selectedDistrict: 'All Districts',
          selectedDisease: 'All Diseases',
          selectedTimePeriod: 'Last 30 Days',
          selectedFacilityLevel: 'All Facility Levels',
          isRefreshing: false,
          outbreaks: _initialOutbreaks,
          alerts: _initialAlerts,
          activeOutbreakCount: 7,
          newCasesToday: 1284,
          vectorCasesMtd: 3847,
          waterCasesMtd: 892,
          deathsMtd: 18,
          rrtDeployed: 14,
          vaccinationCoverage: 94.7,
          tbActiveCases: 4218,
          iliCasesMtd: 12480,
          cfrRate: 0.31,
          samplesTestedMtd: 28412,
          containmentZonesActive: 12,
        ),
      ) {
    _startSimulationTimer();
  }

  Timer? _simTimer;
  final _random = Random();

  void _startSimulationTimer() {
    _simTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (state.isRefreshing) return;
      // Fluctuates raw stats slightly to reflect live telemetry updates
      final newCasesDiff = _random.nextInt(20) - 10;
      final samplesDiff = _random.nextInt(100) - 40;
      final casesMtdDiff = _random.nextInt(30) - 10;

      state = state.copyWith(
        newCasesToday: (state.newCasesToday + newCasesDiff).clamp(1100, 1500),
        samplesTestedMtd: (state.samplesTestedMtd + samplesDiff).clamp(
          25000,
          32000,
        ),
        vectorCasesMtd: (state.vectorCasesMtd + casesMtdDiff).clamp(3500, 4200),
      );
    });
  }

  void changeDistrict(String val) {
    state = state.copyWith(selectedDistrict: val);
  }

  void changeDisease(String val) {
    state = state.copyWith(selectedDisease: val);
  }

  void changeTimePeriod(String val) {
    state = state.copyWith(selectedTimePeriod: val);
  }

  void changeFacilityLevel(String val) {
    state = state.copyWith(selectedFacilityLevel: val);
  }

  Future<void> refresh() async {
    if (state.isRefreshing) return;
    state = state.copyWith(isRefreshing: true);

    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 1000));

    // Fluctuates variables to indicate update action
    final updatedOutbreaks = state.outbreaks.map((ob) {
      final casesOffset = _random.nextInt(10) - 4;
      return ob.copyWith(
        casesCount: (ob.casesCount + casesOffset).clamp(10, 600),
      );
    }).toList();

    state = state.copyWith(
      isRefreshing: false,
      outbreaks: updatedOutbreaks,
      newCasesToday: 1200 + _random.nextInt(150),
      activeOutbreakCount: 6 + _random.nextInt(3),
    );
  }

  @override
  void dispose() {
    _simTimer?.cancel();
    super.dispose();
  }

  static final List<OutbreakItem> _initialOutbreaks = [
    const OutbreakItem(
      disease: 'Dengue',
      district: 'Haridwar',
      firstReported: 'May 02',
      casesCount: 487,
      deathsCount: 1,
      cfrPercent: 0.21,
      rrtStatus: 'Deployed',
      containmentStatus: 'Active',
      severity: 'crit',
      lastUpdate: 'Today',
    ),
    const OutbreakItem(
      disease: 'Scrub Typhus',
      district: 'Almora',
      firstReported: 'May 06',
      casesCount: 84,
      deathsCount: 2,
      cfrPercent: 2.38,
      rrtStatus: 'Deployed',
      containmentStatus: 'Active',
      severity: 'high',
      lastUpdate: 'Today',
    ),
    const OutbreakItem(
      disease: 'Malaria (Pf)',
      district: 'Udham S Nagar',
      firstReported: 'May 08',
      casesCount: 143,
      deathsCount: 0,
      cfrPercent: 0,
      rrtStatus: 'Deployed',
      containmentStatus: 'Active',
      severity: 'high',
      lastUpdate: 'Today',
    ),
    const OutbreakItem(
      disease: 'Influenza A(H3)',
      district: 'Dehradun',
      firstReported: 'May 03',
      casesCount: 312,
      deathsCount: 1,
      cfrPercent: 0.32,
      rrtStatus: 'Standby',
      containmentStatus: 'Monitor',
      severity: 'high',
      lastUpdate: 'Today',
    ),
    const OutbreakItem(
      disease: 'Typhoid',
      district: 'Tehri Garhwal',
      firstReported: 'Apr 28',
      casesCount: 67,
      deathsCount: 0,
      cfrPercent: 0,
      rrtStatus: 'Standby',
      containmentStatus: 'Controlled',
      severity: 'med',
      lastUpdate: 'Today',
    ),
    const OutbreakItem(
      disease: 'Hepatitis A',
      district: 'Chamoli',
      firstReported: 'May 10',
      casesCount: 34,
      deathsCount: 0,
      cfrPercent: 0,
      rrtStatus: 'Deployed',
      containmentStatus: 'Active',
      severity: 'med',
      lastUpdate: 'Today',
    ),
    const OutbreakItem(
      disease: 'Leptospirosis',
      district: 'Uttarkashi',
      firstReported: 'May 12',
      casesCount: 18,
      deathsCount: 0,
      cfrPercent: 0,
      rrtStatus: 'En Route',
      containmentStatus: 'Pending',
      severity: 'med',
      lastUpdate: 'Today',
    ),
  ];

  static final List<SurveillanceAlert> _initialAlerts = [
    const SurveillanceAlert(
      msg:
          'Dengue Outbreak — Haridwar: 487 cases, 1 death. RRT deployed. Fogging operations in 6 wards.',
      time: 'Today 09:15 AM',
      severity: 'crit',
    ),
    const SurveillanceAlert(
      msg:
          'Scrub Typhus — Almora: 84 confirmed cases, 2 ICU admissions. Doxycycline stocks dispatched.',
      time: 'Today 08:40 AM',
      severity: 'crit',
    ),
    const SurveillanceAlert(
      msg:
          'P. falciparum Malaria — Udham Singh Nagar: 23 new cases in 3 days. Indoor residual spraying (IRS) activated.',
      time: 'Today 08:55 AM',
      severity: 'crit',
    ),
    const SurveillanceAlert(
      msg:
          'Seasonal ILI/Influenza — Dehradun: +34% increase. All PHCs on IHIP reporting alert. Oseltamivir stocks adequate.',
      time: 'Today 07:30 AM',
      severity: 'warn',
    ),
    const SurveillanceAlert(
      msg:
          'Post-rain water-borne disease risk — Tehri & Uttarkashi: Chlorination advisory issued. Water testing intensified.',
      time: 'Today 07:00 AM',
      severity: 'warn',
    ),
    const SurveillanceAlert(
      msg:
          'Hepatitis A cluster — Chamoli: 34 cases linked to contaminated water source. Investigation ongoing.',
      time: 'Today 06:45 AM',
      severity: 'warn',
    ),
    const SurveillanceAlert(
      msg:
          'Leptospirosis alert — Uttarkashi: 18 cases following flooding. Prophylaxis distribution active.',
      time: 'Today 06:20 AM',
      severity: 'warn',
    ),
  ];
}

final diseaseSurveillanceProvider =
    StateNotifierProvider<
      DiseaseSurveillanceNotifier,
      DiseaseSurveillanceState
    >((ref) {
      return DiseaseSurveillanceNotifier();
    });
