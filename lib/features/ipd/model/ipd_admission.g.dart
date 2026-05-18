// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ipd_admission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IpdAdmissionImpl _$$IpdAdmissionImplFromJson(Map<String, dynamic> json) =>
    _$IpdAdmissionImpl(
      searchQuery: json['searchQuery'] as String? ?? '',
      patientName: json['patientName'] as String? ?? '',
      mrn: json['mrn'] as String? ?? '',
      department: json['department'] as String? ?? 'General Medicine',
      admissionReason: json['admissionReason'] as String? ?? '',
      ward: json['ward'] as String? ?? 'General Ward',
      selectedBed: json['selectedBed'] as String? ?? '',
      doctorName: json['doctorName'] as String? ?? '',
      expectedDuration: json['expectedDuration'] as String? ?? '1-3 days',
      paymentMode: json['paymentMode'] as String? ?? 'Cash',
      advanceDeposit: json['advanceDeposit'] as String? ?? '5000',
      specialInstructions: json['specialInstructions'] as String? ?? '',
      isSearching: json['isSearching'] as bool? ?? false,
      searchResults:
          (json['searchResults'] as List<dynamic>?)
              ?.map((e) => PatientSummary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      selectedPatient: json['selectedPatient'] == null
          ? null
          : PatientSummary.fromJson(
              json['selectedPatient'] as Map<String, dynamic>,
            ),
      availableBeds:
          (json['availableBeds'] as List<dynamic>?)
              ?.map((e) => BedInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isSubmitting: json['isSubmitting'] as bool? ?? false,
    );

Map<String, dynamic> _$$IpdAdmissionImplToJson(_$IpdAdmissionImpl instance) =>
    <String, dynamic>{
      'searchQuery': instance.searchQuery,
      'patientName': instance.patientName,
      'mrn': instance.mrn,
      'department': instance.department,
      'admissionReason': instance.admissionReason,
      'ward': instance.ward,
      'selectedBed': instance.selectedBed,
      'doctorName': instance.doctorName,
      'expectedDuration': instance.expectedDuration,
      'paymentMode': instance.paymentMode,
      'advanceDeposit': instance.advanceDeposit,
      'specialInstructions': instance.specialInstructions,
      'isSearching': instance.isSearching,
      'searchResults': instance.searchResults,
      'selectedPatient': instance.selectedPatient,
      'availableBeds': instance.availableBeds,
      'isSubmitting': instance.isSubmitting,
    };

_$BedInfoImpl _$$BedInfoImplFromJson(Map<String, dynamic> json) =>
    _$BedInfoImpl(
      id: json['id'] as String,
      wardName: json['wardName'] as String,
      bedNumber: json['bedNumber'] as String,
      roomNumber: json['roomNumber'] as String,
      isAvailable: json['isAvailable'] as bool? ?? true,
    );

Map<String, dynamic> _$$BedInfoImplToJson(_$BedInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'wardName': instance.wardName,
      'bedNumber': instance.bedNumber,
      'roomNumber': instance.roomNumber,
      'isAvailable': instance.isAvailable,
    };
