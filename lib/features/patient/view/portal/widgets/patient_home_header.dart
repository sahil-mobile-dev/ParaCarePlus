import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientHomeHeader extends StatelessWidget implements PreferredSizeWidget {
  const PatientHomeHeader({required this.onShowQR, super.key});
  final VoidCallback onShowQR;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                _buildActionButton(
                  icon: Icons.menu,
                  tooltip: 'Menu',
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  icon: Icons.search_rounded,
                  tooltip: 'Search & OPD Booking',
                  onTap: () => context.pushNamed(RouteNames.patientOPD),
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  icon: Icons.qr_code_rounded,
                  tooltip: 'Scan ABHA QR',
                  onTap: onShowQR,
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  icon: Icons.notifications_rounded,
                  tooltip: 'Notifications',
                  showDot: true,
                  onTap: () =>
                      context.pushNamed(RouteNames.patientNotifications),
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  icon: Icons.smart_toy_rounded,
                  color: const Color(0xFFC77DFF),
                  tooltip: 'AI Medical Assistant',
                  onTap: () => context.pushNamed(RouteNames.patientAI),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primaryLight,
                                Color(0xFF4361EE),
                              ],
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'R',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Rahul Sharma',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'ABHA',
                            style: TextStyle(
                              color: AppColors.success,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    String? tooltip,
    Color color = AppColors.secondaryText,
    bool showDot = false,
  }) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
        ),
        if (showDot)
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
