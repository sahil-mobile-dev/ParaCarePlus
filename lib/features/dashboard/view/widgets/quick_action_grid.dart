import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/routes/route_names.dart';

class QuickActionGrid extends StatelessWidget {
  const QuickActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickActionItem(
        icon: Icons.person_add_outlined,
        label: 'New Patient',
        onTap: () => context.pushNamed(RouteNames.patientRegistration),
      ),
      _QuickActionItem(
        icon: Icons.token_outlined,
        label: 'OPD Token',
        onTap: () => context.pushNamed(RouteNames.opdToken),
      ),
      _QuickActionItem(
        icon: Icons.hotel_outlined,
        label: 'IPD Admit',
        onTap: () => context.pushNamed(RouteNames.ipdAdmission),
      ),
      _QuickActionItem(
        icon: Icons.local_pharmacy_outlined,
        label: 'Pharmacy',
        onTap: () => context.pushNamed(RouteNames.pharmacy),
      ),
      _QuickActionItem(
        icon: Icons.science_outlined,
        label: 'Laboratory',
        onTap: () => context.pushNamed(RouteNames.laboratory),
      ),
      _QuickActionItem(
        icon: Icons.biotech_outlined,
        label: 'Radiology',
        onTap: () => context.pushNamed(RouteNames.radiology),
      ),
      _QuickActionItem(
        icon: Icons.receipt_long_outlined,
        label: 'Billing',
        onTap: () => context.pushNamed(RouteNames.billing),
      ),
      _QuickActionItem(
        icon: Icons.emergency_outlined,
        label: 'Ambulance',
        onTap: () => _handleAction(context, 'Ambulance'),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) => actions[index],
    );
  }

  void _handleAction(BuildContext context, String action) {
    if (action == 'New Patient') {
      // In a real app, use GoRouter named route
      // context.pushNamed(RouteNames.patientRegistration);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Navigating to $action')));
    }
  }
}

class _QuickActionItem extends StatelessWidget {
  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.primaryText,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
