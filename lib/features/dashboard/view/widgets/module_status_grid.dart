import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/model/dashboard_models.dart';

class ModuleStatusGrid extends StatelessWidget {
  const ModuleStatusGrid({super.key, required this.modules});
  final List<ModuleStatus> modules;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.grid_view_rounded, color: AppColors.primary, size: 24),
            SizedBox(width: 12),
            Text('Module Status Overview', style: AppTextStyles.titleSmall),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.25,
          ),
          itemCount: modules.length,
          itemBuilder: (context, index) {
            final m = modules[index];
            return _buildModuleCard(m);
          },
        ),
      ],
    );
  }

  Widget _buildModuleCard(ModuleStatus m) {
    Color healthColor;
    switch (m.health) {
      case ModuleHealth.online:
        healthColor = AppColors.success;
      case ModuleHealth.offline:
        healthColor = AppColors.secondaryText;
      case ModuleHealth.critical:
        healthColor = AppColors.error;
      case ModuleHealth.partial:
        healthColor = AppColors.secondaryAccent;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: healthColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: healthColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(m.icon, color: AppColors.primaryText, size: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: healthColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  m.status,
                  style: TextStyle(
                    color: healthColor,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            m.name,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (m.subtext != null)
            Text(
              m.subtext!,
              style: AppTextStyles.labelSmall.copyWith(fontSize: 8),
            ),
        ],
      ),
    );
  }
}
