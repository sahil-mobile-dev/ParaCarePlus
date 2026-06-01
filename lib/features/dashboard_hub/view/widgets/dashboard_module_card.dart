import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard_hub/model/dashboard_hub_model.dart';
import 'package:paracareplus/routes/route_names.dart';

class DashboardModuleCard extends StatefulWidget {
  const DashboardModuleCard({required this.module, super.key});
  final DashboardModuleItem module;

  @override
  State<DashboardModuleCard> createState() => _DashboardModuleCardState();
}

class _DashboardModuleCardState extends State<DashboardModuleCard> {
  bool _isHovered = false;

  List<Color> _getThemeColors() {
    switch (widget.module.colorTheme) {
      case 'teal':
        return [const Color(0xFF00695C), const Color(0xFF00897B)];
      case 'red':
        return [const Color(0xFFC62828), const Color(0xFFD32F2F)];
      case 'orange':
        return [const Color(0xFFE65100), const Color(0xFFF57C00)];
      case 'green':
        return [const Color(0xFF2E7D32), const Color(0xFF388E3C)];
      case 'purple':
        return [const Color(0xFF4527A0), const Color(0xFF5E35B1)];
      case 'cyan':
        return [const Color(0xFF006064), const Color(0xFF0097A7)];
      case 'indigo':
        return [const Color(0xFF283593), const Color(0xFF3949AB)];
      case 'pink':
        return [const Color(0xFF880E4F), const Color(0xFFAD1457)];
      case 'brown':
        return [const Color(0xFF4E342E), const Color(0xFF6D4C41)];
      case 'gold':
        return [const Color(0xFFE65100), const Color(0xFFF9A825)];
      case 'blue':
      default:
        return [AppColors.primaryLight, AppColors.primary];
    }
  }

  Color _getBgColor() {
    final theme = widget.module.colorTheme;
    if (theme == 'red') return const Color(0xFFFFEBEE).withValues(alpha: 0.1);
    if (theme == 'teal') return const Color(0xFFE0F2F1).withValues(alpha: 0.1);
    if (theme == 'orange') {
      return const Color(0xFFFFF3E0).withValues(alpha: 0.1);
    }
    if (theme == 'green') return const Color(0xFFE8F5E9).withValues(alpha: 0.1);
    if (theme == 'purple') {
      return const Color(0xFFEDE7F6).withValues(alpha: 0.1);
    }
    if (theme == 'cyan') return const Color(0xFFE0F7FA).withValues(alpha: 0.1);
    return AppColors.primary.withValues(alpha: 0.15);
  }

  Color _getTextColor() {
    final theme = widget.module.colorTheme;
    if (theme == 'red') return AppColors.error;
    if (theme == 'teal') return const Color(0xFF00897B);
    if (theme == 'orange') return const Color(0xFFE65100);
    if (theme == 'green') return AppColors.success;
    if (theme == 'purple') return const Color(0xFF5E35B1);
    if (theme == 'cyan') return const Color(0xFF00838F);
    return AppColors.primaryLight;
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = _getThemeColors();
    final badgeBg = _getBgColor();
    final badgeText = _getTextColor();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          final routeName = widget.module.routeName;
          try {
            context.pushNamed(routeName);
          } catch (e) {
            _showComingSoonDialog(context);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: _isHovered
              ? (Matrix4.identity()..translate(0, -4))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(
              color: _isHovered
                  ? themeColors[0].withValues(alpha: 0.6)
                  : AppColors.border.withValues(alpha: 0.5),
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ]
                : [],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: themeColors),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: badgeBg,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              widget.module.emoji,
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: badgeBg,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            child: Text(
                              widget.module.badge,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: badgeText,
                                letterSpacing: 0.5,
                                fontFamily: AppTextStyles.fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        widget.module.title,
                        style: AppTextStyles.labelLarge.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Expanded(
                        child: Text(
                          widget.module.description,
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 11.5,
                            color: AppColors.secondaryText,
                            height: 1.4,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      if (widget.module.metrics.isNotEmpty)
                        Row(
                          children: widget.module.metrics.entries.map((entry) {
                            return Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 6),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.background.withValues(
                                    alpha: 0.6,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      entry.value,
                                      style: AppTextStyles.labelLarge.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryText,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 1),
                                    Text(
                                      entry.key.toUpperCase(),
                                      style: AppTextStyles.bodySmall.copyWith(
                                        fontSize: 8,
                                        color: AppColors.secondaryText,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.3,
                                        fontFamily: AppTextStyles.fontFamily,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors.border.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: widget.module.tags.take(2).map((tag) {
                          return Container(
                            decoration: BoxDecoration(
                              color: badgeBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: badgeText,
                                fontFamily: AppTextStyles.fontFamily,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 28,
                      height: 28,
                      margin: EdgeInsets.only(left: _isHovered ? 4 : 0),
                      decoration: BoxDecoration(
                        color: badgeBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: 14,
                        color: badgeText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
        title: Row(
          children: [
            Text(widget.module.emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(widget.module.title, style: AppTextStyles.titleSmall),
            ),
          ],
        ),
        content: Text(
          'The state-wide ${widget.module.title} data integration is running in offline backup mode. Real-time telemetry is fully ABDM compliant but currently accessible only from state-level command center kiosks.\n\nWould you like to simulate diagnostic access?',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.secondaryText,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: AppColors.secondaryText),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              context.pushNamed(RouteNames.dashboard);
            },
            child: const Text('Simulate'),
          ),
        ],
      ),
    );
  }
}
