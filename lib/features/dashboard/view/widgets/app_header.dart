import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildGovernmentBranding(),
              const Spacer(),
              _buildUserProfile(),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildSearchField(),
              _buildIconBtn(Icons.notifications_none_rounded, 'Notifications'),
              _buildIconBtn(Icons.settings_outlined, 'Settings'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGovernmentBranding() {
    return Row(
      children: [
        const Icon(
          Icons.account_balance_rounded,
          color: AppColors.secondaryText,
          size: 28,
        ),
        const SizedBox(width: 12),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GOVERNMENT OF UTTARAKHAND',
              style: AppTextStyles.labelSmall.copyWith(
                letterSpacing: 1.0,
                fontSize: 10,
              ),
            ),
            Text(
              'Synergy MultiSpeciality Hospital',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primary,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return const Expanded(
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search patients, token, bills...',
          hintStyle: TextStyle(color: AppColors.secondaryText, fontSize: 13),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: AppColors.secondaryText,
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }

  Widget _buildIconBtn(IconData icon, String tooltip, {bool hasBadge = false}) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(icon, color: AppColors.primaryText, size: 24),
          tooltip: tooltip,
        ),
        if (hasBadge)
          Positioned(
            right: 12,
            top: 12,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildUserProfile() {
    return const CircleAvatar(
      radius: 18,
      backgroundColor: AppColors.primary,
      child: Text(
        'BS',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
