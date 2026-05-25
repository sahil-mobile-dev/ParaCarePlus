import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';

class NotificationsSidePanel extends StatefulWidget {
  const NotificationsSidePanel({required this.onCategoryFilter, super.key});

  final void Function(String category) onCategoryFilter;

  @override
  State<NotificationsSidePanel> createState() =>
      _NotificationsSidePanelState();
}

class _NotificationsSidePanelState extends State<NotificationsSidePanel> {
  final Map<String, bool> _preferences = {
    'Critical Health Alerts': true,
    'Medication Reminders': true,
    'Appointment Alerts': true,
    'AI Smart Notifications': true,
    'Weekly Health Summary': true,
    'Lab Report Ready': true,
    'Health Tips & Wellness': false,
    'Promotional Messages': false,
  };

  final Map<String, bool> _channels = {
    'Push Notifications': true,
    'Email Alerts': true,
    'SMS (WhatsApp)': true,
    'In-App Only': true,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AlertCategoriesPanel(onFilter: widget.onCategoryFilter),
        const SizedBox(height: 14),
        const _AlertVolumeChart(),
        const SizedBox(height: 14),
        _PreferencesPanel(
          title: 'Notification Preferences',
          icon: Icons.notifications_off_outlined,
          iconColor: const Color(0xFFC77DFF),
          items: _preferences,
          onToggle: (key) {
            setState(() => _preferences[key] = !(_preferences[key] ?? false));
          },
        ),
        const SizedBox(height: 14),
        _DeliveryChannelsPanel(
          channels: _channels,
          onToggle: (key) {
            setState(() => _channels[key] = !(_channels[key] ?? false));
          },
        ),
      ],
    );
  }
}

class _AlertCategoriesPanel extends StatelessWidget {
  const _AlertCategoriesPanel({required this.onFilter});
  final void Function(String) onFilter;

