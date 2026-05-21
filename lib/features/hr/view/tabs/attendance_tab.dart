import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AttendanceTab extends StatefulWidget {
  const AttendanceTab({super.key});

  @override
  State<AttendanceTab> createState() => _AttendanceTabState();
}

class _AttendanceTabState extends State<AttendanceTab> {
  final List<Map<String, dynamic>> _attendance = [
    {
      'id': 'EMP-1042',
      'name': 'Dr. Alok Verma',
      'role': 'HOD Cardiology',
      'shift': 'Day Shift A (09:00 - 17:00)',
      'in': '08:52 AM',
      'out': '05:08 PM',
      'overtime': '0.3 hrs',
      'status': 'Present',
      'statusColor': AppColors.success,
    },
    {
      'id': 'EMP-2210',
      'name': 'Shashi Kiran',
      'role': 'Senior Staff Nurse',
      'shift': 'Night Shift B (20:00 - 08:00)',
      'in': '07:45 PM',
      'out': '08:02 AM',
      'overtime': '1.0 hrs',
      'status': 'Present',
      'statusColor': AppColors.success,
    },
    {
      'id': 'EMP-1102',
      'name': 'Dr. Meera Gupta',
      'role': 'Senior Radiologist',
      'shift': 'Day Shift B (11:00 - 19:00)',
      'in': '10:58 AM',
      'out': '--',
      'overtime': '0.0 hrs',
      'status': 'On Duty',
      'statusColor': AppColors.primary,
    },
    {
      'id': 'EMP-3049',
      'name': 'Aman Rawat',
      'role': 'HR Operations Lead',
      'shift': 'Day Shift A (09:00 - 17:00)',
      'in': '09:12 AM',
      'out': '--',
      'overtime': '0.0 hrs',
      'status': 'Late In',
      'statusColor': AppColors.secondaryAccent,
    },
    {
      'id': 'EMP-4421',
      'name': 'Sanjay Sen',
      'role': 'Billing Executive',
      'shift': 'Day Shift A (09:00 - 17:00)',
      'in': '--',
      'out': '--',
      'overtime': '0.0 hrs',
      'status': 'Absent',
      'statusColor': AppColors.error,
    },
  ];

  bool _isClockedIn = false;
  String _simulatedTime = '--';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildActiveClockWidget(),
        const SizedBox(height: AppSpacing.lg),
        _buildAttendanceTableCard(),
      ],
    );
  }

  Widget _buildActiveClockWidget() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(
                Icons.fingerprint_rounded,
                color: AppColors.primary,
                size: 28,
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Biometric Shift Console',
                    style: AppTextStyles.titleSmall,
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Mock shift tracker: Day Shift A (09:00 - 17:00)',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              if (_isClockedIn)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(
                    'Active Shift Work Time | Clocked in at $_simulatedTime',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _isClockedIn = !_isClockedIn;
                    _simulatedTime = _isClockedIn ? '09:02 AM' : '--';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: _isClockedIn
                          ? AppColors.success
                          : AppColors.secondaryAccent,
                      content: Text(
                        _isClockedIn
                            ? 'Biometric punch verified. Clocked IN successfully at 09:02 AM.'
                            : 'Biometric punch verified. Clocked OUT successfully.',
                      ),
                    ),
                  );
                },
                icon: Icon(
                  _isClockedIn ? Icons.logout_rounded : Icons.login_rounded,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isClockedIn
                      ? AppColors.error
                      : AppColors.success,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceTableCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.date_range_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Biometric Attendance Registers',
                      style: AppTextStyles.titleSmall,
                    ),
                  ],
                ),
                Text(
                  'Date: 2026-05-21',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.border, height: 1),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 850),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(1.2),
                  1: FlexColumnWidth(1.8),
                  2: FlexColumnWidth(2.0),
                  3: FlexColumnWidth(1.2),
                  4: FlexColumnWidth(1.2),
                  5: FlexColumnWidth(1.0),
                  6: FlexColumnWidth(1.2),
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                    ),
                    children: [
                      _headerCell('Staff ID'),
                      _headerCell('Staff Member'),
                      _headerCell('Assigned Shift Schedule'),
                      _headerCell('Punch In'),
                      _headerCell('Punch Out'),
                      _headerCell('Overtime'),
                      _headerCell('Shift Status'),
                    ],
                  ),
                  ..._attendance.map((row) => _buildTableRow(row)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(Map<String, dynamic> row) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      children: [
        _cell(row['id'] as String, isBold: true),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                row['name'] as String,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(row['role'] as String, style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        _cell(row['shift'] as String),
        _cell(row['in'] as String),
        _cell(row['out'] as String),
        _cell(row['overtime'] as String),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (row['statusColor'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: (row['statusColor'] as Color).withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                row['status'] as String,
                style: TextStyle(
                  color: row['statusColor'] as Color,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _headerCell(String t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Text(
        t,
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.secondaryText,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _cell(String val, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          val,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
