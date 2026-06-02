import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class StateAdminKpiCard extends StatelessWidget {
  const StateAdminKpiCard({
    required this.title,
    required this.value,
    required this.trendText,
    required this.icon,
    required this.colorTheme, // 'sky', 'teal', 'green', 'orange', 'red', 'purple', 'gold', 'cyan', 'pink'
    this.trendUp = true,
    super.key,
  });

  final String title;
  final String value;
  final String trendText;
  final IconData icon;
  final String colorTheme;
  final bool trendUp;

  Color _getThemeColor() {
    switch (colorTheme) {
      case 'sky':
        return const Color(0xFF60A5FA);
      case 'teal':
        return const Color(0xFF4DB6AC);
      case 'green':
        return AppColors.success;
      case 'orange':
        return AppColors.secondaryAccent;
      case 'red':
        return AppColors.error;
      case 'purple':
        return const Color(0xFFCE93D8);
      case 'gold':
        return const Color(0xFFFFCA28);
      case 'cyan':
        return const Color(0xFF4DD0E1);
      case 'pink':
        return const Color(0xFFF48FB1);
      default:
        return AppColors.primaryLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = _getThemeColor();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Accent bottom strip
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 2,
            child: Container(color: themeColor),
          ),
          // Watermark icon
          Positioned(
            right: 14,
            top: 14,
            child: Opacity(
              opacity: 0.08,
              child: Icon(icon, size: 36, color: themeColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 9,
                        color: AppColors.secondaryText,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: themeColor,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      trendUp ? Icons.trending_up : Icons.trending_flat,
                      size: 11,
                      color: trendUp ? AppColors.success : AppColors.secondaryText,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        trendText,
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          color: trendUp ? AppColors.success : AppColors.secondaryText,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
}
