import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:paracareplus/features/patient/model/patient_enums.dart';

part 'patient_registration.freezed.dart';
part 'patient_registration.g.dart';

@freezed
class PatientRegistration with _$PatientRegistration {
  const factory PatientRegistration({
    // Step 1: Personal Info
    @Default(PatientTitle.mr) PatientTitle title,
    @Default('') String fullName,
    DateTime? dateOfBirth,
    @Default('') String age,
    @Default(Gender.male) Gender gender,
    @Default(BloodGroup.unknown) BloodGroup bloodGroup,
    @Default('') String aadhaarNumber,
    @Default('') String ayushmanBharatId,
    @Default(MaritalStatus.single) MaritalStatus maritalStatus,
    @Default(Religion.hindu) Religion religion,
    @Default('') String occupation,
    @Default(Category.general) Category category,

    // Step 2: Contact & Address
    @Default('') String mobileNumber,
    @Default('') String email,
    @Default('') String address,
    @Default('') String city,
    @Default('') String state,
    @Default('') String pincode,
    @Default('') String emergencyContactName,
    @Default('') String emergencyContactNumber,

    // Step 3: Medical History
    @Default([]) List<String> allergies,
    @Default([]) List<String> chronicIllnesses,
    @Default('Never') String smokingHabit,
    @Default('Never') String alcoholHabit,
    @Default('') String familyHistory,
    @Default('Unknown') String vaccinationHistory,
    @Default('') String currentMedications,
    @Default('') String pastSurgeries,

    // Step 4: Visit Type
    @Default('OPD') String visitType, // OPD, IPD, Emergency
    @Default('General Medicine') String department,
    @Default('Dr. Sharma (Medicine)') String doctorName,
    DateTime? appointmentDate,
    @Default('09:00 AM - 10:00 AM') String appointmentSlot,
    @Default('General Ward - B101') String bedNumber,
    @Default('Cash') String paymentMode,
    @Default('0.00') String registrationFee,
    @Default('') String admissionReason,
    @Default('') String primaryComplaint,
    @Default('') String referredBy,

    // Meta
    @Default(0) int currentStep,
    @Default(false) bool isSubmitting,
  }) = _PatientRegistration;

  factory PatientRegistration.fromJson(Map<String, dynamic> json) =>
      _$PatientRegistrationFromJson(json);
}
