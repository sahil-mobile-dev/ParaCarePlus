import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';

class MapsMiniPanels extends StatelessWidget {
  const MapsMiniPanels({super.key});

  static const _panels = [
    {
      'title': '🩸 Blood Bank Availability',
      'sub': '3 banks nearby',
      'subColor': AppColors.error,
      'markers': [
        (0.45, 0.45, AppColors.error),
        (0.35, 0.60, AppColors.error),
        (0.62, 0.35, AppColors.error),
      ],
    },
    {
      'title': '🚑 Ambulance Positions',
      'sub': '● LIVE',
      'subColor': AppColors.success,
      'markers': [
        (0.52, 0.48, AppColors.success),
        (0.62, 0.33, AppColors.success),
        (0.40, 0.58, AppColors.secondaryAccent),
      ],
    },
    {
      'title': '💊 24×7 Open Pharmacies',
      'sub': '6 open now',
      'subColor': AppColors.primaryLight,
      'markers': [
        (0.48, 0.42, AppColors.primaryLight),
        (0.55, 0.52, AppColors.primaryLight),
        (0.40, 0.35, AppColors.primaryLight),
        (0.62, 0.48, AppColors.primaryLight),
        (0.35, 0.60, AppColors.primaryLight),
        (0.70, 0.40, AppColors.primaryLight),
      ],
    },
    {
      'title': '💉 Vaccination Centres',
      'sub': '5 centres',
      'subColor': Color(0xFFC77DFF),
      'markers': [
        (0.45, 0.45, Color(0xFFC77DFF)),
        (0.35, 0.60, Color(0xFFC77DFF)),
        (0.62, 0.35, Color(0xFFC77DFF)),
        (0.52, 0.68, Color(0xFFC77DFF)),
        (0.28, 0.50, Color(0xFFC77DFF)),
      ],
    },
    {
      'title': '🦠 Disease Heatmap',
      'sub': 'Dengue alert',
      'subColor': AppColors.secondaryAccent,
      'markers': <(double, double, Color)>[],
    },
    {
      'title': '🔬 Diagnostic Labs',
      'sub': '9 labs open',
      'subColor': Color(0xFF0D9488),
      'markers': [
        (0.48, 0.44, Color(0xFF0D9488)),
        (0.42, 0.54, Color(0xFF0D9488)),
        (0.38, 0.40, Color(0xFF0D9488)),
        (0.58, 0.50, Color(0xFF0D9488)),
        (0.55, 0.36, Color(0xFF0D9488)),
        (0.35, 0.65, Color(0xFF0D9488)),
        (0.66, 0.38, Color(0xFF0D9488)),
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Live GIS Panels — Multi-Layer Views',
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          children: _panels.map((panel) {
            return Padding(
              padding: EdgeInsets.only(
                right: _panels.indexOf(panel) == _panels.length - 1 ? 0 : 14,
              ),
              child: _MiniMapCard(panel: panel),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _MiniMapCard extends StatelessWidget {
  const _MiniMapCard({required this.panel});

  final Map<String, dynamic> panel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    panel['title'] as String,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  panel['sub'] as String,
                  style: TextStyle(
                    color: panel['subColor'] as Color,
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 140,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
              child: CustomPaint(
                painter: _MiniMapPainter(
                  markers: panel['markers'] as List<(double, double, Color)>,
                  isDiseaseMap: panel['title'].toString().contains('Disease'),
                ),
                child: Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniMapPainter extends CustomPainter {
  const _MiniMapPainter({required this.markers, this.isDiseaseMap = false});

  final List<(double, double, Color)> markers;
  final bool isDiseaseMap;

  @override
  void paint(Canvas canvas, Size size) {
    // Background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFF060F1C),
    );

    // Grid
    final gp = Paint()
      ..color = AppColors.border.withValues(alpha: 0.25)
      ..strokeWidth = 0.5;
    for (double x = 0; x < size.width; x += 25) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gp);
    }
    for (double y = 0; y < size.height; y += 25) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gp);
    }

    // Roads
    final rp = Paint()
      ..color = AppColors.border.withValues(alpha: 0.4)
      ..strokeWidth = 1.5;
    canvas
      ..drawLine(
        Offset(0, size.height * 0.5),
        Offset(size.width, size.height * 0.5),
        rp,
      )
      ..drawLine(
        Offset(size.width * 0.5, 0),
        Offset(size.width * 0.5, size.height),
        rp,
      );

    if (isDiseaseMap) {
      for (final spot in [
        (0.55, 0.42, 35.0),
        (0.35, 0.60, 25.0),
        (0.70, 0.35, 30.0),
      ]) {
        canvas
          ..drawCircle(
            Offset(size.width * spot.$1, size.height * spot.$2),
            spot.$3,
            Paint()..color = AppColors.secondaryAccent.withValues(alpha: 0.2),
          )
          ..drawCircle(
            Offset(size.width * spot.$1, size.height * spot.$2),
            spot.$3,
            Paint()
              ..color = const Color(0xFFF77F00).withValues(alpha: 0.35)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.5,
          );
      }
      canvas.drawCircle(
        Offset(size.width * 0.55, size.height * 0.42),
        6,
        Paint()..color = AppColors.error,
      );
    }

    // User
    final up = Offset(size.width * 0.5, size.height * 0.5);
    canvas
      ..drawCircle(
        up,
        10,
        Paint()..color = AppColors.secondaryAccent.withValues(alpha: 0.15),
      )
      ..drawCircle(up, 5, Paint()..color = AppColors.secondaryAccent)
      ..drawCircle(up, 2.5, Paint()..color = Colors.white);

    // Markers
    for (final m in markers) {
      final pt = Offset(size.width * m.$1, size.height * m.$2);
      canvas
        ..drawCircle(pt, 6, Paint()..color = m.$3)
        ..drawCircle(
          pt,
          6,
          Paint()
            ..color = Colors.white.withValues(alpha: 0.3)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5,
        )
        ..drawCircle(pt, 2, Paint()..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
