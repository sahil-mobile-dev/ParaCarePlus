import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

/// 5-tab selector for the Patient Portal login page.
/// Tabs: Mobile OTP | ABHA | Aadhaar | Face | Family
class LoginTabSelector extends ConsumerWidget {
  const LoginTabSelector({
    required this.activeTab,
    required this.onTabChanged,
    super.key,
  });
  final String activeTab;
  final ValueChanged<String> onTabChanged;

  static const _tabs = [
    (id: 'mobile', icon: Icons.phone_android_rounded, label: 'OTP'),
    (id: 'abha', icon: Icons.credit_card_rounded, label: 'ABHA'),
    (id: 'aadhaar', icon: Icons.fingerprint_rounded, label: 'Aadhaar'),
    (id: 'face', icon: Icons.face_rounded, label: 'Face'),
    (id: 'family', icon: Icons.groups_rounded, label: 'Family'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1E3A5F)),
      ),
      child: Row(
        children: _tabs.map((tab) {
          final isActive = activeTab == tab.id;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(tab.id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 9),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      tab.icon,
                      size: 15,
                      color: isActive ? Colors.white : const Color(0xFF7A9BBF),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      tab.label,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isActive
                            ? Colors.white
                            : const Color(0xFF7A9BBF),
                        fontWeight: isActive
                            ? FontWeight.w700
                            : FontWeight.w500,
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
