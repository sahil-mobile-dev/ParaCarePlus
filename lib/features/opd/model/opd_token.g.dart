// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opd_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OpdTokenImpl _$$OpdTokenImplFromJson(Map<String, dynamic> json) =>
    _$OpdTokenImpl(
      searchQuery: json['searchQuery'] as String? ?? '',
      patientName: json['patientName'] as String? ?? '',
      age: json['age'] as String? ?? '',
      sex: json['sex'] as String? ?? 'Male',
      department: json['department'] as String? ?? 'General Medicine',
      doctorName: json['doctorName'] as String? ?? 'Dr. Sharma (Medicine)',
      appointmentDate: json['appointmentDate'] == null
          ? null
          : DateTime.parse(json['appointmentDate'] as String),
      appointmentSlot:
          json['appointmentSlot'] as String? ?? '09:00 AM - 10:00 AM',
      chiefComplaint: json['chiefComplaint'] as String? ?? '',
      visitType: json['visitType'] as String? ?? 'OPD',
      paymentMode: json['paymentMode'] as String? ?? 'Cash',
      appliedCharge: json['appliedCharge'] as String? ?? '50.00',
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
      isSubmitting: json['isSubmitting'] as bool? ?? false,
    );

Map<String, dynamic> _$$OpdTokenImplToJson(_$OpdTokenImpl instance) =>
    <String, dynamic>{
      'searchQuery': instance.searchQuery,
      'patientName': instance.patientName,
      'age': instance.age,
      'sex': instance.sex,
      'department': instance.department,
      'doctorName': instance.doctorName,
      'appointmentDate': instance.appointmentDate?.toIso8601String(),
      'appointmentSlot': instance.appointmentSlot,
      'chiefComplaint': instance.chiefComplaint,
      'visitType': instance.visitType,
      'paymentMode': instance.paymentMode,
      'appliedCharge': instance.appliedCharge,
      'isSearching': instance.isSearching,
      'searchResults': instance.searchResults,
      'selectedPatient': instance.selectedPatient,
      'isSubmitting': instance.isSubmitting,
    };

_$PatientSummaryImpl _$$PatientSummaryImplFromJson(Map<String, dynamic> json) =>
    _$PatientSummaryImpl(
      mrn: json['mrn'] as String,
      name: json['name'] as String,
      age: json['age'] as String,
      sex: json['sex'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$$PatientSummaryImplToJson(
  _$PatientSummaryImpl instance,
) => <String, dynamic>{
  'mrn': instance.mrn,
  'name': instance.name,
  'age': instance.age,
  'sex': instance.sex,
  'phone': instance.phone,
};
