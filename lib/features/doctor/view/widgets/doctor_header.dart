import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class DoctorHeader extends StatelessWidget implements PreferredSizeWidget {
  const DoctorHeader({
    required this.alertCount,
    super.key,
    this.onMenuPressed,
    this.showMenuButton = false,
  });

  final int alertCount;
  final VoidCallback? onMenuPressed;
  final bool showMenuButton;

  @override
  Size get preferredSize => const Size.fromHeight(170);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1.5)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                if (showMenuButton) ...[
                  IconButton(
                    onPressed: onMenuPressed ?? () => Scaffold.of(context).openDrawer(),
                    icon: const Icon(
                      Icons.menu_rounded,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                _buildClinicalWorkspaceBranding(),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildSearchField(),
                _buildIconBtn(
                  Icons.notifications_active_outlined,
                  'Urgent Clinical Alerts',
                  hasBadge: alertCount > 0,
                  badgeCount: alertCount,
                ),
                _buildIconBtn(
                  Icons.chat_bubble_outline_rounded,
                  'Consults & Referrals',
                ),
                _buildIconBtn(Icons.tune_rounded, 'Console Settings'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClinicalWorkspaceBranding() {
    return Row(
      children: [
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'GOVERNMENT OF UTTARAKHAND · DEPT OF HEALTH',
              style: AppTextStyles.labelSmall.copyWith(
                letterSpacing: 0.8,
                fontSize: 8.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Synergy MultiSpeciality Hospital · Clinical Desk',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.primaryText,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Expanded(
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.background.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: const TextField(
          style: TextStyle(color: AppColors.primaryText, fontSize: 13),
          decoration: InputDecoration(
            hintText: 'Search patients by name, token, bed, or diagnosis...',
            hintStyle: TextStyle(color: AppColors.secondaryText, fontSize: 12),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: AppColors.secondaryText,
              size: 18,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 8),
          ),
        ),
      ),
    );
  }

  Widget _buildIconBtn(
    IconData icon,
    String tooltip, {
    bool hasBadge = false,
    int badgeCount = 0,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(icon, color: AppColors.primaryText, size: 18),
              tooltip: tooltip,
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        if (hasBadge)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                '$badgeCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
