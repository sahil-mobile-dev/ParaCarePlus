import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/features/ipd_beds/model/ipd_beds_model.dart';

class IpdBedsState {
  IpdBedsState({
    required this.kpiData,
    required this.wards,
    required this.ambulances,
    required this.scorecards,
    required this.erEvents,
    required this.transfers,
    this.isLoading = false,
  });

  final IpdKpiData kpiData;
  final List<WardStatusItem> wards;
  final List<AmbulanceItem> ambulances;
  final List<HospitalIpdScorecardItem> scorecards;
  final List<ErEventItem> erEvents;
  final List<TransferRequestItem> transfers;
  final bool isLoading;

  IpdBedsState copyWith({
    IpdKpiData? kpiData,
    List<WardStatusItem>? wards,
    List<AmbulanceItem>? ambulances,
    List<HospitalIpdScorecardItem>? scorecards,
    List<ErEventItem>? erEvents,
    List<TransferRequestItem>? transfers,
    bool? isLoading,
  }) {
    return IpdBedsState(
      kpiData: kpiData ?? this.kpiData,
      wards: wards ?? this.wards,
      ambulances: ambulances ?? this.ambulances,
      scorecards: scorecards ?? this.scorecards,
      erEvents: erEvents ?? this.erEvents,
      transfers: transfers ?? this.transfers,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class IpdBedsNotifier extends StateNotifier<IpdBedsState> {
  IpdBedsNotifier() : super(_initialState()) {
    _startTimer();
  }

  Timer? _timer;
  final _random = Random();

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
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
    // Jitter occupied/available beds slightly (keep total constant at 18420)
    final shift = _random.nextInt(15) - 7;
    final newOccupied = kpi.occupiedBeds + shift;
    final newAvailable = kpi.availableBeds - shift;

    final icuShift = _random.nextInt(5) - 2;
    final newIcuOccupied = (kpi.icuOccupied + icuShift).clamp(1000, kpi.icuBeds);

    final erShift = _random.nextInt(7) - 3;
    final newErPatients = (kpi.criticalCasesActive + erShift).clamp(20, 100);

    final waitShift = _random.nextInt(3) - 1;
    final newWaitTime = (kpi.erWaitMinutes + waitShift).clamp(10, 30);

    final admissions = kpi.dailyAdmissions + (_random.nextInt(5) - 2);

    final updatedKpis = kpi.copyWith(
      occupiedBeds: newOccupied,
      availableBeds: newAvailable,
      icuOccupied: newIcuOccupied,
      criticalCasesActive: newErPatients,
      erWaitMinutes: newWaitTime,
      dailyAdmissions: admissions,
    );

    // Jitter wards
    final updatedWards = state.wards.map((w) {
      if (_random.nextDouble() > 0.5) {
        final change = _random.nextInt(7) - 3;
        final newOcc = (w.occupied + change).clamp(0, w.total);
        return w.copyWith(occupied: newOcc);
      }
      return w;
    }).toList();

    state = state.copyWith(
      kpiData: updatedKpis,
      wards: updatedWards,
    );
  }

  static IpdBedsState _initialState() {
    return IpdBedsState(
      kpiData: const IpdKpiData(
        totalBeds: 18420,
        occupiedBeds: 13687,
        availableBeds: 4733,
        icuBeds: 1284,
        icuOccupied: 1125,
        hduBeds: 842,
        hduOccupied: 601,
        nicuBeds: 318,
        nicuOccupied: 217,
        alosDays: 4.2,
        bedTurnover: 6.4,
        dailyAdmissions: 3847,
        erVisitsToday: 4218,
        traumaCases: 287,
        ambResponseMinutes: 12.4,
        erWaitMinutes: 18,
        criticalCasesActive: 47,
        erDischargePercent: 68.4,
      ),
      wards: const [
        WardStatusItem(name: 'General Medicine', iconCode: 0xe5f9, occupied: 847, total: 1020, themeHex: '00B4D8'),
        WardStatusItem(name: 'Surgery', iconCode: 0xe5f9, occupied: 624, total: 780, themeHex: '00C897'),
        WardStatusItem(name: 'Orthopaedics', iconCode: 0xe5f9, occupied: 412, total: 520, themeHex: 'FFD166'),
        WardStatusItem(name: 'Gynaecology', iconCode: 0xe5f9, occupied: 384, total: 480, themeHex: 'F72585'),
        WardStatusItem(name: 'Paediatrics', iconCode: 0xe5f9, occupied: 298, total: 380, themeHex: '4361EE'),
        WardStatusItem(name: 'Cardiology (CCU)', iconCode: 0xe5f9, occupied: 186, total: 200, themeHex: 'FF4D6D'),
        WardStatusItem(name: 'Neurology', iconCode: 0xe5f9, occupied: 142, total: 180, themeHex: 'C77DFF'),
        WardStatusItem(name: 'Oncology', iconCode: 0xe5f9, occupied: 167, total: 200, themeHex: 'F77F00'),
        WardStatusItem(name: 'Burns', iconCode: 0xe5f9, occupied: 74, total: 100, themeHex: 'FF4D6D'),
        WardStatusItem(name: 'ICU (General)', iconCode: 0xe5f9, occupied: 418, total: 460, themeHex: 'C77DFF'),
        WardStatusItem(name: 'NICU', iconCode: 0xe5f9, occupied: 217, total: 318, themeHex: '0D9488'),
        WardStatusItem(name: 'HDU', iconCode: 0xe5f9, occupied: 601, total: 842, themeHex: '3A86FF'),
        WardStatusItem(name: 'Isolation', iconCode: 0xe5f9, occupied: 184, total: 240, themeHex: 'FFD166'),
        WardStatusItem(name: 'Psychiatry', iconCode: 0xe5f9, occupied: 98, total: 140, themeHex: '00B4D8'),
        WardStatusItem(name: 'Geriatrics', iconCode: 0xe5f9, occupied: 112, total: 160, themeHex: '00C897'),
        WardStatusItem(name: 'Emergency Obs.', iconCode: 0xe5f9, occupied: 89, total: 120, themeHex: 'FF4D6D'),
      ],
      ambulances: const [
        AmbulanceItem(vehicleNo: 'UK-07-TA-1234', driver: 'Rajesh Negi', status: 'Active', patientName: 'Amit Rawat', location: 'NH-58 near Roorkee', etaMinutes: 4),
        AmbulanceItem(vehicleNo: 'UK-07-TA-5678', driver: 'Vikram Singh', status: 'Dispatch', patientName: 'Sita Devi', location: 'Dehradun Bypass', etaMinutes: 8),
        AmbulanceItem(vehicleNo: 'UK-08-TA-2468', driver: 'Satish Kumar', status: 'Returning', patientName: 'None', location: 'Returning to Base 3', etaMinutes: 12),
        AmbulanceItem(vehicleNo: 'UK-07-TA-1357', driver: 'Manish Joshi', status: 'Maintenance', patientName: 'None', location: 'Workshop Haridwar', etaMinutes: 0),
        AmbulanceItem(vehicleNo: 'UK-12-TA-8899', driver: 'Karan Thapa', status: 'Critical', patientName: 'Sanjay Pant', location: 'Roorkee Highway Accident', etaMinutes: 2),
      ],
      scorecards: const [
        HospitalIpdScorecardItem(name: 'Doon Medical College', district: 'Dehradun', beds: 750, occupancyPercent: 88.4, admissions: 142, discharges: 120, grade: 'A'),
        HospitalIpdScorecardItem(name: 'District Hospital Haridwar', district: 'Haridwar', beds: 450, occupancyPercent: 91.2, admissions: 98, discharges: 85, grade: 'B'),
        HospitalIpdScorecardItem(name: 'SDRF Base Hospital', district: 'Rishikesh', beds: 300, occupancyPercent: 64.6, admissions: 42, discharges: 52, grade: 'C'),
        HospitalIpdScorecardItem(name: 'Base Hospital Almora', district: 'Almora', beds: 350, occupancyPercent: 72.8, admissions: 58, discharges: 61, grade: 'B'),
        HospitalIpdScorecardItem(name: 'SNCU Pithoragarh', district: 'Pithoragarh', beds: 150, occupancyPercent: 82.0, admissions: 30, discharges: 24, grade: 'B'),
        HospitalIpdScorecardItem(name: 'CHC Joshimath', district: 'Chamoli', beds: 80, occupancyPercent: 48.6, admissions: 12, discharges: 18, grade: 'D'),
      ],
      erEvents: const [
        ErEventItem(time: '15:45', type: 'Trauma', message: 'Roorkee NH-58: 4 casualties received. 2 admitted to ICU, 2 stable.', status: 'Admitted'),
        ErEventItem(time: '15:20', type: 'Cardiac', message: 'Elderly male with acute MI. Direct balloon angioplasty successful.', status: 'Stable'),
        ErEventItem(time: '14:50', type: 'Maternity', message: 'Eclamptic mother referred from CHC. Emergency C-section performed.', status: 'Admitted'),
        ErEventItem(time: '14:15', type: 'Pediatric', message: 'Severe respiratory distress in 8mo infant. Placed on high-flow nasal cannula.', status: 'Critical'),
      ],
      transfers: const [
        TransferRequestItem(accession: 'XFER-098', patient: 'Mohan Singh', fromWard: 'Emergency Obs.', toWard: 'General Medicine', priority: 'Urgent', status: 'Pending Approval'),
        TransferRequestItem(accession: 'XFER-097', patient: 'Savita Devi', fromWard: 'Surgery Ward', toWard: 'HDU', priority: 'STAT', status: 'Approved (En Route)'),
        TransferRequestItem(accession: 'XFER-096', patient: 'Arjun Bist', fromWard: 'ICU (General)', toWard: 'General Medicine', priority: 'Routine', status: 'Pending Bed Assignment'),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final ipdBedsProvider = StateNotifierProvider<IpdBedsNotifier, IpdBedsState>((ref) {
  return IpdBedsNotifier();
});
