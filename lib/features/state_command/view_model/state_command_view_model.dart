import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/features/state_command/model/state_command_model.dart';

class StateCommandState {
  const StateCommandState({
    required this.selectedDistrict,
    required this.selectedFacilityType,
    required this.selectedTimePeriod,
    required this.selectedScheme,
    required this.liveOpdCount,
    required this.isRefreshing,
    required this.sortBy,
    required this.districts,
    required this.criticalAlerts,
    required this.watchAlerts,
  });

  final String selectedDistrict;
  final String selectedFacilityType;
  final String selectedTimePeriod;
  final String selectedScheme;
  final int liveOpdCount;
  final bool isRefreshing;
  final String sortBy;
  final List<DistrictScorecardItem> districts;
  final List<LiveAlertItem> criticalAlerts;
  final List<LiveAlertItem> watchAlerts;

  StateCommandState copyWith({
    String? selectedDistrict,
    String? selectedFacilityType,
    String? selectedTimePeriod,
    String? selectedScheme,
    int? liveOpdCount,
    bool? isRefreshing,
    String? sortBy,
    List<DistrictScorecardItem>? districts,
    List<LiveAlertItem>? criticalAlerts,
    List<LiveAlertItem>? watchAlerts,
  }) {
    return StateCommandState(
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedFacilityType: selectedFacilityType ?? this.selectedFacilityType,
      selectedTimePeriod: selectedTimePeriod ?? this.selectedTimePeriod,
      selectedScheme: selectedScheme ?? this.selectedScheme,
      liveOpdCount: liveOpdCount ?? this.liveOpdCount,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      sortBy: sortBy ?? this.sortBy,
      districts: districts ?? this.districts,
      criticalAlerts: criticalAlerts ?? this.criticalAlerts,
      watchAlerts: watchAlerts ?? this.watchAlerts,
    );
  }
}

class StateCommandNotifier extends StateNotifier<StateCommandState> {
  StateCommandNotifier()
      : super(
          StateCommandState(
            selectedDistrict: 'All Districts',
            selectedFacilityType: 'All Facility Types',
            selectedTimePeriod: 'This Month — May 2025',
            selectedScheme: 'All Schemes',
            liveOpdCount: 14823,
            isRefreshing: false,
            sortBy: 'Score',
            districts: _initialDistricts,
            criticalAlerts: _initialCriticalAlerts,
            watchAlerts: _initialWatchAlerts,
          ),
        ) {
    _startOpdTimer();
  }

  Timer? _opdTimer;
  final _random = Random();

