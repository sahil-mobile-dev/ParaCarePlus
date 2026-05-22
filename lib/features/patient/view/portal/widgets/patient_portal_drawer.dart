import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientPortalDrawer extends StatelessWidget {
  const PatientPortalDrawer({required this.activeRouteName, super.key});
  final String activeRouteName;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const Divider(color: AppColors.border, height: 1),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                children: [
                  _buildNavItem(
                    context,
                    title: 'My Dashboard',
                    icon: Icons.home_rounded,
                    routeName: RouteNames.patientHome,
                  ),
                  _buildNavItem(
                    context,
                    title: 'Health Records',
                    icon: Icons.description_rounded,
                    routeName: RouteNames.patientEMR,
                  ),
                  _buildNavItem(
                    context,
                    title: 'Appointments',
                    icon: Icons.calendar_today_rounded,
                    routeName: RouteNames.patientOPD,
                  ),
                  _buildNavItem(
                    context,
                    title: 'Health Analytics',
                    icon: Icons.trending_up_rounded,
                    routeName: RouteNames.patientHealthAnalytics,
                  ),
                  _buildNavItem(
                    context,
                    title: 'Lab Reports',
                    icon: Icons.science_rounded,
                    routeName: RouteNames.patientLab,
                  ),
                  _buildNavItem(
                    context,
                    title: 'Radiology',
                    icon: Icons.document_scanner_rounded,
                    routeName: RouteNames.patientRadiology,
                  ),
                  _buildNavItem(
                    context,
                    title: 'Prescriptions',
                    icon: Icons.medication_rounded,
                    routeName: RouteNames.patientPrescription,
                  ),
                  _buildNavItem(
                    context,
                    title: 'Vaccination',
                    icon: Icons.vaccines_rounded,
                    routeName: RouteNames.patientVaccination,
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Divider(color: AppColors.border, height: 1),
                  ),

                  _buildNavItem(
                    context,
                    title: 'Chronic Diseases',
                    icon: Icons.monitor_heart_rounded,
                    routeName: RouteNames.patientChronic,
                  ),
                  _buildNavItem(
                    context,
                    title: 'Women & Child (MCH)',
                    icon: Icons.child_care_rounded,
                    routeName: RouteNames.patientMch,
                  ),
                  _buildNavItem(
                    context,
                    title: 'Telemedicine',
                    icon: Icons.video_call_rounded,
                    routeName: RouteNames.patientTele,
                  ),
                  _buildNavItem(
                    context,
                    title: 'Emergency SOS',
                    icon: Icons.emergency_rounded,
                    routeName: RouteNames.patientEmergency,
                    iconColor: AppColors.error,
                  ),
                  _buildNavItem(
                    context,
                    title: 'Finance & Insurance',
                    icon: Icons.account_balance_wallet_rounded,
                    routeName: RouteNames.patientFinance,
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Divider(color: AppColors.border, height: 1),
                  ),

                  _buildNavItem(
                    context,
                    title: 'Wellness Hub',
                    icon: Icons.fitness_center_rounded,
                    routeName: RouteNames.patientWellness,
                  ),
                  _buildNavItem(
                    context,
                    title: 'Family Health',
                    icon: Icons.people_rounded,
                    routeName: RouteNames.patientFamily,
                  ),
                  _buildNavItem(
                    context,
                    title: 'AI Assistant',
                    icon: Icons.smart_toy_rounded,
                    routeName: RouteNames.patientAI,
                  ),
                  _buildNavItem(
                    context,
                    title: 'Notifications',
                    icon: Icons.notifications_rounded,
                    routeName: RouteNames.patientNotifications,
                  ),
                  _buildNavItem(
                    context,
                    title: 'Smart Maps',
                    icon: Icons.map_rounded,
                    routeName: RouteNames.patientMaps,
                  ),
                  _buildNavItem(
                    context,
                    title: 'Feedback & Reviews',
                    icon: Icons.star_rate_rounded,
                    routeName: RouteNames.patientFeedback,
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.border, height: 1),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryLight, AppColors.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'R',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Rahul Sharma',
                            style: AppTextStyles.labelLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(AppRadius.xs),
                            border: Border.all(
                              color: AppColors.success.withValues(alpha: 0.3),
                            ),
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
                    const SizedBox(height: 2),
                    const Text(
                      'Male · 38 years · B+',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(color: AppColors.border),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ABHA ID: 12-3456-7890-0001',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'UHID: UHD-2021-08421',
                  style: TextStyle(color: AppColors.secondaryText, fontSize: 9),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String routeName,
    Color? iconColor,
  }) {
    final isActive = activeRouteName == routeName;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primaryLight.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: ListTile(
          onTap: () {
            Navigator.of(context).pop(); // Close drawer
            if (!isActive) {
              context.goNamed(routeName);
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          leading: Icon(
            icon,
            color: isActive
                ? AppColors.primaryLight
                : (iconColor ?? AppColors.secondaryText),
            size: 20,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.white : AppColors.primaryText,
              fontSize: 13,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          dense: true,
          visualDensity: const VisualDensity(vertical: -2),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return ColoredBox(
      color: AppColors.surface,
      child: ListTile(
        onTap: () {
          Navigator.of(context).pop();
          context.goNamed(RouteNames.patientLogin);
        },
        leading: const Icon(
          Icons.logout_rounded,
          color: AppColors.error,
          size: 20,
        ),
        title: const Text(
          'Logout',
          style: TextStyle(
            color: AppColors.error,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        dense: true,
      ),
    );
  }
}
