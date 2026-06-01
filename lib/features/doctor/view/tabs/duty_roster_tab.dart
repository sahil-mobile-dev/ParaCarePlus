import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class DutyRosterTab extends StatefulWidget {
  const DutyRosterTab({super.key});

  @override
  State<DutyRosterTab> createState() => _DutyRosterTabState();
}

class _DutyRosterTabState extends State<DutyRosterTab> {
  int _selectedDayIndex = 1; // Tuesday by default

  final List<Map<String, dynamic>> _weeklyRoster = [
    {
      'day': 'Mon',
      'date': 'May 25',
      'title': 'General Medicine OPD',
      'time': '09:00 AM - 01:00 PM',
      'location': 'OPD Complex · Room 302',
      'colleagues': 'Nurse Priya Rawat, Dr. Negi',
      'status': 'Completed',
    },
    {
      'day': 'Tue',
      'date': 'May 26',
      'title': 'CCU Ward Rounds & OT Slot B',
      'time': '08:00 AM - 05:00 PM',
      'location': 'OT Suite 3 · Cardio ICU B',
      'colleagues': 'Dr. Sanjay Negi (Anaesth), Nurse Kavita',
      'status': 'Active Shift',
    },
    {
      'day': 'Wed',
      'date': 'May 27',
      'title': 'Cardiology Diagnostics & Labs',
      'time': '09:00 AM - 01:30 PM',
      'location': 'Echocardiography Lab Room 102',
      'colleagues': 'Lab Tech Suresh Gupta, Nurse Priya',
      'status': 'Pending',
    },
    {
      'day': 'Thu',
      'date': 'May 28',
      'title': 'Grand Rounds & General Consults',
      'time': '09:00 AM - 05:00 PM',
      'location': 'Ward Block B · OPD Complex',
      'colleagues': 'Dr. Rajesh Sharma, Nurse Kavita',
      'status': 'Pending',
    },
    {
      'day': 'Fri',
      'date': 'May 29',
      'title': 'General Medicine OPD & Research',
      'time': '09:00 AM - 01:00 PM',
      'location': 'OPD Room 302 · Library Desk',
      'colleagues': 'Nurse Priya Rawat',
      'status': 'Pending',
    },
    {
      'day': 'Sat',
      'date': 'May 30',
      'title': 'CCU On-Call Duty (Emergency)',
      'time': '08:00 PM - 08:00 AM (Night)',
      'location': 'CCU Emergency Console',
      'colleagues': 'Dr. Sharma (On-call support)',
      'status': 'Pending',
    },
    {
      'day': 'Sun',
      'date': 'May 31',
      'title': 'Weekly Holiday (On-Call Standby)',
      'time': 'Full Day Standby',
      'location': 'Home Standby',
      'colleagues': 'None',
      'status': 'Pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 950;
    final selectedShift = _weeklyRoster[_selectedDayIndex];

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: AppSpacing.lg),
          _buildMetricsRow(),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Left side - Roster Weekly calendar
                      Expanded(flex: 10, child: _buildWeeklyCalendar()),
                      const SizedBox(width: AppSpacing.lg),
                      // Right side - Selected shift details
                      Expanded(
                        flex: 12,
                        child: _buildShiftDetails(selectedShift),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(child: _buildWeeklyCalendar()),
                      const SizedBox(height: AppSpacing.lg),
                      Expanded(child: _buildShiftDetails(selectedShift)),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Duty Roster & Shifts', style: AppTextStyles.titleMedium),
        const SizedBox(height: 2),
        Text(
          'Track your hospital weekly schedules, clinical consult slots, and surgery timings.',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsRow() {
    final items = [
      (
        'Active Duty Hours',
        '42 hrs / wk',
        Icons.access_time_rounded,
        AppColors.primaryLight,
      ),
      (
        'On-Call Night Slots',
        '1 Scheduled',
        Icons.nightlight_round,
        Colors.purple,
      ),
      (
        'Leave Balance',
        '14 Days Left',
        Icons.assignment_turned_in_outlined,
        Colors.green,
      ),
    ];

    return Row(
      children: items.map((i) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Icon(i.$3, color: i.$4, size: 20),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      i.$1,
                      style: AppTextStyles.labelSmall.copyWith(fontSize: 9),
                    ),
                    Text(
                      i.$2,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildWeeklyCalendar() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'WEEKLY SCHEDULE (MAY 25 - MAY 31)',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: ListView.separated(
              itemCount: _weeklyRoster.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final shift = _weeklyRoster[i];
                final isSelected = _selectedDayIndex == i;
                final isActive = shift['status'] == 'Active Shift';
                final isCompleted = shift['status'] == 'Completed';

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.surface
                        : AppColors.background.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : isActive
                          ? AppColors.secondaryAccent.withValues(alpha: 0.5)
                          : AppColors.border,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    onTap: () => setState(() => _selectedDayIndex = i),
                    leading: Container(
                      width: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withValues(alpha: 0.2)
                            : AppColors.card,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            shift['day'] as String,
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.primaryLight
                                  : AppColors.secondaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            (shift['date'] as String).split(' ').last,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.primaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: Text(
                      shift['title'] as String,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      shift['time'] as String,
                      style: AppTextStyles.bodySmall.copyWith(fontSize: 10.5),
                    ),
                    trailing: isCompleted
                        ? const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.success,
                            size: 18,
                          )
                        : isActive
                        ? const Icon(
                            Icons.star_rounded,
                            color: AppColors.secondaryAccent,
                            size: 18,
                          )
                        : const Icon(
                            Icons.radio_button_unchecked_rounded,
                            color: AppColors.border,
                            size: 16,
                          ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftDetails(Map<String, dynamic> shift) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_today_rounded,
                  color: AppColors.primaryLight,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${shift['day']}, ${shift['date']}',
                      style: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      shift['title'] as String,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.border, height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildSectionHeader('Shift Timing & Duration'),
                const SizedBox(height: 6),
                Text(
                  shift['time'] as String,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSectionHeader('Operational Clinical Room'),
                const SizedBox(height: 6),
                Text(
                  shift['location'] as String,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSectionHeader('On-Duty Staff & Colleagues'),
                const SizedBox(height: 6),
                Text(
                  shift['colleagues'] as String,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.secondaryText,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        color: AppColors.primaryLight,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'If you need to swap this shift, request must be submitted at least 24 hours prior to duty commencement.',
                          style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.border, height: 20),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  icon: const Icon(Icons.swap_horiz_rounded, size: 18),
                  label: const Text('Request Shift Swap'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Swap request submitted. Awaiting approval from Clinical HR.',
                        ),
                        backgroundColor: AppColors.primary,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.assignment_ind_outlined, size: 18),
                  label: const Text('Leave Request'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.card,
                    foregroundColor: AppColors.primaryText,
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Leave submission desk logged.'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: AppTextStyles.labelSmall.copyWith(
        color: AppColors.secondaryText,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }
}
