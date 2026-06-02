import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/hr/view_model/hr_view_model.dart';
import 'package:paracareplus/features/hr/model/hr_model.dart';

class AttendanceTab extends ConsumerStatefulWidget {
  const AttendanceTab({super.key});

  @override
  ConsumerState<AttendanceTab> createState() => _AttendanceTabState();
}

class _AttendanceTabState extends ConsumerState<AttendanceTab> {
  bool _isClockedIn = false;
  String _simulatedTime = '--';

  @override
  Widget build(BuildContext context) {
    final attendanceList = ref.watch(hrProvider.select((s) => s.attendance));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildActiveClockWidget(),
        const SizedBox(height: AppSpacing.lg),
        _buildAttendanceTableCard(attendanceList),
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

  Widget _buildAttendanceTableCard(List<AttendanceItem> items) {
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
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(1.2),
                  4: FlexColumnWidth(1.2),
                  5: FlexColumnWidth(),
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
                  ...items.map(_buildTableRow),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(AttendanceItem row) {
    Color statusColor = AppColors.success;
    if (row.status == 'Absent') {
      statusColor = AppColors.error;
    } else if (row.status == 'Late') {
      statusColor = AppColors.secondaryAccent;
    }

    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      children: [
        _cell(row.id, isBold: true),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                row.name,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(row.role, style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        _cell('Day Shift A (09:00 - 17:00)'),
        _cell(row.checkIn),
        _cell(row.checkOut),
        _cell(row.status == 'Present' ? '0.0 hrs' : '0.0 hrs'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: statusColor.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                row.status,
                style: TextStyle(
                  color: statusColor,
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
