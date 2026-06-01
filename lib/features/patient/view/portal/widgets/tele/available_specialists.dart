import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class AvailableSpecialists extends StatelessWidget {
  const AvailableSpecialists({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 900
            ? 3
            : (constraints.maxWidth > 600 ? 2 : 1);

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: constraints.maxWidth > 900 ? 1.6 : 1.7,
          children: [
            _buildDoctorCard(
              context,
              name: 'Dr. Rajesh Kumar',
              spec: 'Cardiologist · AIIMS Rishikesh · 18 yrs exp',
              rating: '★★★★★ 4.9 (312 reviews)',
              statusLabel: 'Online Now',
              isBusy: false,
              btnText: 'Start Consultation',
              btnIcon: Icons.videocam_rounded,
              toastMsg: 'Connecting to Dr. Rajesh Kumar…',
              gradientColors: [
                const Color(0xFF0D9488),
                const Color(0xFF00B4D8),
              ],
            ),
            _buildDoctorCard(
              context,
              name: 'Dr. Meena Verma',
              spec: 'Endocrinologist · Himalayan Hospital · 14 yrs exp',
              rating: '★★★★☆ 4.7 (208 reviews)',
              statusLabel: 'Online Now',
              isBusy: false,
              btnText: 'Start Consultation',
              btnIcon: Icons.videocam_rounded,
              toastMsg: 'Connecting to Dr. Meena Verma…',
              gradientColors: [
                const Color(0xFFC77DFF),
                const Color(0xFF4361EE),
              ],
            ),
            _buildDoctorCard(
              context,
              name: 'Dr. Anand Patel',
              spec: 'General Physician · Doon Hospital · 10 yrs exp',
              rating: '★★★★☆ 4.5 (415 reviews)',
              statusLabel: 'In Session · Free in 12 min',
              isBusy: true,
              btnText: 'Join Queue',
              btnIcon: Icons.access_time_rounded,
              toastMsg: "Added to Dr. Patel's queue…",
              gradientColors: [
                const Color(0xFFF77F00),
                const Color(0xFFFFD166),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildDoctorCard(
    BuildContext context, {
    required String name,
    required String spec,
    required String rating,
    required String statusLabel,
    required bool isBusy,
    required String btnText,
    required IconData btnIcon,
    required String toastMsg,
    required List<Color> gradientColors,
  }) {
    final statusColor = isBusy ? const Color(0xFFFFD166) : AppColors.success;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.medical_services_rounded,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Doctor details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      spec,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 10.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      rating,
                      style: const TextStyle(
                        color: Color(0xFFFFD166),
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Status pill
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          statusLabel,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 9.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Button Action
                SizedBox(
                  width: double.infinity,
                  height: 28,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(toastMsg),
                          backgroundColor: AppColors.primaryLight,
                        ),
                      );
                    },
                    icon: Icon(btnIcon, size: 12),
                    label: Text(
                      btnText,
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF00B4D8),
                      side: const BorderSide(color: Color(0xFF2A4158)),
                      backgroundColor: const Color(
                        0xFF00B4D8,
                      ).withValues(alpha: 0.1),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
