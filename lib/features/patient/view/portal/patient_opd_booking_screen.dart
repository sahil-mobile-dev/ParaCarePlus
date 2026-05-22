import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

// State models and providers for booking
class Hospital {
  const Hospital(this.id, this.name, this.location, this.distanceKm);
  final String id;
  final String name;
  final String location;
  final double distanceKm;
}

class Doctor {
  const Doctor(
    this.name,
    this.specialty,
    this.degree,
    this.availability,
    this.queueInfo,
  );
  final String name;
  final String specialty;
  final String degree;
  final String availability;
  final String queueInfo;
}

final hospitals = [
  const Hospital('1', 'AIIMS Rishikesh', 'Virbhadra Road, Rishikesh', 1.8),
  const Hospital(
    '2',
    'Government Hospital Rishikesh',
    'Koyal Ghati, Rishikesh',
    3.2,
  ),
  const Hospital('3', 'Doon Medical College Hospital', 'Dehradun', 42.5),
];

final doctorsList = [
  const Doctor(
    'Dr. Satish Semwal',
    'General Medicine',
    'MBBS, MD',
    '9:00 AM - 1:00 PM',
    '4 in Queue (Wait: ~12m)',
  ),
  const Doctor(
    'Dr. Anjali Barthwal',
    'Pulmonology',
    'MD, FNB (Pulmonology)',
    '10:00 AM - 3:00 PM',
    '1 in Queue (Wait: ~5m)',
  ),
  const Doctor(
    'Dr. Pankaj Dobhal',
    'Cardiology',
    'MD, DM (Cardio)',
    '11:00 AM - 4:00 PM',
    '8 in Queue (Wait: ~45m)',
  ),
  const Doctor(
    'Dr. Meera Negi',
    'Pediatrics',
    'MBBS, DCH',
    '9:30 AM - 2:00 PM',
    '2 in Queue (Wait: ~8m)',
  ),
];

// Booking States
final selectedHospitalProvider = StateProvider<Hospital?>(
  (ref) => hospitals[0],
);
final selectedSpecialtyProvider = StateProvider<String>(
  (ref) => 'General Medicine',
);
final selectedDoctorProvider = StateProvider<Doctor?>((ref) => doctorsList[0]);
final selectedDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now().add(const Duration(days: 1)),
);
final selectedSlotProvider = StateProvider<String?>((ref) => null);

class PatientOpdBookingScreen extends ConsumerStatefulWidget {
  const PatientOpdBookingScreen({super.key});

  @override
  ConsumerState<PatientOpdBookingScreen> createState() =>
      _PatientOpdBookingScreenState();
}

