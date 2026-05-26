import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/doctor/model/doctor_sidebar_item.dart';
import 'package:paracareplus/features/doctor/view_model/doctor_dashboard_view_model.dart';
import 'package:paracareplus/routes/route_names.dart';

class DoctorSidebar extends ConsumerWidget {
  const DoctorSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(doctorDashboardViewModelProvider);
    final notifier = ref.read(doctorDashboardViewModelProvider.notifier);

    return Container(
      width: 280,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(right: BorderSide(color: AppColors.border, width: 1.5)),
      ),
      child: Column(
        children: [
          _buildBranding(),
          const Divider(color: AppColors.border, height: 1),
          _buildDoctorProfileCard(),
          const Divider(color: AppColors.border, height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              children: [
                _buildSectionHeader('CLINICAL WORKSPACE'),
                _buildNavItem(
                  context,
                  state,
                  notifier,
                  DoctorSidebarItem.items[0],
                ), // Console
                _buildNavItem(
                  context,
                  state,
                  notifier,
                  DoctorSidebarItem.items[1],
                ), // OPD Queue
                _buildNavItem(
                  context,
                  state,
                  notifier,
                  DoctorSidebarItem.items[2],
                ), // My IPD Patients
                const SizedBox(height: AppSpacing.md),
                _buildSectionHeader('📝 ORDERS & CLINICAL NOTES'),
                _buildNavItem(
                  context,
                  state,
                  notifier,
                  DoctorSidebarItem.items[3],
                ), // e-Prescriptions
                _buildNavItem(
                  context,
                  state,
                  notifier,
                  DoctorSidebarItem.items[4],
                ), // Clinical Notes / SOAP
              ],
            ),
          ),
          const Divider(color: AppColors.border, height: 1),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      child: Text(
        title.toUpperCase(),
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.secondaryText,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
          fontSize: 9.5,
        ),
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
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
              ),
            ),
            child: const Icon(
              Icons.medical_services_rounded,
              color: AppColors.primaryLight,
              size: 26,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ParaCare+',
                style: AppTextStyles.titleMedium.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Clinical Workspace',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorProfileCard() {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xFF1E3A5F),
            child: Text(
              'AV',
              style: TextStyle(
                color: AppColors.primaryLight,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dr. Alok Verma',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Cardiologist · DOC-9942',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.secondaryText,
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'On Duty',
                      style: TextStyle(
                        color: AppColors.success,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    DoctorDashboardState state,
    DoctorDashboardViewModel notifier,
    DoctorSidebarItem item,
  ) {
    final isSelected = state.activeTab == item.tab;

    // Get count badges for specific tabs
    int? badgeCount;
    if (item.tab == DoctorTab.opdQueue) {
      badgeCount = state.opdPatients.where((p) => p.status == 'Waiting').length;
    } else if (item.tab == DoctorTab.ePrescriptions) {
      badgeCount = state.pendingLabCount;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 2,
      ),
      child: InkWell(
        onTap: () {
          notifier.changeTab(item.tab);
          // If drawer is open on mobile, close it
          if (Scaffold.of(context).hasDrawer) {
            Navigator.of(context).pop();
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primaryLight : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Icon(
                item.icon,
                size: 18,
                color: isSelected ? Colors.white : AppColors.secondaryText,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isSelected ? Colors.white : AppColors.primaryText,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
              if (badgeCount != null && badgeCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.2)
                        : AppColors.error.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? Colors.white : AppColors.error,
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    '$badgeCount',
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.error,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          _buildFooterAction(
            Icons.help_outline_rounded,
            'Clinical Helpline',
            onTap: () {},
          ),
          const SizedBox(height: 8),
          _buildFooterAction(
            Icons.logout_rounded,
            'Secure Logout',
            color: AppColors.error,
            onTap: () {
              context.goNamed(RouteNames.login);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFooterAction(
    IconData icon,
    String label, {
    required VoidCallback onTap,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color ?? AppColors.secondaryText),
            const SizedBox(width: 12),
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: color ?? AppColors.secondaryText,
                fontSize: 12.5,
                fontWeight: color != null ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
