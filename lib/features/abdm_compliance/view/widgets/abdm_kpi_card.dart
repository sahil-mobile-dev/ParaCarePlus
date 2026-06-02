import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AbdmKpiCard extends StatefulWidget {
  const AbdmKpiCard({
    required this.title,
    required this.value,
    required this.subText,
    required this.emoji,
    required this.colorTheme,
    this.progressPercent,
    this.trendUp, // true for green up, false for red down, null for neutral
    super.key,
  });

  final String title;
  final String value;
  final String subText;
  final String emoji;
  final String colorTheme;
  final double? progressPercent; // Value between 0.0 and 1.0 (e.g. 0.77)
  final bool? trendUp;

  @override
  State<AbdmKpiCard> createState() => _AbdmKpiCardState();
}

class _AbdmKpiCardState extends State<AbdmKpiCard> {
  bool _isHovered = false;

  List<Color> _getThemeColors() {
    switch (widget.colorTheme) {
      case 'teal':
        return [const Color(0xFF0D9488), const Color(0xFF06D6A0)];
      case 'green':
        return [const Color(0xFF00C897), const Color(0xFF06D6A0)];
      case 'red':
        return [const Color(0xFFFF4D6D), const Color(0xFFFF758C)];
      case 'yellow':
        return [const Color(0xFFFFD166), const Color(0xFFF77F00)];
      case 'purple':
        return [const Color(0xFF9B5DE5), const Color(0xFFF72585)];
      case 'blue':
        return [const Color(0xFF4361EE), const Color(0xFF4CC9F0)];
      case 'abdm':
        return [const Color(0xFF1A6B9A), const Color(0xFF0D9488)];
      case 'accent':
      default:
        return [const Color(0xFF00B4D8), const Color(0xFF48CAE4)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = _getThemeColors();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? Matrix4.translationValues(0, -2, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(
            color: _isHovered
                ? themeColors[0].withValues(alpha: 0.6)
                : AppColors.border.withValues(alpha: 0.4),
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Top Accent Line
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 3,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: themeColors),
                ),
              ),
            ),
            // Card Content
            Padding(
              padding: const EdgeInsets.only(
                left: 14,
                right: 14,
                top: 14,
                bottom: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: AppColors.secondaryText,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.value,
                        style: AppTextStyles.titleLarge.copyWith(
                          fontSize: widget.value.length > 7 ? 17 : 20,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (widget.trendUp != null) ...[
                            Icon(
                              widget.trendUp!
                                  ? Icons.arrow_upward_rounded
                                  : Icons.arrow_downward_rounded,
                              size: 11,
                              color: widget.trendUp!
                                  ? AppColors.success
                                  : AppColors.error,
                            ),
                            const SizedBox(width: 2),
                          ],
                          Expanded(
                            child: Text(
                              widget.subText,
                              style: TextStyle(
                                fontSize: 9.5,
                                color: widget.trendUp == null
                                    ? AppColors.secondaryText
                                    : (widget.trendUp!
                                          ? AppColors.success.withValues(
                                              alpha: 0.9,
                                            )
                                          : AppColors.error.withValues(
                                              alpha: 0.9,
                                            )),
                                fontWeight: widget.trendUp == null
                                    ? FontWeight.w500
                                    : FontWeight.bold,
                                fontFamily: AppTextStyles.fontFamily,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      if (widget.progressPercent != null) ...[
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: SizedBox(
                            height: 3,
                            width: double.infinity,
                            child: LinearProgressIndicator(
                              value: widget.progressPercent,
                              backgroundColor: Colors.white.withValues(
                                alpha: 0.07,
                              ),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                themeColors[0],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            // Background Corner Icon
            Positioned(
              right: -4,
              bottom: -4,
              child: Opacity(
                opacity: 0.08,
                child: Text(widget.emoji, style: const TextStyle(fontSize: 42)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
