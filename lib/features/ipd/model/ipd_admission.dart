import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:paracareplus/features/opd/model/opd_token.dart';

part 'ipd_admission.freezed.dart';
part 'ipd_admission.g.dart';

@freezed
class IpdAdmission with _$IpdAdmission {
  const factory IpdAdmission({
    @Default('') String searchQuery,
    @Default('') String patientName,
    @Default('') String mrn,
    @Default('General Medicine') String department,
    @Default('') String admissionReason,
    @Default('General Ward') String ward,
    @Default('') String selectedBed,
    @Default('') String doctorName,
    @Default('1-3 days') String expectedDuration,
    @Default('Cash') String paymentMode,
    @Default('5000') String advanceDeposit,
    @Default('') String specialInstructions,
    @Default(false) bool isSearching,
    @Default([]) List<PatientSummary> searchResults,
    PatientSummary? selectedPatient,
    @Default([]) List<BedInfo> availableBeds,
    @Default(false) bool isSubmitting,
  }) = _IpdAdmission;

  factory IpdAdmission.fromJson(Map<String, dynamic> json) =>
      _$IpdAdmissionFromJson(json);
}

@freezed
class BedInfo with _$BedInfo {
  const factory BedInfo({
    required String id,
    required String wardName,
    required String bedNumber,
    required String roomNumber,
    @Default(true) bool isAvailable,
  }) = _BedInfo;

  factory BedInfo.fromJson(Map<String, dynamic> json) =>
      _$BedInfoFromJson(json);
}
