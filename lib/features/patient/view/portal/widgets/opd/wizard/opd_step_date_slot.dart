import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/patient_opd_booking_screen.dart';

class OpdStepDateSlot extends ConsumerWidget {
  const OpdStepDateSlot({
    required this.onBack,
    required this.onNext,
    super.key,
  });
  final VoidCallback onBack;
  final VoidCallback onNext;

  // Calendar dates for May 2026
  static const int daysInMonth = 31;
  static const int startOffset =
      5; // May 2026 starts on Friday (5 empty slots for Su, Mo, Tu, We, Th)

  static final List<int> apptDates = [20, 22, 28]; // Existing appts in May

  // Time Slots definitions
  static final List<Map<String, dynamic>> timeSlots = [
    {'time': '9:00 AM', 'status': 'booked'},
    {'time': '9:30 AM', 'status': 'booked'},
    {'time': '10:00 AM', 'status': 'booked'},
    {'time': '10:30 AM', 'status': 'available'}, // AI recommended
    {'time': '11:00 AM', 'status': 'available'},
    {'time': '11:30 AM', 'status': 'available'},
    {'time': '12:00 PM', 'status': 'busy'},
    {'time': '12:30 PM', 'status': 'booked'},
    {'time': '2:00 PM', 'status': 'available'},
    {'time': '2:30 PM', 'status': 'available'},
    {'time': '3:00 PM', 'status': 'booked'},
    {'time': '3:30 PM', 'status': 'available'},
    {'time': '4:00 PM', 'status': 'available'},
    {'time': '4:30 PM', 'status': 'booked'},
    {'time': '5:00 PM', 'status': 'booked'},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedSlot = ref.watch(selectedSlotProvider);
    final doc = ref.watch(selectedDoctorProvider);

    final isWide = MediaQuery.of(context).size.width > 600;

    Widget buildCalendarSection(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Date', style: AppTextStyles.labelMedium),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.02),
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                        color: AppColors.secondaryText,
                      ),
                      onPressed: () {},
                    ),
                    const Text(
                      'May 2026',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.chevron_right,
                        color: AppColors.secondaryText,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Days Headers
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 7,
                  children: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'].map((
                    day,
                  ) {
                    return Center(
                      child: Text(
                        day,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const Divider(color: AppColors.border, height: 12),
                // Grid Days
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemCount: startOffset + daysInMonth,
                  itemBuilder: (context, index) {
                    if (index < startOffset) {
                      return const SizedBox();
                    }
                    final dayNum = index - startOffset + 1;
                    final isToday = dayNum == 15;
                    final isSelected =
                        selectedDate.day == dayNum && selectedDate.month == 5;
                    final hasAppt = apptDates.contains(dayNum);

                    return InkWell(
                      onTap: () {
                        ref.read(selectedDateProvider.notifier).state =
                            DateTime(2026, 5, dayNum);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.success
                              : (isToday
                                    ? AppColors.primary
                                    : (hasAppt
                                          ? AppColors.primary.withValues(
                                              alpha: 0.12,
                                            )
                                          : Colors.transparent)),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.success
                                : (hasAppt
                                      ? AppColors.primary.withValues(alpha: 0.3)
                                      : (isToday
                                            ? AppColors.primaryLight
                                            : Colors.transparent)),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '$dayNum',
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : (isToday
                                      ? Colors.white
                                      : (hasAppt
                                            ? AppColors.primaryLight
                                            : Colors.white)),
                            fontSize: 12,
                            fontWeight: (isToday || isSelected || hasAppt)
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget buildSlotSection(BuildContext context) {
      final selectedFormatDate = '${selectedDate.day} May 2026';
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Time Slots — ${doc?.name ?? 'Dr. Anjali Sharma'} · $selectedFormatDate',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          // Legend Row
          const Row(
            children: [
              Icon(Icons.circle, color: AppColors.success, size: 8),
              SizedBox(width: 4),
              Text(
                'Available',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
              ),
              SizedBox(width: 12),
              Icon(Icons.circle, color: AppColors.error, size: 8),
              SizedBox(width: 4),
              Text(
                'Booked',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
              ),
              SizedBox(width: 12),
              Icon(Icons.circle, color: AppColors.secondaryAccent, size: 8),
              SizedBox(width: 4),
              Text(
                'Limited',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2.2,
            ),
            itemCount: timeSlots.length,
            itemBuilder: (context, index) {
              final slot = timeSlots[index];
              final time = slot['time'] as String;
              final status = slot['status'] as String;
              final isSel = selectedSlot == time;

              var cellBg = Colors.white.withValues(alpha: 0.03);
              var cellBorder = AppColors.border;
              var cellText = Colors.white;
              var enabled = true;

              if (status == 'booked') {
                cellBg = AppColors.error.withValues(alpha: 0.06);
                cellBorder = AppColors.error.withValues(alpha: 0.15);
                cellText = AppColors.secondaryText.withValues(alpha: 0.4);
                enabled = false;
              } else if (status == 'busy') {
                cellBg = AppColors.secondaryAccent.withValues(alpha: 0.06);
                cellBorder = AppColors.secondaryAccent.withValues(alpha: 0.15);
                cellText = AppColors.secondaryText.withValues(alpha: 0.4);
                enabled = false;
              }

              if (isSel) {
                cellBg = AppColors.success.withValues(alpha: 0.15);
                cellBorder = AppColors.success;
                cellText = AppColors.success;
              }

              return InkWell(
                onTap: enabled
                    ? () {
                        ref.read(selectedSlotProvider.notifier).state = time;
                      }
                    : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: cellBg,
                    border: Border.all(color: cellBorder),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    time,
                    style: TextStyle(
                      color: cellText,
                      fontSize: 11,
                      fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          // AI Recommended slot
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.06),
              border: Border.all(
                color: AppColors.success.withValues(alpha: 0.2),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.bolt_rounded, color: AppColors.success, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'AI Recommended: 10:30 AM — Lowest wait time predicted (12 min)',
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        if (isWide)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: buildCalendarSection(context)),
              const SizedBox(width: 24),
              Expanded(child: buildSlotSection(context)),
            ],
          )
        else ...[
          buildCalendarSection(context),
          const SizedBox(height: 20),
          buildSlotSection(context),
        ],
        const SizedBox(height: 28),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton.icon(
              onPressed: onBack,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.secondaryText,
                size: 16,
              ),
              label: const Text(
                'Back',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: selectedSlot != null ? onNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: AppColors.border,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              icon: const Text(
                'Next: Patient Details',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              label: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
