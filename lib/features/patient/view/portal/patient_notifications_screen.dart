import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientNotificationsScreen extends ConsumerWidget {
  const PatientNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientNotifications,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('Notifications'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: AppColors.primaryText),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          const Text('UNREAD HEALTH ALERTS', style: AppTextStyles.labelSmall),
          const SizedBox(height: AppSpacing.sm),
          _buildNotificationItem(
            title: '💊 Metformin due in 2 hours',
            desc:
                'Your afternoon dose (500mg after lunch) is scheduled at 2:00 PM.',
            time: 'Just Now',
            isUnread: true,
          ),
          _buildNotificationItem(
            title: '🩸 HbA1c Lab Report Ready',
            desc:
                'Pathology findings show an elevated index of 7.4%. Tap to review detail recommendations.',
            time: '1 hour ago',
            isUnread: true,
          ),
          const SizedBox(height: AppSpacing.md),
          const Text('OLDER ALERTS', style: AppTextStyles.labelSmall),
          const SizedBox(height: AppSpacing.sm),
          _buildNotificationItem(
            title: '📅 Appointment Confirmed',
            desc:
                'Your consultation with Dr. Anjali Sharma (Cardiology) is confirmed for 20 May at 10:30 AM.',
            time: '3 hours ago',
            isUnread: false,
          ),
          _buildNotificationItem(
            title: '✅ Ayushman Claim Approved',
            desc:
                'AB-PMJAY insurance coverage of ₹12,400 for knee surgery package has been approved.',
            time: 'Yesterday',
            isUnread: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String desc,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUnread
            ? AppColors.primary.withValues(alpha: 0.1)
            : AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: isUnread
              ? AppColors.primaryLight.withValues(alpha: 0.3)
              : AppColors.border,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isUnread)
            Container(
              margin: const EdgeInsets.only(top: 4, right: 8),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  time,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 9,
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
