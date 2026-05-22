import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/patient_opd_booking_screen.dart';

class OpdStepSpecialty extends ConsumerStatefulWidget {
  const OpdStepSpecialty({required this.onNext, super.key});
  final VoidCallback onNext;

  @override
  ConsumerState<OpdStepSpecialty> createState() => _OpdStepSpecialtyState();
}

class _OpdStepSpecialtyState extends ConsumerState<OpdStepSpecialty> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _specialties = [
    {
      'name': 'Cardiology',
      'icon': Icons.favorite_rounded,
      'color': AppColors.error,
    },
    {
      'name': 'Endocrinology',
      'icon': Icons.water_drop_rounded,
      'color': AppColors.secondaryAccent,
    },
    {
      'name': 'General Medicine',
      'icon': Icons.health_and_safety_rounded,
      'color': AppColors.primaryLight,
    },
    {
      'name': 'Orthopaedics',
      'icon': Icons.accessibility_new_rounded,
      'color': Colors.orange,
    },
    {
      'name': 'Ophthalmology',
      'icon': Icons.remove_red_eye_rounded,
      'color': Colors.blue,
    },
    {
      'name': 'Dermatology',
      'icon': Icons.face_rounded,
      'color': Colors.pinkAccent,
    },
    {
      'name': 'Neurology',
      'icon': Icons.psychology_rounded,
      'color': Colors.purpleAccent,
    },
    {'name': 'Gynaecology', 'icon': Icons.female_rounded, 'color': Colors.pink},
    {
      'name': 'Paediatrics',
      'icon': Icons.child_care_rounded,
      'color': AppColors.success,
    },
    {
      'name': 'Dentistry',
      'icon': Icons.badge_rounded, // Stand-in for dental tooth icon
      'color': Colors.cyan,
    },
    {
      'name': 'Psychiatry',
      'icon': Icons.bubble_chart_rounded,
      'color': Colors.indigoAccent,
    },
    {
      'name': 'Nephrology',
      'icon': Icons.filter_alt_rounded,
      'color': Colors.teal,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedSpec = ref.watch(selectedSpecialtyProvider);

    final filteredSpecs = _specialties.where((s) {
      final name = s['name'] as String;
      return name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Wrap
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (val) {
              setState(() {
                _searchQuery = val;
              });
            },
            style: const TextStyle(color: AppColors.primaryText, fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Search specialty, doctor, hospital, condition...',
              hintStyle: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 14,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.secondaryText,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.mic, color: AppColors.secondaryText),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Voice search activated... (Listening)'),
                    ),
                  );
                },
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // AI Suggestion Banner
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.purple.withValues(alpha: 0.08),
            border: Border.all(color: Colors.purple.withValues(alpha: 0.25)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(Icons.bolt, color: Colors.purpleAccent, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primaryText,
                    ),
                    children: const [
                      TextSpan(text: 'AI suggests: '),
                      TextSpan(
                        text: 'Cardiology',
                        style: TextStyle(
                          color: AppColors.secondaryAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' (based on your BP trend) · '),
                      TextSpan(
                        text: 'Endocrinology',
                        style: TextStyle(
                          color: AppColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' (HbA1c elevated)'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Specialty Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.05,
          ),
          itemCount: filteredSpecs.length,
          itemBuilder: (context, index) {
            final spec = filteredSpecs[index];
            final name = spec['name'] as String;
            final icon = spec['icon'] as IconData;
            final color = spec['color'] as Color;
            final isSelected = selectedSpec == name;

            return InkWell(
              onTap: () {
                ref.read(selectedSpecialtyProvider.notifier).state = name;
                // Auto switch doctor matching specialty
                final match = doctorsList.firstWhere(
                  (d) => d.specialty == name,
                  orElse: () => doctorsList[0],
                );
                ref.read(selectedDoctorProvider.notifier).state = match;
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.12)
                      : Colors.white.withValues(alpha: 0.02),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.5)
                        : AppColors.border,
                    width: isSelected ? 1.5 : 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: color, size: 28),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.primaryLight
                              : AppColors.primaryText,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),

        // Next Button Align Right
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: widget.onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            icon: const Text(
              'Next: Choose Doctor',
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
        ),
      ],
    );
  }
}
