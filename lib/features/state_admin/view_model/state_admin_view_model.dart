import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/features/state_admin/model/state_admin_model.dart';

class StateAdminState {
  const StateAdminState({
    required this.activeTab,
    required this.selectedYear,
    required this.selectedMonth,
    required this.selectedDistrict,
    required this.selectedFacilityType,
    required this.isRefreshing,
    required this.sortBy,
    required this.kpis,
    required this.districts,
    required this.alerts,
  });

  final String activeTab;
  final String selectedYear;
  final String selectedMonth;
  final String selectedDistrict;
  final String selectedFacilityType;
  final bool isRefreshing;
  final String sortBy;
  final StateAdminKpis kpis;
  final List<DistrictOverviewItem> districts;
  final List<AdminAlert> alerts;

  StateAdminState copyWith({
    String? activeTab,
    String? selectedYear,
    String? selectedMonth,
    String? selectedDistrict,
    String? selectedFacilityType,
    bool? isRefreshing,
    String? sortBy,
    StateAdminKpis? kpis,
    List<DistrictOverviewItem>? districts,
    List<AdminAlert>? alerts,
  }) {
    return StateAdminState(
      activeTab: activeTab ?? this.activeTab,
      selectedYear: selectedYear ?? this.selectedYear,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedFacilityType: selectedFacilityType ?? this.selectedFacilityType,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      sortBy: sortBy ?? this.sortBy,
      kpis: kpis ?? this.kpis,
      districts: districts ?? this.districts,
      alerts: alerts ?? this.alerts,
    );
  }
}

class StateAdminNotifier extends StateNotifier<StateAdminState> {
  StateAdminNotifier()
      : super(
          StateAdminState(
            activeTab: 'overview',
            selectedYear: 'FY 2024-25',
            selectedMonth: 'Mar',
            selectedDistrict: 'All Districts',
            selectedFacilityType: 'All Facility Types',
            isRefreshing: false,
            sortBy: 'Score',
            kpis: const StateAdminKpis(
              totalFacilities: 1847,
              opdToday: 68241,
              ipdAdmissions: 12847,
              emergencies24h: 3429,
              revenueMtdCr: 42.7,
              abBeneficiaries: 8341,
              maternalDeathsMtd: 4,
              activeDoctors: 4218,
              ambulanceCalls24h: 2147,
              labTests24h: 31480,
              deliveriesMtd: 3847,
              abClaimsPending: 1247,
            ),
            districts: _initialDistricts,
            alerts: _initialAlerts,
          ),
        ) {
    _startSimulationTimer();
  }

  Timer? _simTimer;
  final _random = Random();

