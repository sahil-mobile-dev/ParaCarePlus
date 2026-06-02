import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/features/lab_diagnostics/model/lab_diagnostics_model.dart';

class LabDiagnosticsState {
  LabDiagnosticsState({
    required this.activeTab,
    required this.searchQuery,
    required this.categoryFilter,
    required this.statusFilter,
    required this.samples,
    required this.urgentTests,
    required this.criticalValues,
    required this.reports,
    required this.analyzers,
    this.isLoading = false,
  });

  final String activeTab;
  final String searchQuery;
  final String categoryFilter;
  final String statusFilter;
  final List<LabSampleItem> samples;
  final List<UrgentTestItem> urgentTests;
  final List<CriticalValueItem> criticalValues;
  final List<LabReportItem> reports;
  final List<AnalyzerItem> analyzers;
  final bool isLoading;

  LabDiagnosticsState copyWith({
    String? activeTab,
    String? searchQuery,
    String? categoryFilter,
    String? statusFilter,
    List<LabSampleItem>? samples,
    List<UrgentTestItem>? urgentTests,
    List<CriticalValueItem>? criticalValues,
    List<LabReportItem>? reports,
    List<AnalyzerItem>? analyzers,
    bool? isLoading,
  }) {
    return LabDiagnosticsState(
      activeTab: activeTab ?? this.activeTab,
      searchQuery: searchQuery ?? this.searchQuery,
      categoryFilter: categoryFilter ?? this.categoryFilter,
      statusFilter: statusFilter ?? this.statusFilter,
      samples: samples ?? this.samples,
      urgentTests: urgentTests ?? this.urgentTests,
      criticalValues: criticalValues ?? this.criticalValues,
      reports: reports ?? this.reports,
      analyzers: analyzers ?? this.analyzers,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class LabDiagnosticsNotifier extends StateNotifier<LabDiagnosticsState> {
  LabDiagnosticsNotifier() : super(_initialState()) {
    _startTimer();
  }

  Timer? _timer;
  final _random = Random();

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 15), (_) {
      _simulationTick();
    });
  }

