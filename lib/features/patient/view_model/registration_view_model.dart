import 'package:paracareplus/features/patient/model/patient_enums.dart';
import 'package:paracareplus/features/patient/model/patient_registration.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'registration_view_model.g.dart';

@riverpod
class RegistrationViewModel extends _$RegistrationViewModel {
  @override
  FutureOr<PatientRegistration> build() {
    return const PatientRegistration();
  }

  void updateField({
    PatientTitle? title,
    String? fullName,
    DateTime? dateOfBirth,
    Gender? gender,
    BloodGroup? bloodGroup,
    String? aadhaarNumber,
    String? ayushmanBharatId,
    MaritalStatus? maritalStatus,
    Religion? religion,
    String? occupation,
    Category? category,
    String? mobileNumber,
    String? email,
    String? address,
    String? city,
    String? addressState,
    String? pincode,
    String? emergencyContactName,
    String? emergencyContactNumber,
    String? visitType,
    String? department,
    String? doctorName,
    DateTime? appointmentDate,
    String? appointmentSlot,
    String? bedNumber,
    String? paymentMode,
    String? registrationFee,
    String? admissionReason,
    String? primaryComplaint,
    String? referredBy,
    List<String>? allergies,
    List<String>? chronicIllnesses,
    String? smokingHabit,
    String? alcoholHabit,
    String? familyHistory,
    String? vaccinationHistory,
    String? currentMedications,
    String? pastSurgeries,
  }) {
    final currentState = state.value;
    if (currentState == null) return;

    String? calculatedAge = currentState.age;
    if (dateOfBirth != null) {
      calculatedAge = _calculateAge(dateOfBirth);
    }

    state = AsyncData(
      currentState.copyWith(
        title: title ?? currentState.title,
        fullName: fullName ?? currentState.fullName,
        dateOfBirth: dateOfBirth ?? currentState.dateOfBirth,
        age: calculatedAge,
        gender: gender ?? currentState.gender,
        bloodGroup: bloodGroup ?? currentState.bloodGroup,
        aadhaarNumber: aadhaarNumber ?? currentState.aadhaarNumber,
        ayushmanBharatId: ayushmanBharatId ?? currentState.ayushmanBharatId,
        maritalStatus: maritalStatus ?? currentState.maritalStatus,
        religion: religion ?? currentState.religion,
        occupation: occupation ?? currentState.occupation,
        category: category ?? currentState.category,
        mobileNumber: mobileNumber ?? currentState.mobileNumber,
        email: email ?? currentState.email,
        address: address ?? currentState.address,
        city: city ?? currentState.city,
        state: addressState ?? currentState.state,
        pincode: pincode ?? currentState.pincode,
        emergencyContactName:
            emergencyContactName ?? currentState.emergencyContactName,
        emergencyContactNumber:
            emergencyContactNumber ?? currentState.emergencyContactNumber,
        visitType: visitType ?? currentState.visitType,
        department: department ?? currentState.department,
        doctorName: doctorName ?? currentState.doctorName,
        appointmentDate: appointmentDate ?? currentState.appointmentDate,
        appointmentSlot: appointmentSlot ?? currentState.appointmentSlot,
        bedNumber: bedNumber ?? currentState.bedNumber,
        paymentMode: paymentMode ?? currentState.paymentMode,
        registrationFee: registrationFee ?? currentState.registrationFee,
        admissionReason: admissionReason ?? currentState.admissionReason,
        primaryComplaint: primaryComplaint ?? currentState.primaryComplaint,
        referredBy: referredBy ?? currentState.referredBy,
        allergies: allergies ?? currentState.allergies,
        chronicIllnesses: chronicIllnesses ?? currentState.chronicIllnesses,
        smokingHabit: smokingHabit ?? currentState.smokingHabit,
        alcoholHabit: alcoholHabit ?? currentState.alcoholHabit,
        familyHistory: familyHistory ?? currentState.familyHistory,
        vaccinationHistory:
            vaccinationHistory ?? currentState.vaccinationHistory,
        currentMedications:
            currentMedications ?? currentState.currentMedications,
        pastSurgeries: pastSurgeries ?? currentState.pastSurgeries,
      ),
    );
  }

  String _calculateAge(DateTime dob) {
    final now = DateTime.now();
    var age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age.toString();
  }

  void nextStep() {
    final currentState = state.value;
    if (currentState == null || currentState.currentStep >= 4) return;
    state = AsyncData(
      currentState.copyWith(currentStep: currentState.currentStep + 1),
    );
  }

  void previousStep() {
    final currentState = state.value;
    if (currentState == null || currentState.currentStep <= 0) return;
    state = AsyncData(
      currentState.copyWith(currentStep: currentState.currentStep - 1),
    );
  }

  void setStep(int step) {
    final currentState = state.value;
    if (currentState == null) return;
    state = AsyncData(currentState.copyWith(currentStep: step));
  }

  Future<void> registerPatient() async {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncData(currentState.copyWith(isSubmitting: true));

    // Simulate API call
    await Future<void>.delayed(const Duration(seconds: 2));

    state = AsyncData(currentState.copyWith(isSubmitting: false));
    // In a real app, we would navigate to a success screen or show a receipt
  }
}
