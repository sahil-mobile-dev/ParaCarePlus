import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class StateCommandKpiCard extends StatefulWidget {
  const StateCommandKpiCard({
    required this.title,
    required this.value,
    required this.subText,
    required this.emoji,
    required this.colorTheme,
    this.isAi = false,
    this.trendUp, // true for green up, false for red down, null for neutral
    super.key,
  });

  final String title;
  final String value;
  final String subText;
  final String emoji;
  final String colorTheme;
  final bool isAi;
  final bool? trendUp;

  @override
  State<StateCommandKpiCard> createState() => _StateCommandKpiCardState();
}

class _StateCommandKpiCardState extends State<StateCommandKpiCard> {
  bool _isHovered = false;

  List<Color> _getThemeColors() {
    switch (widget.colorTheme) {
      case 'teal':
        return [const Color(0xFF00695C), const Color(0xFF00897B)];
      case 'red':
        return [const Color(0xFFC62828), const Color(0xFFD32F2F)];
      case 'gold':
        return [const Color(0xFFE65100), const Color(0xFFF9A825)];
      case 'green':
        return [const Color(0xFF2E7D32), const Color(0xFF388E3C)];
      case 'purple':
        return [const Color(0xFF4527A0), const Color(0xFF5E35B1)];
      case 'cyan':
        return [const Color(0xFF006064), const Color(0xFF0097A7)];
      case 'pink':
        return [const Color(0xFF880E4F), const Color(0xFFAD1457)];
      case 'blue':
      default:
        return [AppColors.primaryLight, AppColors.primary];
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
            width: 1,
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
                  gradient: LinearGradient(
                    colors: themeColors,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
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
                          fontSize: widget.value.length > 6 ? 18 : 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
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
                            fontSize: 10,
                            color: widget.trendUp == null
                                ? AppColors.secondaryText
                                : (widget.trendUp!
                                    ? AppColors.success.withValues(alpha: 0.9)
                                    : AppColors.error.withValues(alpha: 0.9)),
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
                ],
              ),
            ),
            // Background Corner Icon
            Positioned(
              right: -4,
              bottom: -4,
              child: Opacity(
                opacity: 0.1,
                child: Text(
                  widget.emoji,
                  style: const TextStyle(fontSize: 42),
                ),
              ),
            ),
            // AI indicator tag
            if (widget.isAi)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF673AB7).withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: const Color(0xFFCE93D8).withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Text(
                    'AI',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFCE93D8),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