  static const _categories = [
    {
      'label': 'Critical Health',
      'count': '2',
      'tag': 'critical',
      'icon': Icons.warning_rounded,
      'color': AppColors.error,
    },
    {
      'label': 'Medication',
      'count': '5',
      'tag': 'medication',
      'icon': Icons.medication_liquid_rounded,
      'color': AppColors.secondaryAccent,
    },
    {
      'label': 'Appointments',
      'count': '3',
      'tag': 'appointment',
      'icon': Icons.calendar_month_rounded,
      'color': AppColors.primaryLight,
    },
    {
      'label': 'Lab & Radiology',
      'count': '4',
      'tag': 'lab',
      'icon': Icons.science_outlined,
      'color': AppColors.success,
    },
    {
      'label': 'AI Smart Alerts',
      'count': '4',
      'tag': 'ai',
      'icon': Icons.smart_toy_outlined,
      'color': Color(0xFFC77DFF),
    },
    {
      'label': 'Bills & Finance',
      'count': '2',
      'tag': 'finance',
      'icon': Icons.receipt_long_rounded,
      'color': Color(0xFF4361EE),
    },
    {
      'label': 'Vaccination Due',
      'count': '1',
      'tag': 'vaccination',
      'icon': Icons.vaccines_rounded,
      'color': Color(0xFF0D9488),
    },
    {
      'label': 'Vitals Anomaly',
      'count': '3',
      'tag': 'vitals',
      'icon': Icons.favorite_outlined,
      'color': Color(0xFFF77F00),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return _PanelBox(
      title: 'Alert Categories',
      icon: Icons.layers_outlined,
      iconColor: AppColors.primaryLight,
      child: Column(
        children: _categories.map((cat) {
          final color = cat['color']! as Color;
          final icon = cat['icon']! as IconData;
          return GestureDetector(
            onTap: () => onFilter(cat['tag']! as String),
            child: Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: color, size: 14),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      cat['label']! as String,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      cat['count']! as String,
                      style: TextStyle(
                        color: color,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _AlertVolumeChart extends StatelessWidget {
  const _AlertVolumeChart();

  final List<Map<String, dynamic>> _data = const [
    {'day': 'Mon', 'critical': 1, 'warning': 2, 'info': 4},
    {'day': 'Tue', 'critical': 0, 'warning': 3, 'info': 5},
    {'day': 'Wed', 'critical': 2, 'warning': 1, 'info': 3},
    {'day': 'Thu', 'critical': 1, 'warning': 2, 'info': 6},
    {'day': 'Fri', 'critical': 0, 'warning': 1, 'info': 4},
    {'day': 'Sat', 'critical': 1, 'warning': 2, 'info': 3},
    {'day': 'Sun', 'critical': 2, 'warning': 5, 'info': 14},
  ];

  @override
  Widget build(BuildContext context) {
    return _PanelBox(
      title: 'Alert Volume — 7 Days',
      icon: Icons.bar_chart_rounded,
      iconColor: AppColors.secondaryAccent,
      child: SizedBox(
        height: 160,
        child: CustomPaint(
          painter: _AlertBarPainter(data: _data),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _AlertBarPainter extends CustomPainter {
  const _AlertBarPainter({required this.data});
  final List<Map<String, dynamic>> data;

  @override
  void paint(Canvas canvas, Size size) {
    const criticalColor = AppColors.error;
    const warningColor = AppColors.secondaryAccent;
    const infoColor = AppColors.primaryLight;

    final maxTotal = data.fold<int>(0, (m, d) {
      final t = (d['critical'] as int) +
          (d['warning'] as int) +
          (d['info'] as int);
      return t > m ? t : m;
    }).toDouble();

    final barW = (size.width - 48) / data.length;
    final usableH = size.height - 24;

    for (var i = 0; i < data.length; i++) {
      final d = data[i];
      final x = 24 + i * barW + barW * 0.1;
      final w = barW * 0.8;

      final criH = ((d['critical'] as int) / maxTotal) * usableH;
      final warH = ((d['warning'] as int) / maxTotal) * usableH;
      final infH = ((d['info'] as int) / maxTotal) * usableH;

      var yBottom = size.height - 20;

      void drawSegment(double h, Color c) {
        if (h <= 0) return;
        final rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(x, yBottom - h, w, h),
          const Radius.circular(2),
        );
        canvas.drawRRect(rect, Paint()..color = c);
        yBottom -= h;
      }

      drawSegment(criH, criticalColor.withValues(alpha: 0.85));
      drawSegment(warH, warningColor.withValues(alpha: 0.85));
      drawSegment(infH, infoColor.withValues(alpha: 0.7));

      // Day label
      final tp = TextPainter(
        text: TextSpan(
          text: d['day'] as String,
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 9,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(x + w / 2 - tp.width / 2, size.height - 16),
      );
    }

    // Legend
    const legendItems = [
      ('Critical', criticalColor),
      ('Warning', warningColor),
      ('Info', infoColor),
    ];
    double lx = 24;
    for (final (label, color) in legendItems) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(lx, 0, 10, 7), const Radius.circular(2)),
        Paint()..color = color,
      );
      final tp = TextPainter(
        text: TextSpan(
          text: label,
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 9),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(lx + 13, 0));
      lx += tp.width + 26;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PreferencesPanel extends StatelessWidget {
  const _PreferencesPanel({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.items,
    required this.onToggle,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final Map<String, bool> items;
  final void Function(String) onToggle;

  @override
  Widget build(BuildContext context) {
    return _PanelBox(
      title: title,
      icon: icon,
      iconColor: iconColor,
      child: Column(
        children: items.entries.map((e) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: e.key == items.keys.last
                      ? Colors.transparent
                      : AppColors.border.withValues(alpha: 0.5),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    e.key,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 12,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => onToggle(e.key),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 20,
                    decoration: BoxDecoration(
                      color: e.value
                          ? AppColors.success
                          : AppColors.secondaryText,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 200),
                      alignment:
                          e.value ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _DeliveryChannelsPanel extends StatelessWidget {
  const _DeliveryChannelsPanel({
    required this.channels,
    required this.onToggle,
  });

  final Map<String, bool> channels;
  final void Function(String) onToggle;

  static const _channelIcons = {
    'Push Notifications': Icons.smartphone_rounded,
    'Email Alerts': Icons.email_outlined,
    'SMS (WhatsApp)': Icons.chat_bubble_outline_rounded,
    'In-App Only': Icons.notifications_outlined,
  };

  static const _channelColors = {
    'Push Notifications': AppColors.primaryLight,
    'Email Alerts': AppColors.secondaryAccent,
    'SMS (WhatsApp)': AppColors.success,
    'In-App Only': Color(0xFFC77DFF),
  };

  @override
  Widget build(BuildContext context) {
    return _PanelBox(
      title: 'Delivery Channels',
      icon: Icons.share_rounded,
      iconColor: AppColors.success,
      child: Column(
        children: [
          ...channels.entries.map((e) {
            final icon = _channelIcons[e.key] ?? Icons.notifications;
            final color = _channelColors[e.key] ?? AppColors.primaryLight;
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: e.key == channels.keys.last
                        ? Colors.transparent
                        : AppColors.border.withValues(alpha: 0.5),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(icon, color: color, size: 14),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      e.key,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onToggle(e.key),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 36,
                      height: 20,
                      decoration: BoxDecoration(
                        color: e.value ? AppColors.success : AppColors.secondaryText,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AnimatedAlign(
                        duration: const Duration(milliseconds: 200),
                        alignment: e.value
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4361EE),
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              onPressed: () {},
              child: const Text(
                'Save Preferences',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PanelBox extends StatelessWidget {
  const _PanelBox({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 14),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
