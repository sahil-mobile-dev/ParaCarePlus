import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/model/sidebar_item.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: AppColors.surface,
      child: Column(
        children: [
          _buildBranding(),
          const Divider(color: AppColors.border, height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              children: SidebarItem.items
                  .map((item) => _buildNavItem(context, item))
                  .toList(),
            ),
          ),
          const Divider(color: AppColors.border, height: 1),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildBranding() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.local_hospital_rounded,
              color: AppColors.primary,
              size: 32,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ParaCare+',
                style: AppTextStyles.titleMedium.copyWith(letterSpacing: 1.2),
              ),
              Text(
                'Enterprise HIMS',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, SidebarItem item) {
    final String? currentRouteName = GoRouterState.of(context).name;
    final bool isSelected = currentRouteName == item.routeName;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 4,
      ),
      child: InkWell(
        onTap: () => context.pushNamed(item.routeName),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                item.icon,
                size: 20,
                color: isSelected ? Colors.white : AppColors.secondaryText,
              ),
              const SizedBox(width: 12),
              Text(
                item.title,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isSelected ? Colors.white : AppColors.primaryText,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          _buildFooterAction(Icons.help_outline_rounded, 'Help & Support'),
          const SizedBox(height: 8),
          _buildFooterAction(
            Icons.logout_rounded,
            'Logout',
            color: AppColors.error,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterAction(IconData icon, String label, {Color? color}) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color ?? AppColors.secondaryText),
            const SizedBox(width: 12),
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: color ?? AppColors.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
