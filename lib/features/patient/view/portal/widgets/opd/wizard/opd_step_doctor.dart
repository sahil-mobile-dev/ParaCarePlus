import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/patient_opd_booking_screen.dart';

class OpdStepDoctor extends ConsumerWidget {
  final VoidCallback onBack;
  final VoidCallback onNext;

  const OpdStepDoctor({super.key, required this.onBack, required this.onNext});

  // Comprehensive doctor mock list matching specialties
  static final List<Map<String, dynamic>> allDoctors = [
    {
      'name': 'Dr. Anjali Sharma',
      'specialty': 'Cardiology',
      'degree': 'DM Cardiology',
      'exp': '14 yrs exp',
      'rating': 4.8,
      'reviews': 312,
      'hospital': 'AIIMS Rishikesh',
      'room': 'OPD 4',
      'fee': '₹500',
      'wait': '18 mins (AI)',
      'isAvailable': true,
      'hasTele': true,
      'isBusy': false,
      'avatar': 'A',
      'avatarGradient': [Color(0xFFF72585), Color(0xFFC77DFF)],
    },
    {
      'name': 'Dr. Vipin Rawat',
      'specialty': 'Cardiology',
      'degree': 'MD (Medicine) + Cardiology',
      'exp': '8 yrs exp',
      'rating': 4.2,
      'reviews': 178,
      'hospital': 'Doon Hospital',
      'room': 'OPD 2',
      'fee': '₹300',
      'wait': '32 mins (AI)',
      'isAvailable': true,
      'hasTele': false,
      'isBusy': false,
      'avatar': 'V',
      'avatarGradient': [Color(0xFF3A86FF), Color(0xFF4361EE)],
    },
    {
      'name': 'Dr. Meera Bisht',
      'specialty': 'Cardiology',
      'degree': 'MBBS, DNB Cardiology',
      'exp': '10 yrs exp',
      'rating': 4.9,
      'reviews': 420,
      'hospital': 'Max Hospital',
      'room': 'OPD 7',
      'fee': '₹600',
      'wait': '45 mins (AI)',
      'isAvailable': false,
      'hasTele': true,
      'isBusy': true,
      'avatar': 'M',
      'avatarGradient': [Color(0xFF00C897), Color(0xFF0D9488)],
    },
    {
      'name': 'Dr. Suresh Joshi',
      'specialty': 'Cardiology',
      'degree': 'DM Cardiology',
      'exp': '20 yrs exp',
      'rating': 4.7,
      'reviews': 560,
      'hospital': 'AIIMS Rishikesh',
      'room': 'OPD 3',
      'fee': '₹700',
      'wait': '22 mins (AI)',
      'isAvailable': true,
      'hasTele': false,
      'isBusy': false,
      'avatar': 'S',
      'avatarGradient': [Color(0xFFFFD166), Color(0xFFF77F00)],
    },
    // Fallback/other specialists for different departments
    {
      'name': 'Dr. Rajesh Kumar',
      'specialty': 'Endocrinology',
      'degree': 'MD, DM Endocrinology',
      'exp': '16 yrs exp',
      'rating': 4.8,
      'reviews': 240,
      'hospital': 'AIIMS Rishikesh',
      'room': 'OPD 1',
      'fee': '₹500',
      'wait': '15 mins (AI)',
      'isAvailable': true,
      'hasTele': true,
      'isBusy': false,
      'avatar': 'R',
      'avatarGradient': [Colors.teal, Colors.tealAccent],
    },
    {
      'name': 'Dr. Satish Semwal',
      'specialty': 'General Medicine',
      'degree': 'MBBS, MD',
      'exp': '12 yrs exp',
      'rating': 4.6,
      'reviews': 180,
      'hospital': 'Govt Hospital',
      'room': 'OPD 5',
      'fee': '₹200',
      'wait': '12 mins (AI)',
      'isAvailable': true,
      'hasTele': true,
      'isBusy': false,
      'avatar': 'S',
      'avatarGradient': [Colors.blue, Colors.lightBlueAccent],
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSpec = ref.watch(selectedSpecialtyProvider);
    final selectedDoctor = ref.watch(selectedDoctorProvider);

    // Filter doctors by selected specialty, otherwise show all/fallback
    List<Map<String, dynamic>> filteredDoctors = allDoctors
        .where(
          (d) =>
              d['specialty'].toString().toLowerCase() ==
              selectedSpec.toLowerCase(),
        )
        .toList();

    if (filteredDoctors.isEmpty) {
      filteredDoctors = allDoctors.take(4).toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                style: AppTextStyles.labelMedium,
                children: [
                  const TextSpan(text: 'Showing '),
                  TextSpan(
                    text: selectedSpec,
                    style: const TextStyle(
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: ' doctors near '),
                  const TextSpan(
                    text: 'Dehradun',
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredDoctors.length,
          itemBuilder: (context, index) {
            final doc = filteredDoctors[index];
            final name = doc['name'] as String;
            final isSelected = selectedDoctor?.name == name;
            final avatar = doc['avatar'] as String;
            final colors = doc['avatarGradient'] as List<Color>;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.08)
                    : Colors.white.withValues(alpha: 0.02),
                border: Border.all(
                  color: isSelected ? AppColors.success : AppColors.border,
                  width: isSelected ? 1.5 : 1.0,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                onTap: () {
                  final mappedDoc = doctorsList.firstWhere(
                    (d) => d.name == name,
                    orElse: () => Doctor(
                      name,
                      doc['specialty'] as String,
                      doc['degree'] as String,
                      doc['isAvailable'] as bool
                          ? '9:00 AM - 1:00 PM'
                          : 'Unavailable Today',
                      'Wait: ${doc['wait']}',
                    ),
                  );
                  ref.read(selectedDoctorProvider.notifier).state = mappedDoc;
                },
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: colors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    avatar,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: AppTextStyles.labelLarge.copyWith(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.secondaryAccent,
                          size: 14,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${doc['rating']}',
                          style: const TextStyle(
                            color: AppColors.secondaryAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' (${doc['reviews']})',
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      '${doc['degree']} • ${doc['exp']}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Doctor tags
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: doc['isBusy'] as bool
                                ? AppColors.error.withValues(alpha: 0.12)
                                : AppColors.success.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            doc['isBusy'] as bool
                                ? '● Busy Today'
                                : '● Available Today',
                            style: TextStyle(
                              color: doc['isBusy'] as bool
                                  ? AppColors.error
                                  : AppColors.success,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (doc['hasTele'] as bool) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Teleconsult',
                              style: TextStyle(
                                color: AppColors.primaryLight,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Wait and location info
                    Row(
                      children: [
                        const Icon(
                          Icons.apartment_rounded,
                          color: AppColors.secondaryText,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${doc['hospital']} • ${doc['room']} • ${doc['fee']}',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          color: AppColors.secondaryText,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Avg wait: ${doc['wait']}',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.secondaryAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),

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
              onPressed: selectedDoctor != null ? onNext : null,
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
                'Next: Date & Slot',
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
