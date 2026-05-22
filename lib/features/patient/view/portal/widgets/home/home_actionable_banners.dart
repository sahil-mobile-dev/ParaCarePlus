import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/routes/route_names.dart';

class HomeActionableBanners extends ConsumerWidget {
  const HomeActionableBanners({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _buildBannerCard(
          context,
          icon: Icons.warning_amber_rounded,
          color: AppColors.secondaryAccent,
          title: 'HbA1c Elevated — Action Required',
          desc:
              'Your latest HbA1c is 7.4% (target: <7.0%). Your diabetologist Dr. Priya Negi recommends a diet review and medication adjustment.',
          actions: [
            _buildBannerBtn(
              'View Report',
              true,
              () => context.pushNamed(RouteNames.patientLab),
            ),
            _buildBannerBtn(
              'Book Appointment',
              false,
              () => context.pushNamed(RouteNames.patientOPD),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildBannerCard(
          context,
          icon: Icons.vaccines_rounded,
          color: AppColors.primaryLight,
          title: 'Influenza Booster Vaccine Due',
          desc:
              'Your annual flu booster is due. Schedule at your nearest health centre or book a home visit.',
          actions: [
            _buildBannerBtn(
              'Schedule',
              true,
              () => context.pushNamed(RouteNames.patientVaccination),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBannerCard(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required String desc,
    required List<Widget> actions,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(spacing: 8, runSpacing: 8, children: actions),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerBtn(String label, bool isPrimary, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary
            ? AppColors.primaryLight
            : Colors.white.withValues(alpha: 0.08),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onTap,
      child: Text(
        label,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
