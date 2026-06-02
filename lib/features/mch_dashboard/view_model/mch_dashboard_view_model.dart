import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/features/mch_dashboard/model/mch_dashboard_model.dart';

class MchDashboardState {
  MchDashboardState({
    required this.kpiData,
    required this.programs,
    required this.scorecards,
    required this.hrpRegister,
    this.isLoading = false,
  });

  final MchKpiData kpiData;
  final List<MchProgramItem> programs;
  final List<MchDistrictScorecardItem> scorecards;
  final List<HrpRegisterItem> hrpRegister;
  final bool isLoading;

  MchDashboardState copyWith({
    MchKpiData? kpiData,
    List<MchProgramItem>? programs,
    List<MchDistrictScorecardItem>? scorecards,
    List<HrpRegisterItem>? hrpRegister,
    bool? isLoading,
  }) {
    return MchDashboardState(
      kpiData: kpiData ?? this.kpiData,
      programs: programs ?? this.programs,
      scorecards: scorecards ?? this.scorecards,
      hrpRegister: hrpRegister ?? this.hrpRegister,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class MchDashboardNotifier extends StateNotifier<MchDashboardState> {
  MchDashboardNotifier() : super(_initialState()) {
    _startTimer();
  }

  Timer? _timer;
  final _random = Random();

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 6), (_) {
      _jitterData();
    });
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 1000));
    state = _initialState().copyWith(isLoading: false);
  }

  void _jitterData() {
    final kpi = state.kpiData;
    final shiftDeliveries = _random.nextInt(5) - 2;
    final shiftAnc = _random.nextInt(7) - 3;
    final shiftHrp = _random.nextInt(3) - 1;

    final updatedKpis = kpi.copyWith(
      instDeliveriesPercent: (kpi.instDeliveriesPercent + (shiftDeliveries * 0.05)).clamp(80.0, 99.0),
      ancRegistrations: kpi.ancRegistrations + shiftAnc,
      hrPregnancies: kpi.hrPregnancies + shiftHrp,
      jsyBeneficiaries: kpi.jsyBeneficiaries + (_random.nextInt(3) - 1),
    );

    state = state.copyWith(kpiData: updatedKpis);
  }

  static MchDashboardState _initialState() {
    return MchDashboardState(
      kpiData: const MchKpiData(
        mmrRate: 112,
        instDeliveriesPercent: 94.2,
        ancRegistrations: 18420,
        fourAncPercent: 72.8,
        hrPregnancies: 2847,
        cSectionPercent: 18.4,
        jsyBeneficiaries: 8412,
        anaemiaPercent: 42.6,
        imrRate: 28,
        fullImmunisationPercent: 94.7,
        neonatalDeathsMtd: 38,
        samChildren: 4218,
        mamChildren: 12840,
        sncuAdmissions: 84,
        exclusiveBreastfeedPercent: 68.4,
        stuntingPercent: 31.4,
      ),
      programs: const [
        MchProgramItem(name: 'PMSMA (ANC)', iconCode: 0xe122, themeHex: 'F72585', done: 14218, total: 18420, pct: 77),
        MchProgramItem(name: 'JSY Payments', iconCode: 0xf0d6, themeHex: '00B4D8', done: 8412, total: 9840, pct: 85),
        MchProgramItem(name: 'JSSK Scheme', iconCode: 0xe5f9, themeHex: '00C897', done: 11840, total: 12847, pct: 92),
        MchProgramItem(name: 'Immunisation', iconCode: 0xe5f9, themeHex: 'FFD166', done: 94.7, total: 100, pct: 95, isPercent: true),
        MchProgramItem(name: 'Vitamin A Sup.', iconCode: 0xe5f9, themeHex: 'C77DFF', done: 82.4, total: 100, pct: 82, isPercent: true),
        MchProgramItem(name: 'Iron Syrup', iconCode: 0xe5f9, themeHex: 'F77F00', done: 76.8, total: 100, pct: 77, isPercent: true),
        MchProgramItem(name: 'POSHAN 2.0', iconCode: 0xe5f9, themeHex: '10B981', done: 68.4, total: 100, pct: 68, isPercent: true),
        MchProgramItem(name: 'NRC Admissions', iconCode: 0xe5f9, themeHex: '4361EE', done: 4218, total: 5000, pct: 84),
      ],
      scorecards: const [
        MchDistrictScorecardItem(district: 'Dehradun', mmr: 84, imr: 22, instDel: 96, anc4: 82, fullImmun: 96, sam: 284, jsy: 94, grade: 'A'),
        MchDistrictScorecardItem(district: 'Haridwar', mmr: 108, imr: 28, instDel: 94, anc4: 76, fullImmun: 94, sam: 524, jsy: 88, grade: 'B'),
        MchDistrictScorecardItem(district: 'Rishikesh', mmr: 76, imr: 18, instDel: 97, anc4: 88, fullImmun: 97, sam: 184, jsy: 96, grade: 'A'),
        MchDistrictScorecardItem(district: 'Almora', mmr: 148, imr: 36, instDel: 82, anc4: 64, fullImmun: 86, sam: 284, jsy: 76, grade: 'C'),
        MchDistrictScorecardItem(district: 'Pithoragarh', mmr: 184, imr: 42, instDel: 74, anc4: 58, fullImmun: 82, sam: 248, jsy: 68, grade: 'C'),
        MchDistrictScorecardItem(district: 'Chamoli', mmr: 196, imr: 48, instDel: 68, anc4: 52, fullImmun: 78, sam: 184, jsy: 62, grade: 'D'),
      ],
      hrpRegister: const [
        HrpRegisterItem(name: 'Kamla Devi', age: 34, weeks: 28, riskFactor: 'Severe Anaemia (Hb 6.8) + GDM', district: 'Pithoragarh', facility: 'District Hospital', status: 'CRITICAL ALERT'),
        HrpRegisterItem(name: 'Sita Bisht', age: 19, weeks: 32, riskFactor: 'Pre-Eclampsia (BP 160/105)', district: 'Chamoli', facility: 'CHC Joshimath', status: 'IMMEDIATE FOLLOW-UP'),
        HrpRegisterItem(name: 'Meena Thapa', age: 38, weeks: 14, riskFactor: 'Age >35 + Twin Pregnancy', district: 'Rudraprayag', facility: 'District Hospital', status: 'MONITORING'),
        HrpRegisterItem(name: 'Pooja Rawat', age: 26, weeks: 36, riskFactor: 'Previous C-Section + Breech', district: 'Pauri', facility: 'SDH Srinagar', status: 'STABLE WATCH'),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final mchDashboardProvider = StateNotifierProvider<MchDashboardNotifier, MchDashboardState>((ref) {
  return MchDashboardNotifier();
});