  void setTab(String tab) {
    state = state.copyWith(activeTab: tab);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setCategoryFilter(String cat) {
    state = state.copyWith(categoryFilter: cat);
  }

  void setStatusFilter(String status) {
    state = state.copyWith(statusFilter: status);
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(const Duration(milliseconds: 800));
    state = _initialState().copyWith(isLoading: false);
  }

  // Register a new sample collection
  void registerSample({
    required String patientName,
    required String mrn,
    required String tests,
    required String category,
    required String priority,
    required String doctor,
  }) {
    final nextId = 'LAB-2024-00${1854 + state.samples.length}';
    final nowTime = _formatTime(DateTime.now());

    final newSample = LabSampleItem(
      id: nextId,
      patientName: patientName,
      mrn: mrn,
      tests: tests,
      category: category,
      priority: priority.toLowerCase(),
      doctor: doctor,
      collected: nowTime,
      status: 'collected',
    );

    final updatedSamples = [newSample, ...state.samples];

    // If it's Urgent or STAT, also add to Urgent/STAT active panel list
    List<UrgentTestItem> updatedUrgents = [...state.urgentTests];
    if (priority.toLowerCase() == 'urgent' || priority.toLowerCase() == 'stat') {
      updatedUrgents = [
        UrgentTestItem(
          id: nextId,
          patientName: patientName,
          tests: tests,
          elapsed: '0 min',
          remaining: priority.toLowerCase() == 'stat' ? '30 min' : '60 min',
          priority: priority.toUpperCase(),
        ),
        ...state.urgentTests,
      ];
    }

    state = state.copyWith(
      samples: updatedSamples,
      urgentTests: updatedUrgents,
    );
  }

  // Submit test results and finalize/dispatch report
  void submitResults({
    required String sampleId,
    required String remarks,
    required String pathologistComment,
    required List<Map<String, dynamic>> testParameters, // {param, value, unit, isCritical, flag}
  }) {
    final samples = state.samples.map((s) {
      if (s.id == sampleId) {
        return s.copyWith(
          status: 'completed',
          result: 'Report Dispatched',
        );
      }
      return s;
    }).toList();

    // Check if there are any critical findings
    final criticalParams = testParameters.where((p) => p['isCritical'] == true).toList();
    List<CriticalValueItem> updatedCriticals = [...state.criticalValues];
    
    final sampleObj = state.samples.firstWhere((s) => s.id == sampleId);
    
    if (criticalParams.isNotEmpty) {
      final p = criticalParams.first;
      updatedCriticals = [
        CriticalValueItem(
          id: sampleId,
          patientName: sampleObj.patientName,
          ward: 'Ward A-14',
          test: p['param'] as String,
          value: '${p['value']} ${p['unit']}',
          normalRange: 'See Reference',
          flag: p['flag'] as String,
          doctor: sampleObj.doctor,
          acknowledged: false,
        ),
        ...state.criticalValues,
      ];
    }

    // Add to completed reports
    final keyResSummary = testParameters.isNotEmpty 
        ? '${testParameters[0]['param']}: ${testParameters[0]['value']} ${testParameters[0]['unit']} ${testParameters[0]['flag'] == 'Normal' ? '' : '↑'}'
        : 'All Normal';

    final newReport = LabReportItem(
      id: sampleId,
      patientName: sampleObj.patientName,
      tests: sampleObj.tests,
      keyResult: keyResSummary,
      time: _formatTime(DateTime.now()),
      status: 'dispatched',
    );

    // Remove from urgent queue if it was there
    final updatedUrgents = state.urgentTests.where((u) => u.id != sampleId).toList();

    state = state.copyWith(
      samples: samples,
      urgentTests: updatedUrgents,
      criticalValues: updatedCriticals,
      reports: [newReport, ...state.reports],
    );
  }

  void acknowledgeCritical(String sampleId) {
    final updated = state.criticalValues.map((c) {
      if (c.id == sampleId) {
        return c.copyWith(acknowledged: true);
      }
      return c;
    }).toList();
    state = state.copyWith(criticalValues: updated);
  }

  // Background simulations: increment elapsed time, change sample states, calibrate instruments
  void _simulationTick() {
    // 1. Update urgent tests elapsed time
    final updatedUrgents = state.urgentTests.map((u) {
      final elapsedInt = int.parse(u.elapsed.split(' ')[0]) + 5;
      final remainingInt = max(0, int.parse(u.remaining.split(' ')[0]) - 5);
      return u.copyWith(
        elapsed: '$elapsedInt min',
        remaining: '$remainingInt min',
      );
    }).toList();

    // 2. Transition some collected samples to processing
    final updatedSamples = state.samples.map((s) {
      if (s.status == 'collected' && _random.nextDouble() > 0.6) {
        return s.copyWith(status: 'processing');
      }
      return s;
    }).toList();

    // 3. Jitter analyzer samples count slightly
    final updatedAnalyzers = state.analyzers.map((a) {
      if (a.status == 'online') {
        final current = int.parse(a.samplesToday.split(' ')[0]);
        final next = current + _random.nextInt(3);
        return a.copyWith(samplesToday: '$next today');
      }
      return a;
    }).toList();

    state = state.copyWith(
      urgentTests: updatedUrgents,
      samples: updatedSamples,
      analyzers: updatedAnalyzers,
    );
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$hour:$min';
  }

  static LabDiagnosticsState _initialState() {
    return LabDiagnosticsState(
      activeTab: 'Sample Queue',
      searchQuery: '',
      categoryFilter: 'All Categories',
      statusFilter: 'All Status',
      samples: [
        const LabSampleItem(
          id: 'LAB-2024-001847',
          patientName: 'Ramesh Kumar Singh',
          mrn: 'MRN-10021',
          tests: 'CBC + ESR',
          category: 'Haematology',
          priority: 'urgent',
          doctor: 'Dr. Rajesh Negi',
          collected: '09:20',
          status: 'processing',
        ),
        const LabSampleItem(
          id: 'LAB-2024-001848',
          patientName: 'Kavita Sharma',
          mrn: 'MRN-10026',
          tests: 'LFT + KFT + Lipid Profile',
          category: 'Biochemistry',
          priority: 'routine',
          doctor: 'Dr. Rajesh Negi',
          collected: '08:40',
          status: 'processing',
        ),
        const LabSampleItem(
          id: 'LAB-2024-001849',
          patientName: 'Mohan Lal Gupta',
          mrn: 'MRN-10025',
          tests: 'Blood Culture & Sensitivity',
          category: 'Microbiology',
          priority: 'stat',
          doctor: 'Dr. Bisht',
          collected: '08:15',
          status: 'collected',
        ),
        const LabSampleItem(
          id: 'LAB-2024-001850',
          patientName: 'Babita Devi',
          mrn: 'MRN-10031',
          tests: 'Dengue NS1 + IgM/IgG',
          category: 'Serology',
          priority: 'urgent',
          doctor: 'Dr. Sunita Verma',
          collected: '09:00',
          status: 'completed',
          result: 'Positive (IgM)',
        ),
        const LabSampleItem(
          id: 'LAB-2024-001851',
          patientName: 'Rajveer Singh',
          mrn: 'MRN-10034',
          tests: 'ABG + Electrolytes',
          category: 'Biochemistry',
          priority: 'stat',
          doctor: 'Dr. Bisht',
          collected: '09:45',
          status: 'collected',
        ),
        const LabSampleItem(
          id: 'LAB-2024-001852',
          patientName: 'Priya Negi',
          mrn: 'MRN-10024',
          tests: 'CBC + Thyroid Profile',
          category: 'Endocrinology',
          priority: 'routine',
          doctor: 'Dr. Kumar',
          collected: '10:00',
          status: 'ordered',
        ),
        const LabSampleItem(
          id: 'LAB-2024-001853',
          patientName: 'Sunita Rawat',
          mrn: 'MRN-10022',
          tests: 'PT/INR',
          category: 'Haematology',
          priority: 'urgent',
          doctor: 'Dr. Rajesh Negi',
          collected: '10:15',
          status: 'processing',
        ),
      ],
      urgentTests: [
        const UrgentTestItem(
          id: 'LAB-2024-001849',
          patientName: 'Mohan Lal Gupta (ICU Bed 3)',
          tests: 'Blood Culture & Sensitivity',
          elapsed: '48 min',
          remaining: '12 min',
          priority: 'STAT',
        ),
        const UrgentTestItem(
          id: 'LAB-2024-001851',
          patientName: 'Rajveer Singh (HDU Bed 1)',
          tests: 'ABG + Electrolytes',
          elapsed: '15 min',
          remaining: '45 min',
          priority: 'STAT',
        ),
        const UrgentTestItem(
          id: 'LAB-2024-001847',
          patientName: 'Ramesh Kumar Singh (OPD)',
          tests: 'CBC + ESR',
          elapsed: '30 min',
          remaining: '30 min',
          priority: 'Urgent',
        ),
        const UrgentTestItem(
          id: 'LAB-2024-001853',
          patientName: 'Sunita Rawat (Ward A-14)',
          tests: 'PT/INR',
          elapsed: '12 min',
          remaining: '18 min',
          priority: 'Urgent',
        ),
      ],
      criticalValues: [
        const CriticalValueItem(
          id: 'LAB-2024-001848',
          patientName: 'Kavita Sharma',
          ward: 'Ward A-14',
          test: 'Serum Potassium',
          value: '6.8 mEq/L',
          normalRange: '3.5–5.0 mEq/L',
          flag: '↑↑ CRITICAL HIGH',
          doctor: 'Dr. Rajesh Negi',
          acknowledged: false,
        ),
        const CriticalValueItem(
          id: 'LAB-2024-001850',
          patientName: 'Babita Devi',
          ward: 'Ward A-11',
          test: 'Platelet Count',
          value: '18,000 /μL',
          normalRange: '1.5L–4.0L /μL',
          flag: '↓↓ CRITICAL LOW',
          doctor: 'Dr. Sunita Verma',
          acknowledged: false,
        ),
      ],
      reports: [
        const LabReportItem(
          id: 'LAB-2024-001844',
          patientName: 'Ajay Bisht',
          tests: 'Lipid Profile',
          keyResult: 'LDL Cholesterol: 185 mg/dL ↑',
          time: '08:00',
          status: 'dispatched',
        ),
        const LabReportItem(
          id: 'LAB-2024-001843',
          patientName: 'Reema Bisht',
          tests: 'Thyroid Profile',
          keyResult: 'TSH: 0.2 μIU/mL ↓',
          time: '07:45',
          status: 'dispatched',
        ),
        const LabReportItem(
          id: 'LAB-2024-001842',
          patientName: 'Mohan Gupta',
          tests: 'HbA1c',
          keyResult: 'HbA1c: 7.8% ↑',
          time: '07:30',
          status: 'dispatched',
        ),
        const LabReportItem(
          id: 'LAB-2024-001841',
          patientName: 'Lakshmi Thapliyal',
          tests: 'CBC',
          keyResult: 'WBC: 14.2K ↑, Hb: 9.8 ↓',
          time: '07:00',
          status: 'printed',
        ),
      ],
      analyzers: [
        const AnalyzerItem(
          name: 'Sysmex XN-550 (Hematology)',
          status: 'online',
          tests: 'CBC, WBC Diff',
          lastCalibration: 'Today 07:00',
          samplesToday: '82 today',
        ),
        const AnalyzerItem(
          name: 'Roche Cobas c311 (Chemistry)',
          status: 'online',
          tests: 'LFT, KFT, Lipids, Glucose',
          lastCalibration: 'Today 06:45',
          samplesToday: '125 today',
        ),
        const AnalyzerItem(
          name: 'BioMerieux VITEK2 (Microbiology)',
          status: 'online',
          tests: 'Culture & Sensitivity',
          lastCalibration: 'Yesterday',
          samplesToday: '8 today',
        ),
        const AnalyzerItem(
          name: 'Bio-Rad D-100 (HbA1c)',
          status: 'maintenance',
          tests: 'HbA1c',
          lastCalibration: '2 days ago',
          samplesToday: '0 today',
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final labDiagnosticsProvider =
    StateNotifierProvider<LabDiagnosticsNotifier, LabDiagnosticsState>((ref) {
  return LabDiagnosticsNotifier();
});
