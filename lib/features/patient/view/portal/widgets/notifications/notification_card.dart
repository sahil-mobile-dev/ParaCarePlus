import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

enum NotifSeverity { critical, warning, info, success, ai }

class NotificationData {
  const NotificationData({
    required this.title,
    required this.badge,
    required this.text,
    required this.time,
    required this.icon,
    required this.severity,
    required this.category,
    this.isUnread = false,
    this.actions = const [],
  });

  final String title;
  final String badge;
  final String text;
  final String time;
  final IconData icon;
  final NotifSeverity severity;
  final String category; // 'critical', 'medication', 'appointment', 'lab', 'ai'
  final bool isUnread;
  final List<String> actions;

  Color get accentColor {
    switch (severity) {
      case NotifSeverity.critical:
        return AppColors.error;
      case NotifSeverity.warning:
        return AppColors.secondaryAccent;
      case NotifSeverity.info:
        return AppColors.primaryLight;
      case NotifSeverity.success:
        return AppColors.success;
      case NotifSeverity.ai:
        return const Color(0xFFC77DFF);
    }
  }

  Color get badgeColor {
    switch (severity) {
      case NotifSeverity.critical:
        return AppColors.error;
      case NotifSeverity.warning:
        return AppColors.secondaryAccent;
      case NotifSeverity.info:
        return AppColors.primaryLight;
      case NotifSeverity.success:
        return AppColors.success;
      case NotifSeverity.ai:
        return const Color(0xFFC77DFF);
    }
  }

  NotificationData copyWith({bool? isUnread}) {
    return NotificationData(
      title: title,
      badge: badge,
      text: text,
      time: time,
      icon: icon,
      severity: severity,
      category: category,
      isUnread: isUnread ?? this.isUnread,
      actions: actions,
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    required this.data,
    required this.onAction,
    required this.onDismiss,
    super.key,
  });

  final NotificationData data;
  final void Function(String action) onAction;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border, width: 3),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: data.accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(data.icon, color: data.accentColor, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + badge
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              data.title,
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _Badge(label: data.badge, color: data.badgeColor),
                          if (data.isUnread) ...[
                            const SizedBox(width: 8),
                            Container(
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                color: data.accentColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Body text
                      Text(
                        data.text,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Meta: time + actions
                      Row(
                        children: [
                          Wrap(
                            spacing: 6,
                            children: [
                              ...data.actions.map(
                                (a) => _ActionButton(
                                  label: a,
                                  isPrimary: data.actions.indexOf(a) == 0,
                                  color: data.accentColor,
                                  onTap: () => onAction(a),
                                ),
                              ),
                              _ActionButton(
                                label: 'Dismiss',
                                isPrimary: false,
                                color: AppColors.secondaryText,
                                onTap: onDismiss,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            size: 10,
                            color: AppColors.secondaryText,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            data.time,
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.isPrimary,
    required this.color,
    required this.onTap,
  });
  final String label;
  final bool isPrimary;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          color: isPrimary ? color.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isPrimary ? color : AppColors.border),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isPrimary ? color : AppColors.secondaryText,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
