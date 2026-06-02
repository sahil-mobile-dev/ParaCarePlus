class StaffItem {
  final String id;
  final String name;
  final String role;
  final String department;
  final String status; // 'Active', 'On Leave', 'Suspended'
  final String mobile;
  final String email;

  const StaffItem({
    required this.id,
    required this.name,
    required this.role,
    required this.department,
    required this.status,
    required this.mobile,
    required this.email,
  });

  StaffItem copyWith({
    String? id,
    String? name,
    String? role,
    String? department,
    String? status,
    String? mobile,
    String? email,
  }) {
    return StaffItem(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      department: department ?? this.department,
      status: status ?? this.status,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
    );
  }
}

class AttendanceItem {
  final String id;
  final String name;
  final String role;
  final String status; // 'Present', 'Absent', 'Late'
  final String checkIn;
  final String checkOut;

  const AttendanceItem({
    required this.id,
    required this.name,
    required this.role,
    required this.status,
    required this.checkIn,
    required this.checkOut,
  });

  AttendanceItem copyWith({
    String? id,
    String? name,
    String? role,
    String? status,
    String? checkIn,
    String? checkOut,
  }) {
    return AttendanceItem(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      status: status ?? this.status,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
    );
  }
}

class LeaveRequest {
  final String id;
  final String name;
  final String type; // 'Sick Leave', 'Casual Leave', 'Earned Leave'
  final String duration;
  final String date;
  final String reason;
  final String status; // 'PENDING', 'APPROVED', 'REJECTED'

  const LeaveRequest({
    required this.id,
    required this.name,
    required this.type,
    required this.duration,
    required this.date,
    required this.reason,
    required this.status,
  });

  LeaveRequest copyWith({
    String? id,
    String? name,
    String? type,
    String? duration,
    String? date,
    String? reason,
    String? status,
  }) {
    return LeaveRequest(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      duration: duration ?? this.duration,
      date: date ?? this.date,
      reason: reason ?? this.reason,
      status: status ?? this.status,
    );
  }
}

class PayrollItem {
  final String id;
  final String name;
  final String designation;
  final String salary;
  final String status; // 'PAID', 'PENDING'

  const PayrollItem({
    required this.id,
    required this.name,
    required this.designation,
    required this.salary,
    required this.status,
  });

  PayrollItem copyWith({
    String? id,
    String? name,
    String? designation,
    String? salary,
    String? status,
  }) {
    return PayrollItem(
      id: id ?? this.id,
      name: name ?? this.name,
      designation: designation ?? this.designation,
      salary: salary ?? this.salary,
      status: status ?? this.status,
    );
  }
}

class RecruitmentItem {
  final String title;
  final String department;
  final int openings;
  final int applicants;
  final String status; // 'OPEN', 'CLOSED'

  const RecruitmentItem({
    required this.title,
    required this.department,
    required this.openings,
    required this.applicants,
    required this.status,
  });

  RecruitmentItem copyWith({
    String? title,
    String? department,
    int? openings,
    int? applicants,
    String? status,
  }) {
    return RecruitmentItem(
      title: title ?? this.title,
      department: department ?? this.department,
      openings: openings ?? this.openings,
      applicants: applicants ?? this.applicants,
      status: status ?? this.status,
    );
  }
}

class TrainingItem {
  final String topic;
  final String trainer;
  final String schedule;
  final String time;
  final int enrolledCount;
  final String status; // 'Active', 'Completed'

  const TrainingItem({
    required this.topic,
    required this.trainer,
    required this.schedule,
    required this.time,
    required this.enrolledCount,
    required this.status,
  });

  TrainingItem copyWith({
    String? topic,
    String? trainer,
    String? schedule,
    String? time,
    int? enrolledCount,
    String? status,
  }) {
    return TrainingItem(
      topic: topic ?? this.topic,
      trainer: trainer ?? this.trainer,
      schedule: schedule ?? this.schedule,
      time: time ?? this.time,
      enrolledCount: enrolledCount ?? this.enrolledCount,
      status: status ?? this.status,
    );
  }
}
