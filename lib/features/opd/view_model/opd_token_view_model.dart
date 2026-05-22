import 'package:paracareplus/features/opd/model/opd_token.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'opd_token_view_model.g.dart';

@riverpod
class OpdTokenViewModel extends _$OpdTokenViewModel {
  @override
  FutureOr<OpdToken> build() {
    return const OpdToken();
  }

  void updateField({
    String? searchQuery,
    String? patientName,
    String? age,
    String? sex,
    String? department,
    String? doctorName,
    DateTime? appointmentDate,
    String? appointmentSlot,
    String? chiefComplaint,
    String? visitType,
    String? paymentMode,
    String? appliedCharge,
  }) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncData(
      currentState.copyWith(
        searchQuery: searchQuery ?? currentState.searchQuery,
        patientName: patientName ?? currentState.patientName,
        age: age ?? currentState.age,
        sex: sex ?? currentState.sex,
        department: department ?? currentState.department,
        doctorName: doctorName ?? currentState.doctorName,
        appointmentDate: appointmentDate ?? currentState.appointmentDate,
        appointmentSlot: appointmentSlot ?? currentState.appointmentSlot,
        chiefComplaint: chiefComplaint ?? currentState.chiefComplaint,
        visitType: visitType ?? currentState.visitType,
        paymentMode: paymentMode ?? currentState.paymentMode,
        appliedCharge: appliedCharge ?? currentState.appliedCharge,
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

    // Mock search results - In real app this would be an API call
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
      const PatientSummary(
        mrn: 'MRN004',
        name: 'Anjali Gupta',
        age: '28',
        sex: 'Female',
        phone: '9988776655',
      ),
      const PatientSummary(
        mrn: 'MRN005',
        name: 'Vikram Singh',
        age: '40',
        sex: 'Male',
        phone: '8877665544',
      ),
    ];

    final results = allMockPatients
        .where(
          (p) =>
              p.name.toLowerCase().contains(query.toLowerCase()) ||
              p.mrn.toLowerCase().contains(query.toLowerCase()) ||
              p.phone.contains(query),
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
        age: patient.age,
        sex: patient.sex,
        searchResults: [],
        searchQuery: patient.mrn,
      ),
    );
  }

  Future<void> issueToken() async {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncData(currentState.copyWith(isSubmitting: true));

    // Simulate API call
    await Future<void>.delayed(const Duration(seconds: 1));

    state = AsyncData(currentState.copyWith(isSubmitting: false));
    // Reset or handle success in UI
  }

  void reset() {
    state = const AsyncData(OpdToken());
  }
}
