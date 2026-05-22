import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';

class OpdGisLocator extends StatelessWidget {
  const OpdGisLocator({super.key});

  Widget buildMapCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String status,
    required Color statusCol,
    required Widget mapRepresentation,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Map Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.border, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: AppColors.primaryLight, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  status,
                  style: TextStyle(
                    color: statusCol,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Map Visual Mock
          SizedBox(
            height: 240,
            child: Stack(
              children: [
                mapRepresentation,
                // Zoom Actions
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Column(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          border: Border.all(color: AppColors.border),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          color: AppColors.secondaryText,
                          size: 16,
                        ),
                      ),
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          border: Border.all(color: AppColors.border),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove,
                          color: AppColors.secondaryText,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildVectorMapMock({required List<Map<String, dynamic>> points}) {
    return ColoredBox(
      color: const Color(0xFF071221), // Dark Leaflet canvas match
      child: CustomPaint(
        size: Size.infinite,
        painter: MapMockupPainter(points: points),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    final hospitalPoints = [
      {
        'x': 0.45,
        'y': 0.35,
        'color': AppColors.success,
        'radius': 8.0,
        'name': 'AIIMS Rishikesh',
      },
      {
        'x': 0.28,
        'y': 0.48,
        'color': AppColors.secondaryAccent,
        'radius': 8.0,
        'name': 'Doon Hospital',
      },
      {
        'x': 0.62,
        'y': 0.25,
        'color': AppColors.primaryLight,
        'radius': 8.0,
        'name': 'Max Hospital',
      },
      {
        'x': 0.52,
        'y': 0.62,
        'color': AppColors.error,
        'radius': 12.0,
        'name': 'Medical College',
      },
      {
        'x': 0.32,
        'y': 0.72,
        'color': AppColors.secondaryAccent,
        'radius': 8.0,
        'name': 'Mahant Indresh',
      },
      {
        'x': 0.75,
        'y': 0.52,
        'color': Colors.purpleAccent,
        'radius': 8.0,
        'name': 'PHC Rajpur',
      },
    ];

    final crowdPoints = [
      {
        'x': 0.45,
        'y': 0.35,
        'color': AppColors.success,
        'radius': 6.0,
        'name': 'AIIMS (Low)',
      },
      {
        'x': 0.28,
        'y': 0.48,
        'color': AppColors.secondaryAccent,
        'radius': 10.0,
        'name': 'Doon (Mod)',
      },
      {
        'x': 0.62,
        'y': 0.25,
        'color': AppColors.success,
        'radius': 6.0,
        'name': 'Max (Low)',
      },
      {
        'x': 0.52,
        'y': 0.62,
        'color': AppColors.error,
        'radius': 16.0,
        'name': 'Medical Col (High)',
      },
      {
        'x': 0.32,
        'y': 0.72,
        'color': AppColors.secondaryAccent,
        'radius': 10.0,
        'name': 'Mahant (Mod)',
      },
      {
        'x': 0.75,
        'y': 0.52,
        'color': AppColors.success,
        'radius': 6.0,
        'name': 'PHC (Low)',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.map_rounded,
                  color: AppColors.primaryLight,
                  size: 18,
                ),
                SizedBox(width: 8),
                Text(
                  'Hospital & Doctor Locator',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Opening Full GIS Interactive Map...'),
                  ),
                );
              },
              child: const Text(
                'Full Maps →',
                style: TextStyle(
                  color: AppColors.primaryLight,
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: isWide
              ? 3
              : (MediaQuery.of(context).size.width > 600 ? 2 : 1),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.25,
          children: [
            buildMapCard(
              context: context,
              icon: Icons.local_hospital_rounded,
              title: 'Nearby Hospitals',
              status: '● 12 facilities',
              statusCol: AppColors.success,
              mapRepresentation: buildVectorMapMock(points: hospitalPoints),
            ),
            buildMapCard(
              context: context,
              icon: Icons.badge_rounded,
              title: 'Available Specialists',
              status: '● Available today',
              statusCol: AppColors.success,
              mapRepresentation: buildVectorMapMock(
                points: hospitalPoints.take(4).toList(),
              ),
            ),
            buildMapCard(
              context: context,
              icon: Icons.group_rounded,
              title: 'OPD Crowd Level',
              status: 'Live data',
              statusCol: AppColors.secondaryAccent,
              mapRepresentation: buildVectorMapMock(points: crowdPoints),
            ),
          ],
        ),
      ],
    );
  }
}

// Vector grid roadmap custom painter to resemble dark styled GPS vector grids
class MapMockupPainter extends CustomPainter {
  MapMockupPainter({required this.points});
  final List<Map<String, dynamic>> points;

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.15)
      ..strokeWidth = 0.5;

    // Draw dark vector grid roads
    const gridSpacing = 30.0;
    for (double x = 0; x < size.width; x += gridSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += gridSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw main vector roads
    final roadPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.3)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    canvas
      ..drawLine(
        Offset(0, size.height * 0.4),
        Offset(size.width, size.height * 0.5),
        roadPaint,
      )
      ..drawLine(
        Offset(size.width * 0.3, 0),
        Offset(size.width * 0.45, size.height),
        roadPaint,
      )
      ..drawLine(
        Offset(size.width * 0.7, 0),
        Offset(size.width * 0.6, size.height),
        roadPaint,
      );

    // Draw pins
    for (final p in points) {
      final xVal = p['x'] as double;
      final yVal = p['y'] as double;
      final color = p['color'] as Color;
      final radius = p['radius'] as double;
      final name = p['name'] as String;

      final center = Offset(size.width * xVal, size.height * yVal);

      // Outer glow circle, core point, center dot
      canvas
        ..drawCircle(
          center,
          radius * 1.8,
          Paint()..color = color.withValues(alpha: 0.15),
        )
        ..drawCircle(center, radius * 0.8, Paint()..color = color)
        ..drawCircle(center, radius * 0.3, Paint()..color = Colors.white);

      // Tiny labels next to pins
      TextPainter(
        text: TextSpan(
          text: name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 7.5,
            fontWeight: FontWeight.bold,
            backgroundColor: Color(0xCC0C1F34),
          ),
        ),
        textDirection: TextDirection.ltr,
      )
        ..layout()
        ..paint(canvas, center + const Offset(8, -4));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