  void _startOpdTimer() {
    _opdTimer = Timer.periodic(const Duration(seconds: 8), (timer) {
      // Simulate live fluctuation in daily OPD registrations
      final change = _random.nextInt(300) - 150;
      final newOpd = (state.liveOpdCount + change).clamp(13500, 16000);
      state = state.copyWith(liveOpdCount: newOpd);
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

  void changeScheme(String val) {
    state = state.copyWith(selectedScheme: val);
  }

  void sortDistricts(String sortBy) {
    final list = List<DistrictScorecardItem>.from(state.districts);
    if (sortBy == 'Score') {
      list.sort((a, b) => b.score.compareTo(a.score));
    } else if (sortBy == 'OPD') {
      list.sort((a, b) => b.dailyOpd.compareTo(a.dailyOpd));
    } else if (sortBy == 'AB Claims') {
      list.sort((a, b) => b.abClaimsCount.compareTo(a.abClaimsCount));
    } else if (sortBy == 'MMR') {
      list.sort((a, b) => b.mmr.compareTo(a.mmr));
    }
    state = state.copyWith(sortBy: sortBy, districts: list);
  }

  Future<void> refresh() async {
    if (state.isRefreshing) return;
    state = state.copyWith(isRefreshing: true);

    // Simulate 1 second network refresh latency
    await Future<void>.delayed(const Duration(milliseconds: 1000));

    // Fluctuate stats slightly to make dashboard feel alive on refresh
    final updatedDistricts = state.districts.map((d) {
      final opdOffset = _random.nextInt(100) - 50;
      final scoreOffset = _random.nextInt(4) - 2;
      return d.copyWith(
        dailyOpd: (d.dailyOpd + opdOffset).clamp(300, 5000),
        score: (d.score + scoreOffset).clamp(40, 95),
      );
    }).toList();

    state = state.copyWith(
      isRefreshing: false,
      liveOpdCount: 14000 + _random.nextInt(1500),
      districts: updatedDistricts,
    );

    // Re-apply current sorting
    sortDistricts(state.sortBy);
  }

  @override
  void dispose() {
    _opdTimer?.cancel();
    super.dispose();
  }

  // --- Static Initial Mock Data ---

  static final List<DistrictScorecardItem> _initialDistricts = [
    const DistrictScorecardItem(name: 'Dehradun', facilitiesCount: 147, dailyOpd: 4200, bedOccupancyPercent: 92, icuOccupancyPercent: 94, mmr: 72, abClaimsCount: 2840, medicineAvailabilityPercent: 94, performance: 'Good', score: 82),
    const DistrictScorecardItem(name: 'Haridwar', facilitiesCount: 124, dailyOpd: 3100, bedOccupancyPercent: 98, icuOccupancyPercent: 98, mmr: 81, abClaimsCount: 2120, medicineAvailabilityPercent: 90, performance: 'Critical', score: 61),
    const DistrictScorecardItem(name: 'Rishikesh', facilitiesCount: 48, dailyOpd: 1840, bedOccupancyPercent: 87, icuOccupancyPercent: 88, mmr: 68, abClaimsCount: 1840, medicineAvailabilityPercent: 95, performance: 'Good', score: 79),
    const DistrictScorecardItem(name: 'Nainital', facilitiesCount: 98, dailyOpd: 1800, bedOccupancyPercent: 88, icuOccupancyPercent: 85, mmr: 84, abClaimsCount: 1420, medicineAvailabilityPercent: 92, performance: 'Average', score: 71),
    const DistrictScorecardItem(name: 'Tehri', facilitiesCount: 84, dailyOpd: 820, bedOccupancyPercent: 85, icuOccupancyPercent: 80, mmr: 92, abClaimsCount: 680, medicineAvailabilityPercent: 89, performance: 'Average', score: 68),
    const DistrictScorecardItem(name: 'Almora', facilitiesCount: 112, dailyOpd: 1200, bedOccupancyPercent: 82, icuOccupancyPercent: 78, mmr: 96, abClaimsCount: 820, medicineAvailabilityPercent: 88, performance: 'Average', score: 65),
    const DistrictScorecardItem(name: 'Pauri', facilitiesCount: 96, dailyOpd: 760, bedOccupancyPercent: 80, icuOccupancyPercent: 76, mmr: 98, abClaimsCount: 620, medicineAvailabilityPercent: 87, performance: 'Poor', score: 62),
    const DistrictScorecardItem(name: 'Pithoragarh', facilitiesCount: 88, dailyOpd: 900, bedOccupancyPercent: 79, icuOccupancyPercent: 74, mmr: 102, abClaimsCount: 580, medicineAvailabilityPercent: 85, performance: 'Poor', score: 59),
    const DistrictScorecardItem(name: 'Chamoli', facilitiesCount: 72, dailyOpd: 680, bedOccupancyPercent: 74, icuOccupancyPercent: 70, mmr: 108, abClaimsCount: 420, medicineAvailabilityPercent: 82, performance: 'Poor', score: 54),
    const DistrictScorecardItem(name: 'Uttarkashi', facilitiesCount: 68, dailyOpd: 720, bedOccupancyPercent: 71, icuOccupancyPercent: 68, mmr: 112, abClaimsCount: 380, medicineAvailabilityPercent: 80, performance: 'Poor', score: 51),
    const DistrictScorecardItem(name: 'Champawat', facilitiesCount: 58, dailyOpd: 380, bedOccupancyPercent: 75, icuOccupancyPercent: 67, mmr: 114, abClaimsCount: 320, medicineAvailabilityPercent: 81, performance: 'Poor', score: 52),
    const DistrictScorecardItem(name: 'Bageshwar', facilitiesCount: 54, dailyOpd: 420, bedOccupancyPercent: 73, icuOccupancyPercent: 65, mmr: 118, abClaimsCount: 280, medicineAvailabilityPercent: 78, performance: 'Poor', score: 48),
    const DistrictScorecardItem(name: 'Rudraprayag', facilitiesCount: 42, dailyOpd: 480, bedOccupancyPercent: 68, icuOccupancyPercent: 62, mmr: 122, abClaimsCount: 240, medicineAvailabilityPercent: 79, performance: 'Poor', score: 47),
  ];

  static final List<LiveAlertItem> _initialCriticalAlerts = [
    const LiveAlertItem(icon: '🏥', cls: 'crit', title: 'ICU Overflow — Haridwar Dist. Hospital', description: 'Bed occupancy 98% · 3 patients waiting for ICU bed', time: '2 min ago'),
    const LiveAlertItem(icon: '🦠', cls: 'crit', title: 'Dengue Outbreak — Dehradun Zone 4', description: '47 new cases today · AI risk score: 8.2/10', time: '8 min ago'),
    const LiveAlertItem(icon: '💊', cls: 'crit', title: 'Medicine Shortage — 7 CHCs', description: 'Paracetamol IV, Oxytocin, Insulin — 0 stock', time: '15 min ago'),
    const LiveAlertItem(icon: '🚑', cls: 'crit', title: 'Ambulance Response Delay — Chamoli', description: '5 incidents >30 min response · Mountain terrain', time: '22 min ago'),
    const LiveAlertItem(icon: '🤰', cls: 'warn', title: 'High-Risk Pregnancy Alert — Pithoragarh', description: '12 new cases flagged by AI system', time: '31 min ago'),
  ];

  static final List<LiveAlertItem> _initialWatchAlerts = [
    const LiveAlertItem(icon: '📊', cls: 'warn', title: 'Bed occupancy >85% in 6 districts', description: 'Monitor for escalation — review capacity plan', time: '1 hr ago'),
    const LiveAlertItem(icon: '💉', cls: 'info', title: 'Vaccination coverage below target — Uttarkashi', description: 'Only 72% immunization coverage vs 90% target', time: '2 hr ago'),
    const LiveAlertItem(icon: '🧪', cls: 'info', title: 'Lab TAT exceeding 4hrs — 12 centres', description: 'Sample backlog at District Labs', time: '3 hr ago'),
    const LiveAlertItem(icon: '👥', cls: 'warn', title: 'Staff shortage — 3 CHCs in Chamoli', description: 'No doctor at PHC Tharali for 2 days', time: '4 hr ago'),
    const LiveAlertItem(icon: '📋', cls: 'ok', title: 'AB Claim batch processed — ₹3.2Cr', description: 'AIIMS Rishikesh · 847 claims approved', time: '5 hr ago'),
  ];
}

final stateCommandProvider =
    StateNotifierProvider<StateCommandNotifier, StateCommandState>((ref) {
  return StateCommandNotifier();
});
