import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class MapsIndoorPanel extends StatefulWidget {
  const MapsIndoorPanel({super.key});

  @override
  State<MapsIndoorPanel> createState() => _MapsIndoorPanelState();
}

class _MapsIndoorPanelState extends State<MapsIndoorPanel> {
  String _activeFloor = 'G';

  static const _floors = ['G', '1', '2', '3'];
  static const _navItems = [
    ('🚨', 'Emergency OPD'),
    ('🔬', 'Lab Services'),
    ('🩻', 'Radiology Dept'),
    ('💊', 'Pharmacy'),
    ('💳', 'Billing Counter'),
    ('📅', 'My OPD Room'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Column(
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.apartment_rounded,
                    color: Color(0xFFC77DFF),
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Hospital Indoor Navigation — AIIMS Rishikesh',
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  // Floor selector
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: _floors.map((f) {
                  final isActive = _activeFloor == f;
                  return Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: GestureDetector(
                      onTap: () => setState(() => _activeFloor = f),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.primaryLight.withValues(alpha: 0.15)
                              : AppColors.surface,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: isActive
                                ? AppColors.primaryLight
                                : AppColors.border,
                          ),
                        ),
                        child: Text(
                          f == 'G' ? 'Ground' : 'Floor $f',
                          style: TextStyle(
                            color: isActive
                                ? AppColors.primaryLight
                                : AppColors.secondaryText,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Floor plan + nav
          Column(
            children: [
              Container(
                height: 220,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                clipBehavior: Clip.hardEdge,
                child: CustomPaint(
                  painter: _FloorPlanPainter(floor: _activeFloor),
                  child: Container(),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Floor plan
                  const SizedBox(width: 14),
                  // Navigation list
                  SizedBox(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Navigate To:',
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ..._navItems.map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: _NavButton(emoji: item.$1, label: item.$2),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            '📍 You are at Emergency OPD · Ground Floor. Next: Room 214, Floor 2 (Orthopaedics OPD).',
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 10,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
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

class _NavButton extends StatefulWidget {
  const _NavButton({required this.emoji, required this.label});

  final String emoji;
  final String label;

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Navigating to ${widget.label}'),
              backgroundColor: AppColors.surface,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _hovered ? AppColors.primaryLight : AppColors.border,
            ),
          ),
          child: Text(
            '${widget.emoji} ${widget.label}',
            style: const TextStyle(color: AppColors.primaryText, fontSize: 11),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────── Floor Plan Painter ───────────────────────

class _FloorPlanPainter extends CustomPainter {
  const _FloorPlanPainter({required this.floor});

  final String floor;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Outer walls
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(8, 8, w - 16, h - 16),
        const Radius.circular(6),
      ),
      Paint()
        ..color = AppColors.border
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Corridor
    canvas.drawRect(
      Rect.fromLTWH(8, h * 0.44, w - 16, h * 0.12),
      Paint()..color = AppColors.primaryLight.withValues(alpha: 0.05),
    );
    _drawText(
      canvas,
      'MAIN CORRIDOR',
      Offset(w * 0.5, h * 0.5),
      AppColors.secondaryText.withValues(alpha: 0.5),
      8,
      centered: true,
    );

    // Ground floor rooms
    if (floor == 'G') {
      _drawRoom(
        canvas,
        Rect.fromLTWH(18, 16, w * 0.17, h * 0.38),
        AppColors.success,
        'OPD BLOCK A',
        'Rooms 101-120',
      );
      _drawRoom(
        canvas,
        Rect.fromLTWH(w * 0.22, 16, w * 0.17, h * 0.38),
        AppColors.primaryLight,
        'OPD BLOCK B',
        'Rooms 121-140',
      );
      _drawRoom(
        canvas,
        Rect.fromLTWH(w * 0.42, 16, w * 0.17, h * 0.38),
        AppColors.error,
        'EMERGENCY',
        '24×7 Open',
      );
      _drawRoom(
        canvas,
        Rect.fromLTWH(w * 0.62, 16, w * 0.16, h * 0.38),
        const Color(0xFFC77DFF),
        'RADIOLOGY',
        'X-Ray/CT/MRI',
      );
      _drawRoom(
        canvas,
        Rect.fromLTWH(w * 0.80, 16, w * 0.16, h * 0.38),
        AppColors.secondaryAccent,
        'PHARMACY',
        '24×7 Open',
      );
      _drawRoom(
        canvas,
        Rect.fromLTWH(18, h * 0.58, w * 0.20, h * 0.36),
        AppColors.primaryLight,
        'LAB SERVICES',
        'Sample Coll.',
      );
      _drawRoom(
        canvas,
        Rect.fromLTWH(w * 0.25, h * 0.58, w * 0.17, h * 0.36),
        AppColors.success,
        'BILLING',
        'Insurance/Cash',
      );
      _drawRoom(
        canvas,
        Rect.fromLTWH(w * 0.44, h * 0.58, w * 0.17, h * 0.36),
        const Color(0xFFF77F00),
        'BLOOD BANK',
        'B+ available',
      );
      _drawRoom(
        canvas,
        Rect.fromLTWH(w * 0.63, h * 0.58, w * 0.16, h * 0.36),
        const Color(0xFF4361EE),
        'ENQUIRY',
        'HIMS Help Desk',
      );
      _drawRoom(
        canvas,
        Rect.fromLTWH(w * 0.81, h * 0.58, w * 0.14, h * 0.36),
        const Color(0xFFC77DFF),
        'CANTEEN',
        '7 AM – 10 PM',
      );

      // You are here marker
      canvas.drawCircle(
        Offset(w * 0.52, h * 0.24),
        8,
        Paint()..color = AppColors.error.withValues(alpha: 0.9),
      );
      _drawText(
        canvas,
        '📍',
        Offset(w * 0.52, h * 0.24),
        Colors.white,
        10,
        centered: true,
      );
    } else {
      // Upper floors - simpler layout
      final rooms = floor == '1'
          ? ['ICU', 'SURGERY', 'CARDIOLOGY', 'NEUROLOGY', 'ONCOLOGY']
          : floor == '2'
          ? ['OPD ORTHO', 'OPD GEN.MED', 'ENDOCRINOLOGY', 'NEPHROLOGY']
          : ['RESEARCH', 'CONF. ROOM', 'ADMIN', 'MEDICAL RECORDS'];

      final colors = [
        AppColors.error,
        AppColors.primaryLight,
        const Color(0xFFC77DFF),
        AppColors.success,
        AppColors.secondaryAccent,
      ];

      for (var i = 0; i < rooms.length; i++) {
        final col = i % 3;
        final row = i ~/ 3;
        _drawRoom(
          canvas,
          Rect.fromLTWH(
            18 + col * (w - 36) / 3,
            16 + row * (h * 0.38),
            (w - 36) / 3 - 4,
            h * 0.36,
          ),
          colors[i % colors.length],
          rooms[i],
          'Floor $floor',
        );
      }
    }
  }

  void _drawRoom(
    Canvas canvas,
    Rect rect,
    Color color,
    String title,
    String sub,
  ) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(4)),
      Paint()..color = color.withValues(alpha: 0.1),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(4)),
      Paint()
        ..color = color.withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
    _drawText(
      canvas,
      title,
      Offset(rect.center.dx, rect.center.dy - 6),
      color,
      8,
      centered: true,
    );
    _drawText(
      canvas,
      sub,
      Offset(rect.center.dx, rect.center.dy + 6),
      AppColors.secondaryText,
      7,
      centered: true,
    );
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset offset,
    Color color,
    double fontSize, {
    bool centered = false,
  }) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 80);
    tp.paint(
      canvas,
      centered
          ? Offset(offset.dx - tp.width / 2, offset.dy - tp.height / 2)
          : offset,
    );
  }

  @override
  bool shouldRepaint(covariant _FloorPlanPainter old) => old.floor != floor;
}