class _PatientOpdBookingScreenState
    extends ConsumerState<PatientOpdBookingScreen> {
  int _currentStep = 0;
  bool _isBooking = false;
  String? _generatedToken;

  void _confirmBooking() {
    setState(() {
      _isBooking = true;
    });

    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isBooking = false;
          _generatedToken =
              'OPD-UTK-${10000 + (DateTime.now().millisecond % 90000)}';
          _currentStep = 2; // Step index 2 is success receipt screen
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final hosp = ref.watch(selectedHospitalProvider);
    final spec = ref.watch(selectedSpecialtyProvider);
    final doc = ref.watch(selectedDoctorProvider);
    final date = ref.watch(selectedDateProvider);
    final slot = ref.watch(selectedSlotProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(activeRouteName: RouteNames.patientOPD),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        iconTheme: const IconThemeData(color: AppColors.primaryText),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: AppColors.primaryText),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'OPD Appointment Engine',
          style: AppTextStyles.titleSmall,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.history_rounded,
              color: AppColors.primaryText,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No previous active appointments.'),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Step Progress Bar
          _buildStepProgress(),

          Expanded(
            child: _currentStep == 0
                ? _buildStepSelection(hosp, spec, doc)
                : _currentStep == 1
                ? _buildStepDateSlot(date, slot, doc)
                : _buildStepReceipt(hosp, doc, date, slot),
          ),

          if (_currentStep < 2) _buildNavigationFooter(hosp, doc, slot),
        ],
      ),
    );
  }

  Widget _buildStepProgress() {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStepIndicator('1', 'Consult', _currentStep >= 0),
          _buildStepDivider(_currentStep >= 1),
          _buildStepIndicator('2', 'Slot & Time', _currentStep >= 1),
          _buildStepDivider(_currentStep >= 2),
          _buildStepIndicator('3', 'Token', _currentStep >= 2),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(String number, String label, bool isDone) {
    return Column(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: isDone ? AppColors.primary : AppColors.card,
          child: isDone
              ? const Icon(Icons.check_rounded, color: Colors.white, size: 14)
              : Text(
                  number,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: isDone ? AppColors.primaryText : AppColors.secondaryText,
            fontSize: 9.5,
            fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildStepDivider(bool isActive) {
    return Container(
      width: 40,
      height: 2,
      color: isActive ? AppColors.primary : AppColors.border,
    );
  }

  Widget _buildStepSelection(Hospital? hosp, String spec, Doctor? doc) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        // Hospital Selector
        const Text(
          '1. SELECT REGIONAL HOSPITAL',
          style: AppTextStyles.labelSmall,
        ),
        const SizedBox(height: 8),
        ...hospitals.map((h) {
          final isSel = hosp?.id == h.id;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isSel
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : AppColors.card,
              border: Border.all(
                color: isSel ? AppColors.primary : AppColors.border,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                Icons.local_hospital_rounded,
                color: isSel ? AppColors.primaryLight : AppColors.secondaryText,
              ),
              title: Text(
                h.name,
                style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
              ),
              subtitle: Text(
                '${h.location} • ${h.distanceKm} km away',
                style: AppTextStyles.labelSmall,
              ),
              trailing: isSel
                  ? const Icon(
                      Icons.radio_button_checked_rounded,
                      color: AppColors.primary,
                    )
                  : const Icon(
                      Icons.radio_button_off_rounded,
                      color: AppColors.secondaryText,
                    ),
              onTap: () {
                ref.read(selectedHospitalProvider.notifier).state = h;
              },
            ),
          );
        }),

        const SizedBox(height: 16),

        // Specialty Selector
        const Text('2. SELECT SPECIALTY', style: AppTextStyles.labelSmall),
        const SizedBox(height: 10),
        SizedBox(
          height: 38,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children:
                [
                  'General Medicine',
                  'Pulmonology',
                  'Cardiology',
                  'Pediatrics',
                ].map((s) {
                  final isSel = spec == s;
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(s),
                      selected: isSel,
                      selectedColor: AppColors.primary,
                      backgroundColor: AppColors.card,
                      labelStyle: TextStyle(
                        color: isSel ? Colors.white : AppColors.secondaryText,
                        fontSize: 11,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSel
                              ? AppColors.primaryLight
                              : AppColors.border,
                        ),
                      ),
                      onSelected: (_) {
                        ref.read(selectedSpecialtyProvider.notifier).state = s;
                        // Auto switch doctor matching specialty
                        final match = doctorsList.firstWhere(
                          (d) => d.specialty == s,
                          orElse: () => doctorsList[0],
                        );
                        ref.read(selectedDoctorProvider.notifier).state = match;
                      },
                    ),
                  );
                }).toList(),
          ),
        ),

        const SizedBox(height: 20),

        // Doctors List
        const Text(
          '3. AVAILABLE SPECIALISTS TODAY',
          style: AppTextStyles.labelSmall,
        ),
        const SizedBox(height: 10),
        if (doc != null)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.5),
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.primaryLight,
                      child: Icon(
                        Icons.person_pin_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doc.name,
                            style: AppTextStyles.labelLarge.copyWith(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '${doc.specialty} (${doc.degree})',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.secondaryText,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.timer_outlined,
                                size: 12,
                                color: AppColors.secondaryAccent,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                doc.availability,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.secondaryAccent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24, color: AppColors.border),
                Row(
                  children: [
                    const Icon(
                      Icons.people_outline_rounded,
                      color: AppColors.success,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Live Waiting Status: ',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                    Text(
                      doc.queueInfo,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildStepDateSlot(DateTime date, String? slot, Doctor? doc) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        // Date Selector Cards
        const Text('SELECT CONSULTATION DATE', style: AppTextStyles.labelSmall),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            final cardDate = DateTime.now().add(Duration(days: index + 1));
            final isSel = date.day == cardDate.day;
            final weekdayName = [
              'MON',
              'TUE',
              'WED',
              'THU',
              'FRI',
              'SAT',
              'SUN',
            ][cardDate.weekday - 1];
            final monthName = [
              'JAN',
              'FEB',
              'MAR',
              'APR',
              'MAY',
              'JUN',
              'JUL',
              'AUG',
              'SEP',
              'OCT',
              'NOV',
              'DEC',
            ][cardDate.month - 1];

            return InkWell(
              onTap: () {
                ref.read(selectedDateProvider.notifier).state = cardDate;
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 72,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSel ? AppColors.primary : AppColors.card,
                  border: Border.all(
                    color: isSel ? AppColors.primaryLight : AppColors.border,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      weekdayName,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isSel ? Colors.white : AppColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${cardDate.day}',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      monthName,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isSel
                            ? Colors.white.withValues(alpha: 0.8)
                            : AppColors.secondaryText,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 24),

        // Slots grid
        const Text('AVAILABLE SLOTS', style: AppTextStyles.labelSmall),
        const SizedBox(height: 10),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 2.3,
          children:
              [
                '09:15 AM',
                '10:00 AM',
                '10:45 AM',
                '11:30 AM',
                '02:00 PM',
                '02:45 PM',
              ].map((s) {
                final isSel = slot == s;
                return InkWell(
                  onTap: () {
                    ref.read(selectedSlotProvider.notifier).state = s;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSel
                          ? AppColors.success.withValues(alpha: 0.15)
                          : AppColors.card,
                      border: Border.all(
                        color: isSel ? AppColors.success : AppColors.border,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      s,
                      style: TextStyle(
                        color: isSel ? AppColors.success : Colors.white,
                        fontSize: 12,
                        fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),

        const SizedBox(height: 24),

        // Live Queue Banner
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: AppColors.primaryLight,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Bookings made via the ParaCarePlus engine sync directly with the state E-Health registries, ensuring minimal physical queue wait times.',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.secondaryText,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepReceipt(
    Hospital? hosp,
    Doctor? doc,
    DateTime date,
    String? slot,
  ) {
    final formatStrDate = '${date.day}/${date.month}/${date.year}';
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.success.withValues(alpha: 0.5)),
            boxShadow: [
              BoxShadow(
                color: AppColors.success.withValues(alpha: 0.1),
                blurRadius: 16,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.success,
                size: 52,
              ),
              const SizedBox(height: 14),
              const Text(
                'OPD SLOT REGISTERED SECURELY',
                style: AppTextStyles.labelLarge,
              ),
              Text(
                'ABDM Token generated successfully',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.success,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: AppColors.border),
              const SizedBox(height: 10),
              _buildReceiptRow('PATIENT', 'RAMESH KUMAR'),
              _buildReceiptRow('ABHA ID', '43-8912-3456-7890'),
              _buildReceiptRow('HOSPITAL', hosp?.name ?? 'AIIMS Rishikesh'),
              _buildReceiptRow('DOCTOR', doc?.name ?? 'Dr. Satish Semwal'),
              _buildReceiptRow(
                'DEPARTMENT',
                doc?.specialty ?? 'General Medicine',
              ),
              _buildReceiptRow('APPOINTMENT DATE', formatStrDate),
              _buildReceiptRow('TIME SLOT', slot ?? '09:15 AM'),
              const SizedBox(height: 12),
              const Divider(color: AppColors.border),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    const Text(
                      'DIGITAL TOKEN NUMBER',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _generatedToken ?? '',
                      style: const TextStyle(
                        color: AppColors.secondaryAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Return to Home Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 10,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationFooter(Hospital? hosp, Doctor? doc, String? slot) {
    final nextEnabled = _currentStep == 0
        ? (hosp != null && doc != null)
        : slot != null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentStep > 0)
            OutlinedButton(
              onPressed: () {
                setState(() {
                  _currentStep--;
                });
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
              ),
              child: const Text(
                'Back',
                style: TextStyle(color: AppColors.secondaryText),
              ),
            )
          else
            const SizedBox(),
          ElevatedButton(
            onPressed: nextEnabled
                ? () {
                    if (_currentStep == 1) {
                      _confirmBooking();
                    } else {
                      setState(() {
                        _currentStep++;
                      });
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _currentStep == 1
                  ? AppColors.success
                  : AppColors.primary,
              disabledBackgroundColor: AppColors.border,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            ),
            child: _isBooking
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    _currentStep == 1 ? 'Book Appointment' : 'Proceed',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
