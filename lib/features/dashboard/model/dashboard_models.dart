import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_models.freezed.dart';
part 'dashboard_models.g.dart';

@freezed
class DashboardStats with _$DashboardStats {
  const factory DashboardStats({
    @Default(0) int totalOpdToday,
    @Default(0) int totalIpdAdmissions,
    @Default(0) int activeEmergencyCases,
    @Default(0) int pendingLabReports,
    @Default(0) double bedOccupancyRate,
    @Default(0) int totalAmbulancesOnDuty,
    @Default(0) int dischargedToday,
    @Default(0) int labTestsToday,
    @Default('₹0') String totalRevenue,
    @Default('0%') String revenueTrend,
  }) = _DashboardStats;

  factory DashboardStats.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsFromJson(json);
}

@freezed
class ActivityFeedItem with _$ActivityFeedItem {
  const factory ActivityFeedItem({
    required String id,
    required String title,
    required String description,
    required DateTime timestamp,
    required ActivityType type,
  }) = _ActivityFeedItem;

  factory ActivityFeedItem.fromJson(Map<String, dynamic> json) =>
      _$ActivityFeedItemFromJson(json);
}

enum ActivityType {
  registration,
  admission,
  labResult,
  emergency,
  billing,
  pharmacy,
}

@freezed
class BedStatus with _$BedStatus {
  const factory BedStatus({
    required String department,
    required int totalBeds,
    required int occupiedBeds,
    @Default(Colors.blue) Color color,
  }) = _BedStatus;

  factory BedStatus.fromJson(Map<String, dynamic> json) =>
      _$BedStatusFromJson(json);
}

@freezed
class CriticalPatient with _$CriticalPatient {
  const factory CriticalPatient({
    required String id,
    required String name,
    required String ward,
    required String bed,
    required String condition,
    required String assignedTo,
    required PatientSeverity severity,
  }) = _CriticalPatient;

  factory CriticalPatient.fromJson(Map<String, dynamic> json) =>
      _$CriticalPatientFromJson(json);
}

enum PatientSeverity { critical, unstable, stable }

@freezed
class ModuleStatus with _$ModuleStatus {
  const factory ModuleStatus({
    required String name,
    required String status,
    required ModuleHealth health,
    required IconData icon,
    String? subtext,
  }) = _ModuleStatus;
}

enum ModuleHealth { online, offline, critical, partial }

@freezed
class StaffOnDuty with _$StaffOnDuty {
  const factory StaffOnDuty({
    required String name,
    required String role,
    required String department,
    required bool isOnDuty,
  }) = _StaffOnDuty;

  factory StaffOnDuty.fromJson(Map<String, dynamic> json) =>
      _$StaffOnDutyFromJson(json);
}

@freezed
class AlertItem with _$AlertItem {
  const factory AlertItem({
    required String id,
    required String message,
    required AlertType type,
  }) = _AlertItem;
}

enum AlertType { critical, warning, info }
