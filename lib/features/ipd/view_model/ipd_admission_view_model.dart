import 'package:paracareplus/features/ipd/model/ipd_admission.dart';
import 'package:paracareplus/features/opd/model/opd_token.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ipd_admission_view_model.g.dart';

@riverpod
class IpdAdmissionViewModel extends _$IpdAdmissionViewModel {
  @override
  FutureOr<IpdAdmission> build() {
    return _initialState();
  }

  IpdAdmission _initialState() {
    return const IpdAdmission(
      availableBeds: [
        BedInfo(
          id: 'GW-101-B1',
          wardName: 'General Ward',
          roomNumber: '101',
          bedNumber: 'B1',
        ),
        BedInfo(
          id: 'GW-101-B2',
          wardName: 'General Ward',
          roomNumber: '101',
          bedNumber: 'B2',
        ),
        BedInfo(
          id: 'GW-101-B3',
          wardName: 'General Ward',
          roomNumber: '101',
          bedNumber: 'B3',
        ),
        BedInfo(
          id: 'GW-101-B4',
          wardName: 'General Ward',
          roomNumber: '101',
          bedNumber: 'B4',
        ),
        BedInfo(
          id: 'GW-102-B1',
          wardName: 'General Ward',
          roomNumber: '102',
          bedNumber: 'B1',
        ),
        BedInfo(
          id: 'GW-102-B2',
          wardName: 'General Ward',
          roomNumber: '102',
          bedNumber: 'B2',
        ),
        BedInfo(
          id: 'GW-102-B3',
          wardName: 'General Ward',
          roomNumber: '102',
          bedNumber: 'B3',
        ),
        BedInfo(
          id: 'GW-102-B4',
          wardName: 'General Ward',
          roomNumber: '102',
          bedNumber: 'B4',
        ),
        BedInfo(
          id: 'ICU-101-B1',
          wardName: 'ICU',
          roomNumber: '101',
          bedNumber: 'B1',
        ),
        BedInfo(
          id: 'ICU-101-B2',
          wardName: 'ICU',
          roomNumber: '101',
          bedNumber: 'B2',
        ),
        BedInfo(
          id: 'ICU-102-B1',
          wardName: 'ICU',
          roomNumber: '102',
          bedNumber: 'B1',
        ),
      ],
    );
  }

  void updateField({
    String? searchQuery,
    String? patientName,
    String? mrn,
    String? department,
    String? admissionReason,
    String? ward,
    String? selectedBed,
    String? doctorName,
    String? expectedDuration,
    String? paymentMode,
    String? advanceDeposit,
    String? specialInstructions,
  }) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncData(
      currentState.copyWith(
        searchQuery: searchQuery ?? currentState.searchQuery,
        patientName: patientName ?? currentState.patientName,
        mrn: mrn ?? currentState.mrn,
        department: department ?? currentState.department,
        admissionReason: admissionReason ?? currentState.admissionReason,
        ward: ward ?? currentState.ward,
        selectedBed: selectedBed ?? currentState.selectedBed,
        doctorName: doctorName ?? currentState.doctorName,
        expectedDuration: expectedDuration ?? currentState.expectedDuration,
        paymentMode: paymentMode ?? currentState.paymentMode,
        advanceDeposit: advanceDeposit ?? currentState.advanceDeposit,
        specialInstructions:
            specialInstructions ?? currentState.specialInstructions,
      ),
    );

    if (searchQuery != null) {
      _searchPatients(searchQuery);
    }
  }

  Future<void> _searchPatients(String query) async {
    final currentState = state.value;
    if (currentState == null) return;

    if (query.isEmpty) {
      state = AsyncData(
        currentState.copyWith(searchResults: [], isSearching: false),
      );
      return;
    }

    state = AsyncData(currentState.copyWith(isSearching: true));

    // Mock search
    await Future<void>.delayed(const Duration(milliseconds: 300));

    final allMockPatients = [
      const PatientSummary(
        mrn: 'MRN001',
        name: 'John Doe',
        age: '45',
        sex: 'Male',
        phone: '9876543210',
      ),
      const PatientSummary(
        mrn: 'MRN002',
        name: 'Jane Smith',
        age: '32',
        sex: 'Female',
        phone: '8765432109',
      ),
      const PatientSummary(
        mrn: 'MRN003',
        name: 'Robert Johnson',
        age: '58',
        sex: 'Male',
        phone: '7654321098',
      ),
    ];

    final results = allMockPatients
        .where(
          (p) =>
              p.name.toLowerCase().contains(query.toLowerCase()) ||
              p.mrn.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    state = AsyncData(
      state.value!.copyWith(searchResults: results, isSearching: false),
    );
  }

  void selectPatient(PatientSummary patient) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncData(
      currentState.copyWith(
        selectedPatient: patient,
        patientName: patient.name,
        mrn: patient.mrn,
        searchResults: [],
        searchQuery: patient.mrn,
      ),
    );
  }

  Future<void> admitPatient() async {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncData(currentState.copyWith(isSubmitting: true));
    await Future<void>.delayed(const Duration(seconds: 1));
    state = AsyncData(currentState.copyWith(isSubmitting: false));
  }

  void reset() {
    state = AsyncData(_initialState());
  }
}
