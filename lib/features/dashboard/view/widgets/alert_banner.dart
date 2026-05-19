import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/model/dashboard_models.dart';

class AlertBanner extends StatelessWidget {
  final AlertItem alert;
  final VoidCallback? onClose;

  const AlertBanner({super.key, required this.alert, this.onClose});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color iconColor;
    IconData icon;

    switch (alert.type) {
      case AlertType.critical:
        bgColor = AppColors.error.withValues(alpha: 0.1);
        iconColor = AppColors.error;
        icon = Icons.error_rounded;
        break;
      case AlertType.warning:
        bgColor = AppColors.secondaryAccent.withValues(alpha: 0.1);
        iconColor = AppColors.secondaryAccent;
        icon = Icons.warning_rounded;
        break;
      case AlertType.info:
        bgColor = AppColors.primary.withValues(alpha: 0.1);
        iconColor = AppColors.primary;
        icon = Icons.info_rounded;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: iconColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              alert.message,
              style: AppTextStyles.bodySmall.copyWith(
                color: iconColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (onClose != null)
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: onClose,
              icon: Icon(
                Icons.close_rounded,
                color: iconColor.withValues(alpha: 0.5),
                size: 18,
              ),
            ),
        ],
      ),
    );
  }
}
