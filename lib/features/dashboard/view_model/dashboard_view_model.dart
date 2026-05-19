import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:paracareplus/features/dashboard/model/dashboard_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_view_model.freezed.dart';
part 'dashboard_view_model.g.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(DashboardStats()) DashboardStats stats,
    @Default([]) List<ActivityFeedItem> activityFeed,
    @Default([]) List<BedStatus> bedStatus,
    @Default([]) List<CriticalPatient> criticalPatients,
    @Default([]) List<ModuleStatus> moduleStatus,
    @Default([]) List<StaffOnDuty> staffOnDuty,
    @Default([]) List<AlertItem> alerts,
    @Default(false) bool isRefreshing,
  }) = _DashboardState;
}

@riverpod
class DashboardViewModel extends _$DashboardViewModel {
  @override
  FutureOr<DashboardState> build() async {
    return _fetchDashboardData();
  }

  Future<DashboardState> _fetchDashboardData() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));

    return DashboardState(
      stats: const DashboardStats(
        totalOpdToday: 52,
        totalIpdAdmissions: 127,
        activeEmergencyCases: 13,
        pendingLabReports: 23,
        bedOccupancyRate: 0.94,
        totalAmbulancesOnDuty: 4,
        dischargedToday: 18,
        labTestsToday: 167,
        totalRevenue: '₹1,88,028',
        revenueTrend: '+12% from last week',
      ),
      alerts: [
        const AlertItem(
          id: '1',
          message:
              'Critical Blood Stock: O+ group stock is low, only 12 units left in central blood bank.',
          type: AlertType.critical,
        ),
        const AlertItem(
          id: '2',
          message:
              'Low Drug Stock: Metformin 500mg stock is below reorder level (82 vials left).',
          type: AlertType.warning,
        ),
        const AlertItem(
          id: '3',
          message:
              'Pending Approvals: 5 leave requests and 2 purchase orders awaiting administrator approval.',
          type: AlertType.info,
        ),
      ],
      activityFeed: [
        ActivityFeedItem(
          id: '1',
          title: 'Ambulance DL01-AM-123',
          description: 'dispatched to Rajpur Road.',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          type: ActivityType.emergency,
        ),
        ActivityFeedItem(
          id: '2',
          title: 'Bill settled: ₹24,500',
          description: 'Patient Smitha Dass (IPD-4521).',
          timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
          type: ActivityType.billing,
        ),
        ActivityFeedItem(
          id: '3',
          title: 'Lab result ready',
          description: 'CBC Report for Patient Rahul Sharma.',
          timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
          type: ActivityType.labResult,
        ),
      ],
      bedStatus: [
        const BedStatus(
          department: 'Medical Ward',
          totalBeds: 50,
          occupiedBeds: 45,
          color: Colors.blue,
        ),
        const BedStatus(
          department: 'Surgical Ward',
          totalBeds: 30,
          occupiedBeds: 28,
          color: Colors.orange,
        ),
        const BedStatus(
          department: 'Maternity Ward',
          totalBeds: 20,
          occupiedBeds: 18,
          color: Colors.pink,
        ),
        const BedStatus(
          department: 'Pediatric Ward',
          totalBeds: 15,
          occupiedBeds: 12,
          color: Colors.green,
        ),
        const BedStatus(
          department: 'ICU',
          totalBeds: 10,
          occupiedBeds: 9,
          color: Colors.red,
        ),
      ],
      criticalPatients: [
        const CriticalPatient(
          id: '1',
          name: 'Madan Lal Gupta',
          ward: 'ICU',
          bed: 'Bed 3',
          condition: 'Post-surgery Trauma',
          assignedTo: 'Dr. Negi',
          severity: PatientSeverity.critical,
        ),
        const CriticalPatient(
          id: '2',
          name: 'Hema Singh',
          ward: 'ICU',
          bed: 'Bed 7',
          condition: 'Multiple Organ Failure',
          assignedTo: 'Dr. Sharma',
          severity: PatientSeverity.critical,
        ),
        const CriticalPatient(
          id: '3',
          name: 'Baby Suresh',
          ward: 'NICU',
          bed: 'Bed 2',
          condition: 'Premature 32 wks',
          assignedTo: 'Dr. Tanwar',
          severity: PatientSeverity.unstable,
        ),
      ],
      moduleStatus: [
        const ModuleStatus(
          name: 'Patient / ADT',
          status: 'ONLINE',
          health: ModuleHealth.online,
          icon: Icons.person_outline_rounded,
          subtext: 'v3.0.1 Stable',
        ),
        const ModuleStatus(
          name: 'OPD',
          status: 'ONLINE',
          health: ModuleHealth.online,
          icon: Icons.medical_services_outlined,
          subtext: 'Token System Active',
        ),
        const ModuleStatus(
          name: 'Pharmacy',
          status: 'ONLINE',
          health: ModuleHealth.online,
          icon: Icons.medication_outlined,
          subtext: 'Stock Sync Active',
        ),
        const ModuleStatus(
          name: 'Blood Bank',
          status: 'CRITICAL',
          health: ModuleHealth.critical,
          icon: Icons.bloodtype_outlined,
          subtext: 'Low Inventory Alert',
        ),
      ],
      staffOnDuty: [
        const StaffOnDuty(
          name: 'Dr. Rajesh Negi',
          role: 'Senior Physician',
          department: 'General Medicine',
          isOnDuty: true,
        ),
        const StaffOnDuty(
          name: 'Dr. Kavita Verma',
          role: 'Gynaecologist',
          department: 'Maternity',
          isOnDuty: true,
        ),
        const StaffOnDuty(
          name: 'Nurse Priya Rawat',
          role: 'Staff Nurse',
          department: 'ICU',
          isOnDuty: true,
        ),
      ],
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchDashboardData);
  }
}
