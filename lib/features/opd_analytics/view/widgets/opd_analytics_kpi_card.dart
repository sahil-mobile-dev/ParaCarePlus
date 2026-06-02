import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class OpdAnalyticsKpiCard extends StatelessWidget {
  const OpdAnalyticsKpiCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.colorTheme,
    required this.progressPercent,
    this.deltaText,
    this.deltaType,
    super.key,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color colorTheme;
  final double progressPercent;
  final String? deltaText;
  final String? deltaType;

  @override
  Widget build(BuildContext context) {
    var deltaBg = Colors.transparent;
    var deltaTextColor = Colors.white;
    IconData? deltaIcon;

    if (deltaType == 'up') {
      deltaBg = AppColors.success.withValues(alpha: 0.15);
      deltaTextColor = AppColors.success;
      deltaIcon = Icons.arrow_upward;
    } else if (deltaType == 'down') {
      deltaBg = AppColors.error.withValues(alpha: 0.15);
      deltaTextColor = AppColors.error;
      deltaIcon = Icons.arrow_downward;
    } else if (deltaType == 'stable') {
      deltaBg = AppColors.secondaryAccent.withValues(alpha: 0.15);
      deltaTextColor = AppColors.secondaryAccent;
      deltaIcon = Icons.remove;
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Icon(
              icon,
              size: 48,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 14, color: colorTheme),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          title.toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            fontFamily: AppTextStyles.fontFamily,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: TextStyle(
                      color: colorTheme,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10.5,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (deltaText != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: deltaBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (deltaIcon != null)
                            Icon(deltaIcon, size: 10, color: deltaTextColor),
                          if (deltaIcon != null) const SizedBox(width: 3),
                          Text(
                            deltaText!,
                            style: TextStyle(
                              color: deltaTextColor,
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppTextStyles.fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: SizedBox(
                      height: 3,
                      child: LinearProgressIndicator(
                        value: progressPercent,
                        backgroundColor: Colors.white.withValues(alpha: 0.08),
                        valueColor: AlwaysStoppedAnimation<Color>(colorTheme),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
