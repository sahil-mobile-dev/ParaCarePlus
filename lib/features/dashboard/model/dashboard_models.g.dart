// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardStatsImpl _$$DashboardStatsImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardStatsImpl(
  totalOpdToday: (json['totalOpdToday'] as num?)?.toInt() ?? 0,
  totalIpdAdmissions: (json['totalIpdAdmissions'] as num?)?.toInt() ?? 0,
  activeEmergencyCases: (json['activeEmergencyCases'] as num?)?.toInt() ?? 0,
  pendingLabReports: (json['pendingLabReports'] as num?)?.toInt() ?? 0,
  bedOccupancyRate: (json['bedOccupancyRate'] as num?)?.toDouble() ?? 0.0,
  totalAmbulancesOnDuty: (json['totalAmbulancesOnDuty'] as num?)?.toInt() ?? 0,
  dischargedToday: (json['dischargedToday'] as num?)?.toInt() ?? 0,
  labTestsToday: (json['labTestsToday'] as num?)?.toInt() ?? 0,
  totalRevenue: json['totalRevenue'] as String? ?? '₹0',
  revenueTrend: json['revenueTrend'] as String? ?? '0%',
);

Map<String, dynamic> _$$DashboardStatsImplToJson(
  _$DashboardStatsImpl instance,
) => <String, dynamic>{
  'totalOpdToday': instance.totalOpdToday,
  'totalIpdAdmissions': instance.totalIpdAdmissions,
  'activeEmergencyCases': instance.activeEmergencyCases,
  'pendingLabReports': instance.pendingLabReports,
  'bedOccupancyRate': instance.bedOccupancyRate,
  'totalAmbulancesOnDuty': instance.totalAmbulancesOnDuty,
  'dischargedToday': instance.dischargedToday,
  'labTestsToday': instance.labTestsToday,
  'totalRevenue': instance.totalRevenue,
  'revenueTrend': instance.revenueTrend,
};

_$ActivityFeedItemImpl _$$ActivityFeedItemImplFromJson(
  Map<String, dynamic> json,
) => _$ActivityFeedItemImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
);

Map<String, dynamic> _$$ActivityFeedItemImplToJson(
  _$ActivityFeedItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'timestamp': instance.timestamp.toIso8601String(),
  'type': _$ActivityTypeEnumMap[instance.type],
};

const _$ActivityTypeEnumMap = {
  ActivityType.registration: 'registration',
  ActivityType.admission: 'admission',
  ActivityType.labResult: 'labResult',
  ActivityType.emergency: 'emergency',
  ActivityType.billing: 'billing',
  ActivityType.pharmacy: 'pharmacy',
};

_$BedStatusImpl _$$BedStatusImplFromJson(Map<String, dynamic> json) =>
    _$BedStatusImpl(
      department: json['department'] as String,
      totalBeds: (json['totalBeds'] as num).toInt(),
      occupiedBeds: (json['occupiedBeds'] as num).toInt(),
    );

Map<String, dynamic> _$$BedStatusImplToJson(_$BedStatusImpl instance) =>
    <String, dynamic>{
      'department': instance.department,
      'totalBeds': instance.totalBeds,
      'occupiedBeds': instance.occupiedBeds,
    };

_$CriticalPatientImpl _$$CriticalPatientImplFromJson(
  Map<String, dynamic> json,
) => _$CriticalPatientImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  ward: json['ward'] as String,
  bed: json['bed'] as String,
  condition: json['condition'] as String,
  assignedTo: json['assignedTo'] as String,
  severity: $enumDecode(_$PatientSeverityEnumMap, json['severity']),
);

Map<String, dynamic> _$$CriticalPatientImplToJson(
  _$CriticalPatientImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'ward': instance.ward,
  'bed': instance.bed,
  'condition': instance.condition,
  'assignedTo': instance.assignedTo,
  'severity': _$PatientSeverityEnumMap[instance.severity],
};

const _$PatientSeverityEnumMap = {
  PatientSeverity.critical: 'critical',
  PatientSeverity.unstable: 'unstable',
  PatientSeverity.stable: 'stable',
};

_$StaffOnDutyImpl _$$StaffOnDutyImplFromJson(Map<String, dynamic> json) =>
    _$StaffOnDutyImpl(
      name: json['name'] as String,
      role: json['role'] as String,
      department: json['department'] as String,
      isOnDuty: json['isOnDuty'] as bool,
    );

Map<String, dynamic> _$$StaffOnDutyImplToJson(_$StaffOnDutyImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'role': instance.role,
      'department': instance.department,
      'isOnDuty': instance.isOnDuty,
    };
