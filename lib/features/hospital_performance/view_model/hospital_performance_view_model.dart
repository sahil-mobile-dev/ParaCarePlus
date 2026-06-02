import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/features/hospital_performance/model/hospital_performance_model.dart';

class HospitalPerformanceState {
  const HospitalPerformanceState({
    required this.selectedHospital,
    required this.selectedFacilityType,
    required this.selectedDistrict,
    required this.selectedTimePeriod,
    required this.sortBy,
    required this.isRefreshing,
    required this.kpis,
    required this.scorecardItems,
    required this.criticalAlerts,
    required this.watchAlerts,
  });

  final String selectedHospital;
  final String selectedFacilityType;
  final String selectedDistrict;
  final String selectedTimePeriod;
  final String sortBy;
  final bool isRefreshing;
  final HospitalPerformanceKpis kpis;
  final List<HospitalScorecardItem> scorecardItems;
  final List<HospitalPerformanceAlert> criticalAlerts;
  final List<HospitalPerformanceAlert> watchAlerts;

  HospitalPerformanceState copyWith({
    String? selectedHospital,
    String? selectedFacilityType,
    String? selectedDistrict,
    String? selectedTimePeriod,
    String? sortBy,
    bool? isRefreshing,
    HospitalPerformanceKpis? kpis,
    List<HospitalScorecardItem>? scorecardItems,
    List<HospitalPerformanceAlert>? criticalAlerts,
    List<HospitalPerformanceAlert>? watchAlerts,
  }) {
    return HospitalPerformanceState(
      selectedHospital: selectedHospital ?? this.selectedHospital,
      selectedFacilityType: selectedFacilityType ?? this.selectedFacilityType,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedTimePeriod: selectedTimePeriod ?? this.selectedTimePeriod,
      sortBy: sortBy ?? this.sortBy,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      kpis: kpis ?? this.kpis,
      scorecardItems: scorecardItems ?? this.scorecardItems,
      criticalAlerts: criticalAlerts ?? this.criticalAlerts,
      watchAlerts: watchAlerts ?? this.watchAlerts,
    );
  }
}

