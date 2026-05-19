import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/auth/model/user_role.dart';
import 'package:paracareplus/features/auth/view_model/login_view_model.dart';

class DemoCredentialsBar extends ConsumerWidget {
  const DemoCredentialsBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final demoRoles = [
      UserRole.masterAdmin,
      UserRole.doctor,
      UserRole.nurse,
      UserRole.billingStaff,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quick Demo Fill', style: AppTextStyles.labelSmall),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: demoRoles.map((role) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ActionChip(
                  label: Text(role.displayName),
                  labelStyle: AppTextStyles.labelSmall.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                  avatar: Icon(role.icon, size: 14, color: AppColors.primary),
                  backgroundColor: AppColors.background.withValues(alpha: 0.5),
                  side: const BorderSide(color: AppColors.border, width: 0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onPressed: () => ref
                      .read(loginViewModelProvider.notifier)
                      .fillDemoCredentials(role),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