  void _startSimulationTimer() {
    _simTimer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (state.isRefreshing) return;
      // Fluctuates active doctors and today's OPD load to show live connection
      final opdOffset = _random.nextInt(300) - 150;
      final doctorsOffset = _random.nextInt(30) - 15;
      final revenueOffset = (_random.nextInt(20) - 10) / 10.0;

      state = state.copyWith(
        kpis: StateAdminKpis(
          totalFacilities: state.kpis.totalFacilities,
          opdToday: (state.kpis.opdToday + opdOffset).clamp(65000, 72000),
          ipdAdmissions: state.kpis.ipdAdmissions,
          emergencies24h: state.kpis.emergencies24h,
          revenueMtdCr: (state.kpis.revenueMtdCr + revenueOffset).clamp(38.0, 48.0),
          abBeneficiaries: state.kpis.abBeneficiaries,
          maternalDeathsMtd: state.kpis.maternalDeathsMtd,
          activeDoctors: (state.kpis.activeDoctors + doctorsOffset).clamp(4100, 4350),
          ambulanceCalls24h: state.kpis.ambulanceCalls24h,
          labTests24h: state.kpis.labTests24h,
          deliveriesMtd: state.kpis.deliveriesMtd,
          abClaimsPending: state.kpis.abClaimsPending,
        ),
      );
    });
  }

  void changeTab(String val) {
    state = state.copyWith(activeTab: val);
  }

  void changeYear(String val) {
    state = state.copyWith(selectedYear: val);
  }

  void changeMonth(String val) {
    state = state.copyWith(selectedMonth: val);
  }

  void changeDistrict(String val) {
    state = state.copyWith(selectedDistrict: val);
  }

  void changeFacilityType(String val) {
    state = state.copyWith(selectedFacilityType: val);
  }

  void sortDistricts(String sortBy) {
    final list = List<DistrictOverviewItem>.from(state.districts);
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

    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 1000));

    final updatedDistricts = state.districts.map((d) {
      final opdOffset = _random.nextInt(60) - 30;
      final scoreOffset = _random.nextInt(3) - 1;
      return d.copyWith(
        dailyOpd: (d.dailyOpd + opdOffset).clamp(300, 5000),
        score: (d.score + scoreOffset).clamp(40, 98),
      );
    }).toList();

    state = state.copyWith(
      isRefreshing: false,
      districts: updatedDistricts,
      kpis: StateAdminKpis(
        totalFacilities: state.kpis.totalFacilities,
        opdToday: 68000 + _random.nextInt(800),
        ipdAdmissions: 12000 + _random.nextInt(1000),
        emergencies24h: 3000 + _random.nextInt(500),
        revenueMtdCr: 41.5 + (_random.nextInt(20) / 10.0),
        abBeneficiaries: 8000 + _random.nextInt(500),
        maternalDeathsMtd: 3 + _random.nextInt(3),
        activeDoctors: 4150 + _random.nextInt(100),
        ambulanceCalls24h: 2000 + _random.nextInt(200),
        labTests24h: 30000 + _random.nextInt(2000),
        deliveriesMtd: 3700 + _random.nextInt(300),
        abClaimsPending: 1100 + _random.nextInt(200),
      ),
    );

    sortDistricts(state.sortBy);
  }

  @override
  void dispose() {
    _simTimer?.cancel();
    super.dispose();
  }

  static final List<DistrictOverviewItem> _initialDistricts = [
    const DistrictOverviewItem(name: 'Dehradun', facilitiesCount: 147, dailyOpd: 4200, bedOccupancyPercent: 92, mmr: 72, abClaimsCount: 2840, score: 82, performance: 'Good'),
    const DistrictOverviewItem(name: 'Haridwar', facilitiesCount: 124, dailyOpd: 3100, bedOccupancyPercent: 98, mmr: 81, abClaimsCount: 2120, score: 61, performance: 'Critical'),
    const DistrictOverviewItem(name: 'Nainital', facilitiesCount: 98, dailyOpd: 1800, bedOccupancyPercent: 88, mmr: 84, abClaimsCount: 1420, score: 71, performance: 'Average'),
    const DistrictOverviewItem(name: 'Udham Singh Nagar', facilitiesCount: 112, dailyOpd: 2900, bedOccupancyPercent: 91, mmr: 88, abClaimsCount: 1950, score: 76, performance: 'Good'),
    const DistrictOverviewItem(name: 'Almora', facilitiesCount: 84, dailyOpd: 1200, bedOccupancyPercent: 82, mmr: 96, abClaimsCount: 820, score: 65, performance: 'Average'),
    const DistrictOverviewItem(name: 'Pauri', facilitiesCount: 96, dailyOpd: 760, bedOccupancyPercent: 80, mmr: 98, abClaimsCount: 620, score: 62, performance: 'Poor'),
    const DistrictOverviewItem(name: 'Tehri', facilitiesCount: 88, dailyOpd: 820, bedOccupancyPercent: 85, mmr: 92, abClaimsCount: 680, score: 68, performance: 'Average'),
    const DistrictOverviewItem(name: 'Chamoli', facilitiesCount: 72, dailyOpd: 680, bedOccupancyPercent: 74, mmr: 108, abClaimsCount: 420, score: 54, performance: 'Poor'),
  ];

  static final List<AdminAlert> _initialAlerts = [
    const AdminAlert(msg: 'Dengue cases surge +34% in Haridwar — 47 new cases this week', time: '5 min ago', severity: 'crit'),
    const AdminAlert(msg: 'Blood O− stock critically low in 3 facilities: AIIMS Rishikesh, Doon Hospital, Haldwani', time: '12 min ago', severity: 'crit'),
    const AdminAlert(msg: 'Chamoli CHC oxygen supply below 20% — resupply scheduled 14 Apr', time: '20 min ago', severity: 'crit'),
    const AdminAlert(msg: 'Ayushman Bharat claims pending >30 days: 1,247 cases requiring SHA review', time: '1 hr ago', severity: 'warn'),
  ];
}

final stateAdminProvider =
    StateNotifierProvider<StateAdminNotifier, StateAdminState>((ref) {
  return StateAdminNotifier();
});
