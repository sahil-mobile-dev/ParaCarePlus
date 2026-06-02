import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/features/opd_analytics/model/opd_analytics_model.dart';

class OpdAnalyticsState {
  const OpdAnalyticsState({
    required this.selectedFacility,
    required this.selectedSpecialty,
    required this.selectedDistrict,
    required this.selectedTimeframe,
    required this.isRefreshing,
    required this.sortBy,
    required this.kpis,
    required this.liveCounters,
    required this.doctorPerformance,
    required this.criticalAlerts,
    required this.watchAlerts,
  });

  final String selectedFacility;
  final String selectedSpecialty;
  final String selectedDistrict;
  final String selectedTimeframe;
  final bool isRefreshing;
  final String sortBy;
  final OpdAnalyticsKpis kpis;
  final List<LiveCounterItem> liveCounters;
  final List<DoctorOpdPerformanceItem> doctorPerformance;
  final List<OpdOperationalAlert> criticalAlerts;
  final List<OpdOperationalAlert> watchAlerts;

  OpdAnalyticsState copyWith({
    String? selectedFacility,
    String? selectedSpecialty,
    String? selectedDistrict,
    String? selectedTimeframe,
    bool? isRefreshing,
    String? sortBy,
    OpdAnalyticsKpis? kpis,
    List<LiveCounterItem>? liveCounters,
    List<DoctorOpdPerformanceItem>? doctorPerformance,
    List<OpdOperationalAlert>? criticalAlerts,
    List<OpdOperationalAlert>? watchAlerts,
  }) {
    return OpdAnalyticsState(
      selectedFacility: selectedFacility ?? this.selectedFacility,
      selectedSpecialty: selectedSpecialty ?? this.selectedSpecialty,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedTimeframe: selectedTimeframe ?? this.selectedTimeframe,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      sortBy: sortBy ?? this.sortBy,
      kpis: kpis ?? this.kpis,
      liveCounters: liveCounters ?? this.liveCounters,
      doctorPerformance: doctorPerformance ?? this.doctorPerformance,
      criticalAlerts: criticalAlerts ?? this.criticalAlerts,
      watchAlerts: watchAlerts ?? this.watchAlerts,
    );
  }
}

class OpdAnalyticsNotifier extends StateNotifier<OpdAnalyticsState> {
  OpdAnalyticsNotifier()
    : super(
        const OpdAnalyticsState(
          selectedFacility: 'All Facilities',
          selectedSpecialty: 'All Specialties',
          selectedDistrict: 'All Districts',
          selectedTimeframe: 'Today',
          isRefreshing: false,
          sortBy: 'Seen',
          kpis: _initialKpis,
          liveCounters: _initialLiveCounters,
          doctorPerformance: _initialDoctorPerformance,
          criticalAlerts: _initialCriticalAlerts,
          watchAlerts: _initialWatchAlerts,
        ),
      ) {
    _startTelemetryTimer();
  }

  Timer? _telemetryTimer;
  final _random = Random();

