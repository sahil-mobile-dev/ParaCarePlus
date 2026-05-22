import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/auth/model/user_role.dart';
import 'package:paracareplus/features/auth/view_model/login_view_model.dart';

/// Displays 7 selectable roles matching the HTML login page role grid.
/// State Super Admin gets a special saffron/orange highlight.
class RoleSelectionGrid extends ConsumerWidget {
  const RoleSelectionGrid({super.key});

  static const _displayRoles = [
    UserRole.stateSuperAdmin,
    UserRole.administrator,
    UserRole.doctor,
    UserRole.nurse,
    UserRole.billingStaff,
    UserRole.pharmacist,
    UserRole.labTechnician,
  ];

  static const _roleEmojis = {
    UserRole.stateSuperAdmin: '🏛️',
    UserRole.administrator: '👨‍💼',
    UserRole.doctor: '🩺',
    UserRole.nurse: '👩‍⚕️',
    UserRole.billingStaff: '💳',
    UserRole.pharmacist: '💊',
    UserRole.labTechnician: '🧪',
  };

  static const _roleDesc = {
    UserRole.stateSuperAdmin: 'State-level command centre',
    UserRole.administrator: 'Full system access',
    UserRole.doctor: 'Clinical workspace',
    UserRole.nurse: 'Ward station',
    UserRole.billingStaff: 'Finance & billing',
    UserRole.pharmacist: 'Pharmacy ops',
    UserRole.labTechnician: 'LIS / Lab',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRole = ref.watch(loginViewModelProvider).value?.selectedRole;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 2.6,
      ),
      itemCount: _displayRoles.length,
      itemBuilder: (context, index) {
        final role = _displayRoles[index];
        final isSelected = selectedRole == role;
        final isStateAdmin = role == UserRole.stateSuperAdmin;

        final accentColor = const Color(0xFFE65100);
        final accentBg = AppColors.primary.withValues(alpha: 0.06);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: isSelected ? accentBg : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? accentColor
                  : AppColors.border.withValues(alpha: 0.6),
              width: isSelected ? 1.5 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: accentColor.withValues(alpha: 0.12),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () =>
                  ref.read(loginViewModelProvider.notifier).selectRole(role),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                child: Row(
                  children: [
                    Text(
                      _roleEmojis[role] ?? '👤',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            role.displayName,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: isSelected
                                  ? const Color(0xFFE65100)
                                  : Colors.black,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              fontSize: 11.5,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            _roleDesc[role] ?? role.description,
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 9,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