class HospitalPerformanceNotifier
    extends StateNotifier<HospitalPerformanceState> {
  HospitalPerformanceNotifier()
    : super(
        const HospitalPerformanceState(
          selectedHospital: 'All Hospitals',
          selectedFacilityType: 'All Facility Types',
          selectedDistrict: 'All Districts',
          selectedTimePeriod: 'Last 30 Days',
          sortBy: 'Hospital',
          isRefreshing: false,
          kpis: _initialKpis,
          scorecardItems: _initialScorecard,
          criticalAlerts: _initialCriticalAlerts,
          watchAlerts: _initialWatchAlerts,
        ),
      ) {
    _startTelemetryTimer();
  }

  Timer? _telemetryTimer;
  final _random = Random();

  void _startTelemetryTimer() {
    _telemetryTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (state.isRefreshing) return;

      // Fluctuate bed occupancy, ICU occupancy, daily OPD, etc. slightly
      final kpiChange = state.kpis.copyWith(
        bedOccupancyPercent:
            (state.kpis.bedOccupancyPercent + (_random.nextDouble() * 2 - 1))
                .clamp(70.0, 95.0),
        icuOccupancyPercent:
            (state.kpis.icuOccupancyPercent + (_random.nextDouble() * 3 - 1.5))
                .clamp(75.0, 98.0),
        dailyOpd: (state.kpis.dailyOpd + _random.nextInt(100) - 50).clamp(
          48000,
          56000,
        ),
        dailyIpdAdmissions:
            (state.kpis.dailyIpdAdmissions + _random.nextInt(20) - 10).clamp(
              3500,
              4200,
            ),
        dailyDischarges: (state.kpis.dailyDischarges + _random.nextInt(20) - 10)
            .clamp(3200, 3900),
      );

      state = state.copyWith(kpis: kpiChange);
    });
  }

  void changeHospital(String val) {
    state = state.copyWith(selectedHospital: val);
  }

  void changeFacilityType(String val) {
    state = state.copyWith(selectedFacilityType: val);
  }

  void changeDistrict(String val) {
    state = state.copyWith(selectedDistrict: val);
  }

  void changeTimePeriod(String val) {
    state = state.copyWith(selectedTimePeriod: val);
  }

  void sortScorecard(String sortBy) {
    final list = List<HospitalScorecardItem>.from(state.scorecardItems);
    if (sortBy == 'Hospital') {
      list.sort((a, b) => a.name.compareTo(b.name));
    } else if (sortBy == 'Beds') {
      list.sort((a, b) => b.beds.compareTo(a.beds));
    } else if (sortBy == 'Occupancy') {
      list.sort((a, b) => b.occupancyPercent.compareTo(a.occupancyPercent));
    } else if (sortBy == 'OPD') {
      list.sort((a, b) => b.opdPerDay.compareTo(a.opdPerDay));
    } else if (sortBy == 'Surgeries') {
      list.sort((a, b) => b.surgeriesPerMonth.compareTo(a.surgeriesPerMonth));
    } else if (sortBy == 'CSAT') {
      list.sort((a, b) => b.csat.compareTo(a.csat));
    }
    state = state.copyWith(sortBy: sortBy, scorecardItems: list);
  }

  Future<void> refresh() async {
    if (state.isRefreshing) return;
    state = state.copyWith(isRefreshing: true);

    await Future<void>.delayed(const Duration(milliseconds: 1000));

    final updatedKpis = state.kpis.copyWith(
      bedOccupancyPercent: 73.0 + _random.nextDouble() * 3,
      icuOccupancyPercent: 86.0 + _random.nextDouble() * 3,
      dailyOpd: 52000 + _random.nextInt(1000),
      dailyIpdAdmissions: 3750 + _random.nextInt(150),
      surgeriesToday: 1200 + _random.nextInt(100),
      patientSatisfactionScore: 4.0 + _random.nextDouble() * 0.2,
      equipmentUptimePercent: 91.0 + _random.nextDouble() * 1.5,
    );

    final updatedScorecard = state.scorecardItems.map((item) {
      final occOffset = _random.nextInt(6) - 3;
      final opdOffset = _random.nextInt(100) - 50;
      return item.copyWith(
        occupancyPercent: (item.occupancyPercent + occOffset).clamp(50, 110),
        opdPerDay: (item.opdPerDay + opdOffset).clamp(300, 4000),
      );
    }).toList();

    state = state.copyWith(
      isRefreshing: false,
      kpis: updatedKpis,
      scorecardItems: updatedScorecard,
    );

    sortScorecard(state.sortBy);
  }

  @override
  void dispose() {
    _telemetryTimer?.cancel();
    super.dispose();
  }

  // --- Initial Mock Data ---
  static const _initialKpis = HospitalPerformanceKpis(
    activeHospitals: 247,
    totalBeds: 18420,
    bedOccupancyPercent: 74.3,
    icuOccupancyPercent: 87.6,
    otUtilisationPercent: 78.4,
    ventilatorUtilisationPercent: 62.8,
    dailyOpd: 52840,
    dailyIpdAdmissions: 3847,
    dailyDischarges: 3612,
    surgeriesToday: 1248,
    avgLengthOfStay: 4.2,
    referralsOutMtd: 4218,
    patientSatisfactionScore: 4.1,
    readmissionRate30Day: 4.2,
    hospitalAcquiredInfectionsRate: 0.8,
    nabhAccreditedCount: 14,
    equipmentUptimePercent: 91.4,
  );

  static const List<HospitalScorecardItem> _initialScorecard = [
    HospitalScorecardItem(
      name: 'AIIMS Rishikesh',
      type: 'Medical College',
      beds: 1500,
      occupancyPercent: 91,
      opdPerDay: 3200,
      surgeriesPerMonth: 480,
      avgLos: 5.2,
      csat: 4.6,
      readmissionPercent: 3.1,
      equipmentUptimePercent: 96,
      nabhAccredited: true,
      grade: 'A',
    ),
    HospitalScorecardItem(
      name: 'Doon Hospital, Ddn',
      type: 'District Hospital',
      beds: 700,
      occupancyPercent: 103,
      opdPerDay: 1840,
      surgeriesPerMonth: 220,
      avgLos: 4.1,
      csat: 3.9,
      readmissionPercent: 4.8,
      equipmentUptimePercent: 88,
      nabhAccredited: true,
      grade: 'B',
    ),
    HospitalScorecardItem(
      name: 'Haldwani Base Hospital',
      type: 'Medical College',
      beds: 960,
      occupancyPercent: 88,
      opdPerDay: 2100,
      surgeriesPerMonth: 380,
      avgLos: 4.8,
      csat: 4.2,
      readmissionPercent: 3.8,
      equipmentUptimePercent: 92,
      nabhAccredited: true,
      grade: 'A',
    ),
    HospitalScorecardItem(
      name: 'Srinagar Govt. Medical',
      type: 'Medical College',
      beds: 740,
      occupancyPercent: 84,
      opdPerDay: 1680,
      surgeriesPerMonth: 290,
      avgLos: 4.5,
      csat: 4,
      readmissionPercent: 4.1,
      equipmentUptimePercent: 89,
      nabhAccredited: true,
      grade: 'B',
    ),
    HospitalScorecardItem(
      name: 'Haridwar Dist. Hospital',
      type: 'District Hospital',
      beds: 480,
      occupancyPercent: 78,
      opdPerDay: 1420,
      surgeriesPerMonth: 140,
      avgLos: 3.9,
      csat: 3.7,
      readmissionPercent: 5.2,
      equipmentUptimePercent: 82,
      nabhAccredited: false,
      grade: 'B',
    ),
    HospitalScorecardItem(
      name: 'Almora Dist. Hospital',
      type: 'District Hospital',
      beds: 320,
      occupancyPercent: 72,
      opdPerDay: 980,
      surgeriesPerMonth: 95,
      avgLos: 4,
      csat: 3.8,
      readmissionPercent: 4.6,
      equipmentUptimePercent: 78,
      nabhAccredited: false,
      grade: 'C',
    ),
    HospitalScorecardItem(
      name: 'Udham S Nagar DH',
      type: 'District Hospital',
      beds: 420,
      occupancyPercent: 80,
      opdPerDay: 1240,
      surgeriesPerMonth: 120,
      avgLos: 3.8,
      csat: 3.9,
      readmissionPercent: 4.3,
      equipmentUptimePercent: 84,
      nabhAccredited: false,
      grade: 'B',
    ),
    HospitalScorecardItem(
      name: 'Tehri Dist. Hospital',
      type: 'District Hospital',
      beds: 280,
      occupancyPercent: 68,
      opdPerDay: 720,
      surgeriesPerMonth: 72,
      avgLos: 4.2,
      csat: 3.6,
      readmissionPercent: 5,
      equipmentUptimePercent: 75,
      nabhAccredited: false,
      grade: 'C',
    ),
    HospitalScorecardItem(
      name: 'Pauri Dist. Hospital',
      type: 'District Hospital',
      beds: 260,
      occupancyPercent: 65,
      opdPerDay: 680,
      surgeriesPerMonth: 64,
      avgLos: 3.9,
      csat: 3.7,
      readmissionPercent: 4.8,
      equipmentUptimePercent: 74,
      nabhAccredited: false,
      grade: 'C',
    ),
    HospitalScorecardItem(
      name: 'Pithoragarh DH',
      type: 'District Hospital',
      beds: 240,
      occupancyPercent: 58,
      opdPerDay: 540,
      surgeriesPerMonth: 48,
      avgLos: 4.4,
      csat: 3.4,
      readmissionPercent: 5.8,
      equipmentUptimePercent: 62,
      nabhAccredited: false,
      grade: 'D',
    ),
    HospitalScorecardItem(
      name: 'Chamoli Dist. Hospital',
      type: 'District Hospital',
      beds: 220,
      occupancyPercent: 61,
      opdPerDay: 580,
      surgeriesPerMonth: 52,
      avgLos: 4.1,
      csat: 3.5,
      readmissionPercent: 5.4,
      equipmentUptimePercent: 68,
      nabhAccredited: false,
      grade: 'D',
    ),
    HospitalScorecardItem(
      name: 'Rudraprayag DH',
      type: 'District Hospital',
      beds: 180,
      occupancyPercent: 64,
      opdPerDay: 480,
      surgeriesPerMonth: 41,
      avgLos: 3.7,
      csat: 3.6,
      readmissionPercent: 5.1,
      equipmentUptimePercent: 71,
      nabhAccredited: false,
      grade: 'C',
    ),
  ];

  static const List<HospitalPerformanceAlert> _initialCriticalAlerts = [
    HospitalPerformanceAlert(
      msg:
          'Doon Hospital, Dehradun — Bed occupancy at 103%. Overflow protocol activated. 38 patients in corridor beds. CMO informed.',
      time: 'Today 09:30 AM',
    ),
    HospitalPerformanceAlert(
      msg:
          'Pithoragarh Dist. Hospital — MRI machine down since May 12. Patients being redirected to Haldwani. Maintenance team ETA: 3 days.',
      time: 'Today 08:45 AM',
    ),
    HospitalPerformanceAlert(
      msg:
          'Haridwar Dist. Hospital — 2 ventilators offline (VM-007, VM-014). Emergency procurement initiated. Currently 0 spare ventilators.',
      time: 'Today 07:55 AM',
    ),
  ];

  static const List<HospitalPerformanceAlert> _initialWatchAlerts = [
    HospitalPerformanceAlert(
      msg:
          'AIIMS Rishikesh — ICU occupancy at 96%. All elective ICU admissions deferred. Emergency cases only.',
      time: 'Today 09:10 AM',
    ),
    HospitalPerformanceAlert(
      msg:
          'State readmission rate at 4.2%. Pithoragarh (5.8%) and Chamoli (5.4%) above 5% benchmark — care quality review initiated.',
      time: 'Today 08:20 AM',
    ),
    HospitalPerformanceAlert(
      msg:
          'NABH accreditation due for renewal: Doon Hospital (June 30), Haridwar DH (Aug 15). Documentation teams engaged.',
      time: 'Today 07:00 AM',
    ),
    HospitalPerformanceAlert(
      msg:
          'Equipment utilisation below 70% at 3 CHC hospitals. Preventive maintenance schedule review recommended.',
      time: 'Yesterday 06:00 PM',
    ),
  ];
}

final hospitalPerformanceProvider =
    StateNotifierProvider<
      HospitalPerformanceNotifier,
      HospitalPerformanceState
    >((ref) {
      return HospitalPerformanceNotifier();
    });