  void _startTelemetryTimer() {
    _telemetryTimer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (state.isRefreshing) return;

      // Fluctuate patient wait time and served counts
      final totalChange = _random.nextInt(30) - 10;
      final waitChange = _random.nextInt(3) - 1;
      final servedChange = _random.nextInt(10) + 5;

      final updatedKpis = state.kpis.copyWith(
        totalOpdToday: state.kpis.totalOpdToday + servedChange,
        avgWaitTimeMinutes: (state.kpis.avgWaitTimeMinutes + waitChange).clamp(
          15,
          60,
        ),
      );

      final updatedLiveCounters = state.liveCounters.map((counter) {
        if (counter.label == 'In Queue Now') {
          final newVal = (int.tryParse(counter.val) ?? 1280) + totalChange;
          return LiveCounterItem(
            label: counter.label,
            val: newVal.toString(),
            colorHex: counter.colorHex,
            sub: counter.sub,
          );
        } else if (counter.label == 'Served Today') {
          final newVal = (int.tryParse(counter.val) ?? 52000) + servedChange;
          return LiveCounterItem(
            label: counter.label,
            val: newVal.toString(),
            colorHex: counter.colorHex,
            sub: counter.sub,
          );
        }
        return counter;
      }).toList();

      state = state.copyWith(
        kpis: updatedKpis,
        liveCounters: updatedLiveCounters,
      );
    });
  }

  void changeFacility(String val) {
    state = state.copyWith(selectedFacility: val);
  }

  void changeSpecialty(String val) {
    state = state.copyWith(selectedSpecialty: val);
  }

  void changeDistrict(String val) {
    state = state.copyWith(selectedDistrict: val);
  }

  void changeTimeframe(String val) {
    state = state.copyWith(selectedTimeframe: val);
  }

  void sortDoctorPerformance(String sortBy) {
    final list = List<DoctorOpdPerformanceItem>.from(state.doctorPerformance);
    if (sortBy == 'Doctor') {
      list.sort((a, b) => a.name.compareTo(b.name));
    } else if (sortBy == 'Seen') {
      list.sort((a, b) => b.patientsSeen.compareTo(a.patientsSeen));
    } else if (sortBy == 'ConsultTime') {
      list.sort((a, b) => a.avgConsultTime.compareTo(b.avgConsultTime));
    } else if (sortBy == 'ABHA') {
      list.sort((a, b) => b.abhaScanPercent.compareTo(a.abhaScanPercent));
    } else if (sortBy == 'CSAT') {
      list.sort((a, b) => b.csat.compareTo(a.csat));
    }
    state = state.copyWith(sortBy: sortBy, doctorPerformance: list);
  }

  Future<void> refresh() async {
    if (state.isRefreshing) return;
    state = state.copyWith(isRefreshing: true);

    await Future<void>.delayed(const Duration(milliseconds: 1000));

    final updatedKpis = state.kpis.copyWith(
      totalOpdToday: 52000 + _random.nextInt(1500),
      avgWaitTimeMinutes: 24 + _random.nextInt(8),
      abhaScanSharePercent: 55.0 + _random.nextDouble() * 8,
      ePrescriptionRatePercent: 62.0 + _random.nextDouble() * 6,
    );

    state = state.copyWith(isRefreshing: false, kpis: updatedKpis);

    sortDoctorPerformance(state.sortBy);
  }

  @override
  void dispose() {
    _telemetryTimer?.cancel();
    super.dispose();
  }

  // --- Initial Mock Data ---
  static const _initialKpis = OpdAnalyticsKpis(
    totalOpdToday: 52840,
    avgWaitTimeMinutes: 28,
    avgConsultationTimeMinutes: 8.4,
    newVsRevisitRatio: '62:38',
    ePrescriptionRatePercent: 64.7,
    abhaScanSharePercent: 58.9,
    telemedicineOpdCount: 4218,
    opdToIpdConversionPercent: 7.3,
    opdCsatScore: 4,
    opdLabReferralRatePercent: 38.4,
  );

  static const List<LiveCounterItem> _initialLiveCounters = [
    LiveCounterItem(
      label: 'In Queue Now',
      val: '1284',
      colorHex: 'FFD166',
      sub: 'State-wide',
    ),
    LiveCounterItem(
      label: 'Served Today',
      val: '52840',
      colorHex: '00C897',
      sub: 'Running total',
    ),
    LiveCounterItem(
      label: 'Counters Open',
      val: '312',
      colorHex: '00B4D8',
      sub: 'Across facilities',
    ),
    LiveCounterItem(
      label: 'Doctors On Duty',
      val: '847',
      colorHex: '9B5DE5',
      sub: 'Active OPD doctors',
    ),
    LiveCounterItem(
      label: 'Avg Wait Right Now',
      val: '28 min',
      colorHex: '06D6A0',
      sub: 'State average',
    ),
    LiveCounterItem(
      label: 'Telemedicine Active',
      val: '4218',
      colorHex: 'F77F00',
      sub: 'eSanjeevani today',
    ),
  ];

  static const List<DoctorOpdPerformanceItem> _initialDoctorPerformance = [
    DoctorOpdPerformanceItem(
      name: 'Dr. Anita Sharma',
      specialty: 'Gen Medicine',
      patientsSeen: 84,
      target: 80,
      avgConsultTime: 7.2,
      abhaScanPercent: 82,
      ePrescriptionPercent: 78,
      csat: 4.4,
    ),
    DoctorOpdPerformanceItem(
      name: 'Dr. Rajesh Negi',
      specialty: 'Cardiology',
      patientsSeen: 52,
      target: 50,
      avgConsultTime: 12.4,
      abhaScanPercent: 91,
      ePrescriptionPercent: 88,
      csat: 4.6,
    ),
    DoctorOpdPerformanceItem(
      name: 'Dr. Priya Rawat',
      specialty: 'Gynaecology',
      patientsSeen: 68,
      target: 70,
      avgConsultTime: 9.8,
      abhaScanPercent: 74,
      ePrescriptionPercent: 72,
      csat: 4.2,
    ),
    DoctorOpdPerformanceItem(
      name: 'Dr. Vikram Bisht',
      specialty: 'Orthopaedics',
      patientsSeen: 76,
      target: 80,
      avgConsultTime: 8.1,
      abhaScanPercent: 68,
      ePrescriptionPercent: 64,
      csat: 3.9,
    ),
    DoctorOpdPerformanceItem(
      name: 'Dr. Sunita Pant',
      specialty: 'Paediatrics',
      patientsSeen: 92,
      target: 85,
      avgConsultTime: 6.4,
      abhaScanPercent: 79,
      ePrescriptionPercent: 81,
      csat: 4.5,
    ),
    DoctorOpdPerformanceItem(
      name: 'Dr. Mohan Joshi',
      specialty: 'ENT',
      patientsSeen: 61,
      target: 60,
      avgConsultTime: 7.8,
      abhaScanPercent: 71,
      ePrescriptionPercent: 68,
      csat: 4.1,
    ),
    DoctorOpdPerformanceItem(
      name: 'Dr. Kavita Singh',
      specialty: 'Ophthalmology',
      patientsSeen: 48,
      target: 50,
      avgConsultTime: 10.2,
      abhaScanPercent: 84,
      ePrescriptionPercent: 76,
      csat: 4.3,
    ),
    DoctorOpdPerformanceItem(
      name: 'Dr. Amit Kumar',
      specialty: 'Neurology',
      patientsSeen: 38,
      target: 40,
      avgConsultTime: 18.6,
      abhaScanPercent: 88,
      ePrescriptionPercent: 90,
      csat: 4.7,
    ),
    DoctorOpdPerformanceItem(
      name: 'Dr. Rekha Verma',
      specialty: 'Dermatology',
      patientsSeen: 72,
      target: 75,
      avgConsultTime: 5.8,
      abhaScanPercent: 62,
      ePrescriptionPercent: 58,
      csat: 3.8,
    ),
    DoctorOpdPerformanceItem(
      name: 'Dr. Suresh Thapa',
      specialty: 'Surgery',
      patientsSeen: 44,
      target: 45,
      avgConsultTime: 14.2,
      abhaScanPercent: 77,
      ePrescriptionPercent: 82,
      csat: 4.2,
    ),
  ];

  static const List<OpdOperationalAlert> _initialCriticalAlerts = [
    OpdOperationalAlert(
      msg:
          'Doon Hospital — General Medicine OPD queue at 142 patients. Avg wait 48 min. Only 3 of 6 counters operational. 2 doctors absent.',
      time: 'Today 10:45 AM',
    ),
    OpdOperationalAlert(
      msg:
          'Haridwar DH — OPD at 140% capacity. Overflow triage area activated. CMO and Medical Superintendent notified.',
      time: 'Today 10:15 AM',
    ),
    OpdOperationalAlert(
      msg:
          'Srinagar Govt Hospital — Orthopaedics OPD cancelled: doctor unwell. 68 patients affected. Redirected to neighbouring facility.',
      time: 'Today 09:30 AM',
    ),
  ];

  static const List<OpdOperationalAlert> _initialWatchAlerts = [
    OpdOperationalAlert(
      msg:
          'State ABHA Scan & Share rate at 58.9% — below 70% monthly target. Awareness drive recommended at 4 low-performing facilities.',
      time: 'Today 09:00 AM',
    ),
    OpdOperationalAlert(
      msg:
          'ePrescription rate below 60% at Almora and Pithoragarh district hospitals. SOP compliance review requested.',
      time: 'Today 08:30 AM',
    ),
    OpdOperationalAlert(
      msg:
          'Telemedicine OPD surge: +18.4% vs last month. eSanjeevani server load at 78% capacity. Scale-up advisory issued.',
      time: 'Today 08:00 AM',
    ),
    OpdOperationalAlert(
      msg:
          'Average consultation time at 8.4 min — below 10 min NHM standard at 5 facilities. Quality of care review initiated.',
      time: 'Yesterday 06:00 PM',
    ),
  ];
}

final opdAnalyticsProvider =
    StateNotifierProvider<OpdAnalyticsNotifier, OpdAnalyticsState>((ref) {
      return OpdAnalyticsNotifier();
    });
