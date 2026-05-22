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
      height: 100,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning, Rahul!',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Wed, 25 Jun 2026 · Dehradun, Uttarakhand · Last login: Today 9:42 AM',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
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
