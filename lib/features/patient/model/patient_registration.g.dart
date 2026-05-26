// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PatientRegistrationImpl _$$PatientRegistrationImplFromJson(
  Map<String, dynamic> json,
) => _$PatientRegistrationImpl(
  title:
      $enumDecodeNullable(_$PatientTitleEnumMap, json['title']) ??
      PatientTitle.mr,
  fullName: json['fullName'] as String? ?? '',
  dateOfBirth: json['dateOfBirth'] == null
      ? null
      : DateTime.parse(json['dateOfBirth'] as String),
  age: json['age'] as String? ?? '',
  gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']) ?? Gender.male,
  bloodGroup:
      $enumDecodeNullable(_$BloodGroupEnumMap, json['bloodGroup']) ??
      BloodGroup.unknown,
  aadhaarNumber: json['aadhaarNumber'] as String? ?? '',
  ayushmanBharatId: json['ayushmanBharatId'] as String? ?? '',
  maritalStatus:
      $enumDecodeNullable(_$MaritalStatusEnumMap, json['maritalStatus']) ??
      MaritalStatus.single,
  religion:
      $enumDecodeNullable(_$ReligionEnumMap, json['religion']) ??
      Religion.hindu,
  occupation: json['occupation'] as String? ?? '',
  category:
      $enumDecodeNullable(_$CategoryEnumMap, json['category']) ??
      Category.general,
  mobileNumber: json['mobileNumber'] as String? ?? '',
  email: json['email'] as String? ?? '',
  address: json['address'] as String? ?? '',
  city: json['city'] as String? ?? '',
  state: json['state'] as String? ?? '',
  pincode: json['pincode'] as String? ?? '',
  emergencyContactName: json['emergencyContactName'] as String? ?? '',
  emergencyContactNumber: json['emergencyContactNumber'] as String? ?? '',
  allergies:
      (json['allergies'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  chronicIllnesses:
      (json['chronicIllnesses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  smokingHabit: json['smokingHabit'] as String? ?? 'Never',
  alcoholHabit: json['alcoholHabit'] as String? ?? 'Never',
  familyHistory: json['familyHistory'] as String? ?? '',
  vaccinationHistory: json['vaccinationHistory'] as String? ?? 'Unknown',
  currentMedications: json['currentMedications'] as String? ?? '',
  pastSurgeries: json['pastSurgeries'] as String? ?? '',
  visitType: json['visitType'] as String? ?? 'OPD',
  department: json['department'] as String? ?? 'General Medicine',
  doctorName: json['doctorName'] as String? ?? 'Dr. Sharma (Medicine)',
  appointmentDate: json['appointmentDate'] == null
      ? null
      : DateTime.parse(json['appointmentDate'] as String),
  appointmentSlot: json['appointmentSlot'] as String? ?? '09:00 AM - 10:00 AM',
  bedNumber: json['bedNumber'] as String? ?? 'General Ward - B101',
  paymentMode: json['paymentMode'] as String? ?? 'Cash',
  registrationFee: json['registrationFee'] as String? ?? '0.00',
  admissionReason: json['admissionReason'] as String? ?? '',
  primaryComplaint: json['primaryComplaint'] as String? ?? '',
  referredBy: json['referredBy'] as String? ?? '',
  currentStep: (json['currentStep'] as num?)?.toInt() ?? 0,
  isSubmitting: json['isSubmitting'] as bool? ?? false,
);

Map<String, dynamic> _$$PatientRegistrationImplToJson(
  _$PatientRegistrationImpl instance,
) => <String, dynamic>{
  'title': _$PatientTitleEnumMap[instance.title]!,
  'fullName': instance.fullName,
  'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
  'age': instance.age,
  'gender': _$GenderEnumMap[instance.gender]!,
  'bloodGroup': _$BloodGroupEnumMap[instance.bloodGroup]!,
  'aadhaarNumber': instance.aadhaarNumber,
  'ayushmanBharatId': instance.ayushmanBharatId,
  'maritalStatus': _$MaritalStatusEnumMap[instance.maritalStatus]!,
  'religion': _$ReligionEnumMap[instance.religion]!,
  'occupation': instance.occupation,
  'category': _$CategoryEnumMap[instance.category]!,
  'mobileNumber': instance.mobileNumber,
  'email': instance.email,
  'address': instance.address,
  'city': instance.city,
  'state': instance.state,
  'pincode': instance.pincode,
  'emergencyContactName': instance.emergencyContactName,
  'emergencyContactNumber': instance.emergencyContactNumber,
  'allergies': instance.allergies,
  'chronicIllnesses': instance.chronicIllnesses,
  'smokingHabit': instance.smokingHabit,
  'alcoholHabit': instance.alcoholHabit,
  'familyHistory': instance.familyHistory,
  'vaccinationHistory': instance.vaccinationHistory,
  'currentMedications': instance.currentMedications,
  'pastSurgeries': instance.pastSurgeries,
  'visitType': instance.visitType,
  'department': instance.department,
  'doctorName': instance.doctorName,
  'appointmentDate': instance.appointmentDate?.toIso8601String(),
  'appointmentSlot': instance.appointmentSlot,
  'bedNumber': instance.bedNumber,
  'paymentMode': instance.paymentMode,
  'registrationFee': instance.registrationFee,
  'admissionReason': instance.admissionReason,
  'primaryComplaint': instance.primaryComplaint,
  'referredBy': instance.referredBy,
  'currentStep': instance.currentStep,
  'isSubmitting': instance.isSubmitting,
};

const _$PatientTitleEnumMap = {
  PatientTitle.mr: 'mr',
  PatientTitle.mrs: 'mrs',
  PatientTitle.ms: 'ms',
  PatientTitle.dr: 'dr',
};

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
};

const _$BloodGroupEnumMap = {
  BloodGroup.unknown: 'unknown',
  BloodGroup.aPositive: 'aPositive',
  BloodGroup.aNegative: 'aNegative',
  BloodGroup.bPositive: 'bPositive',
  BloodGroup.bNegative: 'bNegative',
  BloodGroup.oPositive: 'oPositive',
  BloodGroup.oNegative: 'oNegative',
  BloodGroup.abPositive: 'abPositive',
  BloodGroup.abNegative: 'abNegative',
};

const _$MaritalStatusEnumMap = {
  MaritalStatus.single: 'single',
  MaritalStatus.married: 'married',
  MaritalStatus.widowed: 'widowed',
  MaritalStatus.divorced: 'divorced',
};

const _$ReligionEnumMap = {
  Religion.hindu: 'hindu',
  Religion.muslim: 'muslim',
  Religion.christian: 'christian',
  Religion.sikh: 'sikh',
  Religion.other: 'other',
};

const _$CategoryEnumMap = {
  Category.general: 'general',
  Category.obc: 'obc',
  Category.sc: 'sc',
  Category.st: 'st',
};
