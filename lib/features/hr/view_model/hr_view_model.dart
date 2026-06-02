import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/hr_model.dart';

class HrState {
  final String activeTab;
  final List<StaffItem> staffDirectory;
  final List<AttendanceItem> attendance;
  final List<LeaveRequest> leaves;
  final List<PayrollItem> payrollList;
  final List<RecruitmentItem> recruitmentList;
  final List<TrainingItem> trainingList;
  final bool isLoading;

  const HrState({
    required this.activeTab,
    required this.staffDirectory,
    required this.attendance,
    required this.leaves,
    required this.payrollList,
    required this.recruitmentList,
    required this.trainingList,
    this.isLoading = false,
  });

  HrState copyWith({
    String? activeTab,
    List<StaffItem>? staffDirectory,
    List<AttendanceItem>? attendance,
    List<LeaveRequest>? leaves,
    List<PayrollItem>? payrollList,
    List<RecruitmentItem>? recruitmentList,
    List<TrainingItem>? trainingList,
    bool? isLoading,
  }) {
    return HrState(
      activeTab: activeTab ?? this.activeTab,
      staffDirectory: staffDirectory ?? this.staffDirectory,
      attendance: attendance ?? this.attendance,
      leaves: leaves ?? this.leaves,
      payrollList: payrollList ?? this.payrollList,
      recruitmentList: recruitmentList ?? this.recruitmentList,
      trainingList: trainingList ?? this.trainingList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class HrNotifier extends StateNotifier<HrState> {
  HrNotifier() : super(_initialState());

  void setTab(String tab) {
    state = state.copyWith(activeTab: tab);
  }

  // Staff actions
  void addStaff(StaffItem staff) {
    state = state.copyWith(staffDirectory: [...state.staffDirectory, staff]);
  }

  void updateStaffStatus(String id, String status) {
    final updated = state.staffDirectory.map((s) {
      if (s.id == id) return s.copyWith(status: status);
      return s;
    }).toList();
    state = state.copyWith(staffDirectory: updated);
  }

  // Leave actions
  void approveLeave(String id) {
    final updated = state.leaves.map((l) {
      if (l.id == id) return l.copyWith(status: 'APPROVED');
      return l;
    }).toList();
    state = state.copyWith(leaves: updated);
  }

  void rejectLeave(String id) {
    final updated = state.leaves.map((l) {
      if (l.id == id) return l.copyWith(status: 'REJECTED');
      return l;
    }).toList();
    state = state.copyWith(leaves: updated);
  }

  // Payroll actions
  void processPayroll(String id) {
    final updated = state.payrollList.map((p) {
      if (p.id == id) return p.copyWith(status: 'PAID');
      return p;
    }).toList();
    state = state.copyWith(payrollList: updated);
  }

  // Recruitment actions
  void createJobVacancy({
    required String title,
    required String department,
    required int openings,
  }) {
    final newItem = RecruitmentItem(
      title: title,
      department: department,
      openings: openings,
      applicants: 0,
      status: 'OPEN',
    );
    state = state.copyWith(recruitmentList: [...state.recruitmentList, newItem]);
  }

  // Training actions
  void scheduleTraining({
    required String topic,
    required String trainer,
    required String schedule,
    required String time,
  }) {
    final newItem = TrainingItem(
      topic: topic,
      trainer: trainer,
      schedule: schedule,
      time: time,
      enrolledCount: 0,
      status: 'Active',
    );
    state = state.copyWith(trainingList: [...state.trainingList, newItem]);
  }

  static HrState _initialState() {
    return const HrState(
      activeTab: 'Dashboard',
      staffDirectory: [
        StaffItem(
          id: 'E-001',
          name: 'Suresh Negi',
          role: 'Nurse',
          department: 'Nursing',
          status: 'Active',
          mobile: '98765-12345',
          email: 'suresh@paracare.plus',
        ),
        StaffItem(
          id: 'E-002',
          name: 'Dr. Negi',
          role: 'Chief Medical Officer',
          department: 'Clinical',
          status: 'Active',
          mobile: '98765-12346',
          email: 'negi@paracare.plus',
        ),
        StaffItem(
          id: 'E-003',
          name: 'Sarla Bisht',
          role: 'Accountant',
          department: 'Billing',
          status: 'On Leave',
          mobile: '98765-12347',
          email: 'sarla@paracare.plus',
        ),
      ],
      attendance: [
        AttendanceItem(
          id: 'E-001',
          name: 'Suresh Negi',
          role: 'Nurse',
          status: 'Present',
          checkIn: '08:00 AM',
          checkOut: '—',
        ),
        AttendanceItem(
          id: 'E-002',
          name: 'Dr. Negi',
          role: 'Chief Medical Officer',
          status: 'Late',
          checkIn: '08:45 AM',
          checkOut: '—',
        ),
        AttendanceItem(
          id: 'E-003',
          name: 'Sarla Bisht',
          role: 'Accountant',
          status: 'Absent',
          checkIn: '—',
          checkOut: '—',
        ),
      ],
      leaves: [
        LeaveRequest(
          id: 'LR-101',
          name: 'Suresh Negi',
          type: 'Sick Leave',
          duration: '2 Days',
          date: '12 May - 14 May',
          reason: 'High fever. Medical certificate uploaded.',
          status: 'PENDING',
        ),
        LeaveRequest(
          id: 'LR-102',
          name: 'Sarla Bisht',
          type: 'Earned Leave',
          duration: '5 Days',
          date: '15 May - 20 May',
          reason: 'Personal work in hometown.',
          status: 'APPROVED',
        ),
      ],
      payrollList: [
        PayrollItem(
          id: 'E-001',
          name: 'Suresh Negi',
          designation: 'Nurse',
          salary: '₹45,000',
          status: 'PAID',
        ),
        PayrollItem(
          id: 'E-002',
          name: 'Dr. Negi',
          designation: 'Chief Medical Officer',
          salary: '₹1,50,000',
          status: 'PAID',
        ),
        PayrollItem(
          id: 'E-003',
          name: 'Sarla Bisht',
          designation: 'Accountant',
          salary: '₹35,000',
          status: 'PENDING',
        ),
      ],
      recruitmentList: [
        RecruitmentItem(
          title: 'Staff Nurse',
          department: 'Nursing',
          openings: 5,
          applicants: 24,
          status: 'OPEN',
        ),
        RecruitmentItem(
          title: 'Resident Doctor',
          department: 'Emergency',
          openings: 2,
          applicants: 12,
          status: 'OPEN',
        ),
        RecruitmentItem(
          title: 'Medical Lab Technician',
          department: 'Laboratory',
          openings: 3,
          applicants: 8,
          status: 'OPEN',
        ),
      ],
      trainingList: [
        TrainingItem(
          topic: 'ACLS Training',
          trainer: 'Dr. Sharma',
          schedule: '15-05-2026',
          time: '4 hours',
          enrolledCount: 18,
          status: 'Active',
        ),
        TrainingItem(
          topic: 'Hospital Infection Control',
          trainer: 'Nrs. Joshi',
          schedule: '18-05-2026',
          time: '2 hours',
          enrolledCount: 45,
          status: 'Active',
        ),
      ],
    );
  }
}

final hrProvider = StateNotifierProvider<HrNotifier, HrState>((ref) {
  return HrNotifier();
});

final hrTabProvider = StateProvider<String>((ref) => 'Dashboard');
