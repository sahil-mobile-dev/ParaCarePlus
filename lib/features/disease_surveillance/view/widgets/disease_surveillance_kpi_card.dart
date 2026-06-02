import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class DiseaseSurveillanceKpiCard extends StatelessWidget {
  const DiseaseSurveillanceKpiCard({
    required this.title,
    required this.value,
    required this.subText,
    required this.emoji,
    required this.colorTheme,
    this.deltaText,
    this.deltaUp = true,
    this.progressVal = 0.5,
    super.key,
  });

  final String title;
  final String value;
  final String subText;
  final String emoji;
  final String colorTheme;
  final String? deltaText;
  final bool deltaUp;
  final double progressVal;

  Color _getThemeColor() {
    switch (colorTheme) {
      case 'red':
        return AppColors.error;
      case 'orange':
        return AppColors.secondaryAccent;
      case 'yellow':
        return const Color(0xFFFFD166);
      case 'green':
      case 'teal':
        return AppColors.success;
      case 'purple':
        return const Color(0xFF9B5DE5);
      case 'blue':
        return AppColors.primaryLight;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = _getThemeColor();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Top accent border
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 3,
            child: Container(color: themeColor),
          ),
          // Background Icon watermark
          Positioned(
            right: 12,
            top: 14,
            child: Opacity(
              opacity: 0.08,
              child: Text(emoji, style: const TextStyle(fontSize: 32)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          emoji,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            title.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: AppColors.secondaryText,
                              letterSpacing: 0.5,
                              fontFamily: AppTextStyles.fontFamily,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: themeColor,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subText,
                      style: const TextStyle(
                        fontSize: 10.5,
                        color: Colors.white70,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (deltaText != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: (deltaUp ? AppColors.error : AppColors.success)
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              deltaUp ? Icons.arrow_upward : Icons.arrow_downward,
                              size: 8,
                              color: deltaUp ? AppColors.error : AppColors.success,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              deltaText!,
                              style: TextStyle(
                                fontSize: 8.5,
                                fontWeight: FontWeight.bold,
                                color: deltaUp ? AppColors.error : AppColors.success,
                                fontFamily: AppTextStyles.fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 6),
                    // Progress tracker bar
                    Container(
                      height: 3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: progressVal.clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
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
