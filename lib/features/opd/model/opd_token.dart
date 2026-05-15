import 'package:freezed_annotation/freezed_annotation.dart';

part 'opd_token.freezed.dart';
part 'opd_token.g.dart';

@freezed
class OpdToken with _$OpdToken {
  const factory OpdToken({
    @Default('') String searchQuery,
    @Default('') String patientName,
    @Default('') String age,
    @Default('Male') String sex,
    @Default('General Medicine') String department,
    @Default('Dr. Sharma (Medicine)') String doctorName,
    DateTime? appointmentDate,
    @Default('09:00 AM - 10:00 AM') String appointmentSlot,
    @Default('') String chiefComplaint,
    @Default('OPD') String visitType,
    @Default('Cash') String paymentMode,
    @Default('50.00') String appliedCharge,
    @Default(false) bool isSearching,
    @Default([]) List<PatientSummary> searchResults,
    PatientSummary? selectedPatient,
    @Default(false) bool isSubmitting,
  }) = _OpdToken;

  factory OpdToken.fromJson(Map<String, dynamic> json) => _$OpdTokenFromJson(json);
}

@freezed
class PatientSummary with _$PatientSummary {
  const factory PatientSummary({
    required String mrn,
    required String name,
    required String age,
    required String sex,
    required String phone,
  }) = _PatientSummary;

  factory PatientSummary.fromJson(Map<String, dynamic> json) => _$PatientSummaryFromJson(json);
}
