import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/features/radiology_imaging/model/radiology_imaging_model.dart';

class RadiologyImagingState {
  RadiologyImagingState({
    required this.activeTab,
    required this.kpis,
    required this.worklist,
    required this.modalities,
    required this.aiFindings,
    required this.protocols,
    required this.analytics,
    this.isLoading = false,
  });

  final String activeTab;
  final RadiologyKpis kpis;
  final List<RadiologyOrderItem> worklist;
  final List<ModalityItem> modalities;
  final List<AiFindingItem> aiFindings;
  final List<ProtocolItem> protocols;
  final List<MonthlySummaryItem> analytics;
  final bool isLoading;

  RadiologyImagingState copyWith({
    String? activeTab,
    RadiologyKpis? kpis,
    List<RadiologyOrderItem>? worklist,
    List<ModalityItem>? modalities,
    List<AiFindingItem>? aiFindings,
    List<ProtocolItem>? protocols,
    List<MonthlySummaryItem>? analytics,
    bool? isLoading,
  }) {
    return RadiologyImagingState(
      activeTab: activeTab ?? this.activeTab,
      kpis: kpis ?? this.kpis,
      worklist: worklist ?? this.worklist,
      modalities: modalities ?? this.modalities,
      aiFindings: aiFindings ?? this.aiFindings,
      protocols: protocols ?? this.protocols,
      analytics: analytics ?? this.analytics,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class RadiologyImagingNotifier extends StateNotifier<RadiologyImagingState> {
  RadiologyImagingNotifier() : super(_initialState());

  void selectTab(String tab) {
    state = state.copyWith(activeTab: tab);
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 1000));
    state = _initialState().copyWith(activeTab: state.activeTab, isLoading: false);
  }

  void addOrder(RadiologyOrderItem item) {
    state = state.copyWith(
      worklist: [item, ...state.worklist],
      kpis: state.kpis.copyWith(
        todayOrders: state.kpis.todayOrders + 1,
        urgentStat: item.priority == 'STAT' ? state.kpis.urgentStat + 1 : state.kpis.urgentStat,
      ),
    );
  }

  void finalizeReport(String accession) {
    final updatedList = state.worklist.map((item) {
      if (item.accession == accession) {
        return item.copyWith(status: 'Reported');
      }
      return item;
    }).toList();

    state = state.copyWith(
      worklist: updatedList,
      kpis: state.kpis.copyWith(
        completed: state.kpis.completed + 1,
        reportsPending: (state.kpis.reportsPending - 1).clamp(0, 999),
      ),
    );
  }

  static RadiologyImagingState _initialState() {
    return RadiologyImagingState(
      activeTab: 'Worklist',
      kpis: const RadiologyKpis(
        todayOrders: 48,
        completed: 31,
        urgentStat: 5,
        reportsPending: 7,
        aiFlagged: 3,
      ),
      worklist: const [
        RadiologyOrderItem(accession: 'RAD-001', patient: 'Ramesh Kumar', ageSex: '42/M', modality: 'CT Scan', examination: 'CT Chest w/Contrast', orderedBy: 'Dr. Sharma', wardOpd: 'Medicine', priority: 'STAT', status: 'In Progress', time: '08:15'),
        RadiologyOrderItem(accession: 'RAD-002', patient: 'Savita Devi', ageSex: '55/F', modality: 'X-Ray', examination: 'CXR PA View', orderedBy: 'Dr. Rawat', wardOpd: 'OPD', priority: 'Routine', status: 'Completed', time: '08:30'),
        RadiologyOrderItem(accession: 'RAD-003', patient: 'Arjun Singh', ageSex: '8/M', modality: 'X-Ray', examination: 'X-Ray Right Hand', orderedBy: 'Dr. Pant', wardOpd: 'Casualty', priority: 'Urgent', status: 'Ordered', time: '09:00'),
        RadiologyOrderItem(accession: 'RAD-004', patient: 'Meena Bisht', ageSex: '38/F', modality: 'MRI', examination: 'MRI Brain w/o Contrast', orderedBy: 'Dr. Verma', wardOpd: 'Neurology', priority: 'Routine', status: 'Ordered', time: '09:30'),
        RadiologyOrderItem(accession: 'RAD-005', patient: 'Kishore Negi', ageSex: '65/M', modality: 'CT Scan', examination: 'CT Abdomen Pelvis', orderedBy: 'Dr. Joshi', wardOpd: 'Surgery', priority: 'Urgent', status: 'In Progress', time: '09:45'),
        RadiologyOrderItem(accession: 'RAD-006', patient: 'Anita Thapa', ageSex: '29/F', modality: 'Ultrasound', examination: 'USG Abdomen', orderedBy: 'Dr. Rana', wardOpd: 'OPD', priority: 'Routine', status: 'Completed', time: '10:00'),
        RadiologyOrderItem(accession: 'RAD-007', patient: 'Bhupesh Pandey', ageSex: '72/M', modality: 'X-Ray', examination: 'X-Ray LS Spine AP/Lat', orderedBy: 'Dr. Shah', wardOpd: 'Ortho', priority: 'Routine', status: 'Reported', time: '10:15'),
      ],
      modalities: const [
        ModalityItem(name: 'X-Ray (Unit 1)', location: 'OPD Block, Rm 12', iconCode: 0xe5f9, today: 18, pending: 3, util: 72),
        ModalityItem(name: 'X-Ray (Unit 2)', location: 'Emergency Block', iconCode: 0xe5f9, today: 12, pending: 2, util: 65),
        ModalityItem(name: 'CT Scan 128 Slice', location: 'Radiology Wing, Rm 4', iconCode: 0xe5f9, today: 8, pending: 2, util: 80),
        ModalityItem(name: 'MRI 1.5T', location: 'Radiology Wing, Rm 6', iconCode: 0xe5f9, today: 5, pending: 2, util: 62),
        ModalityItem(name: 'Ultrasound (1)', location: 'OPD Block, Rm 10', iconCode: 0xe5f9, today: 14, pending: 1, util: 88),
      ],
      aiFindings: const [
        AiFindingItem(patient: 'Ramesh Kumar', study: 'CT Chest w/Contrast', finding: 'Bilateral Ground Glass Opacities', confidence: 94.5, status: 'Review Needed'),
        AiFindingItem(patient: 'Savita Devi', study: 'CXR PA View', finding: 'Pleural Effusion Left Side', confidence: 88.2, status: 'Confirmed'),
        AiFindingItem(patient: 'Meena Bisht', study: 'MRI Brain', finding: 'No Acute Infarct or Haemorrhage', confidence: 97.4, status: 'Auto-Cleared'),
      ],
      protocols: const [
        ProtocolItem(name: 'CT Trauma Chest/Abdomen/Pelvis', iconCode: 0xe5f9, themeHex: 'c62828', desc: 'STAT protocol for polytrauma. High pitch, split-second acquisition, IV contrast injected at 4ml/s.'),
        ProtocolItem(name: 'MRI Stroke (Fast Brain)', iconCode: 0xe5f9, themeHex: '1565c0', desc: 'DWI, ADC, FLAIR & GRE only. Target acquisition time under 6 minutes.'),
        ProtocolItem(name: 'USG DVT (Lower Limb)', iconCode: 0xe5f9, themeHex: '00695c', desc: 'Complete compression ultrasound of common femoral, superficial femoral, and popliteal veins.'),
      ],
      analytics: const [
        MonthlySummaryItem(modality: 'X-Ray', orders: 480, completed: 462, pending: 18, avgTat: '22m', revenue: '₹1,84,000'),
        MonthlySummaryItem(modality: 'CT Scan', orders: 220, completed: 212, pending: 8, avgTat: '48m', revenue: '₹6,60,000'),
        MonthlySummaryItem(modality: 'MRI', orders: 110, completed: 104, pending: 6, avgTat: '1h 15m', revenue: '₹8,80,000'),
        MonthlySummaryItem(modality: 'Ultrasound', orders: 340, completed: 335, pending: 5, avgTat: '30m', revenue: '₹3,40,000'),
      ],
    );
  }
}

final radiologyImagingProvider = StateNotifierProvider<RadiologyImagingNotifier, RadiologyImagingState>((ref) {
  return RadiologyImagingNotifier();
});
