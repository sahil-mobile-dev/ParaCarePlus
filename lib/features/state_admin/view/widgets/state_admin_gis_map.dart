import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class StateAdminGisMap extends StatefulWidget {
  const StateAdminGisMap({super.key});

  @override
  State<StateAdminGisMap> createState() => _StateAdminGisMapState();
}

class _StateAdminGisMapState extends State<StateAdminGisMap> {
  String? _selectedFacilityInfo;

  final List<Map<String, dynamic>> _hospitals = [
    {
      'name': 'AIIMS Rishikesh',
      'x': 0.32,
      'y': 0.38,
      'beds': '920',
      'type': 'Medical College',
      'color': const Color(0xFFEF5350),
    },
    {
      'name': 'Doon Medical College, Dehradun',
      'x': 0.22,
      'y': 0.28,
      'beds': '850',
      'type': 'Medical College',
      'color': const Color(0xFFEF5350),
    },
    {
      'name': 'Haldwani Medical College',
      'x': 0.64,
      'y': 0.68,
      'beds': '780',
      'type': 'Medical College',
      'color': const Color(0xFFEF5350),
    },
    {
      'name': 'Srinagar Medical College',
      'x': 0.45,
      'y': 0.32,
      'beds': '600',
      'type': 'Medical College',
      'color': const Color(0xFFEF5350),
    },
    {
      'name': 'Haridwar District Hospital',
      'x': 0.26,
      'y': 0.54,
      'beds': '420',
      'type': 'District Hospital',
      'color': const Color(0xFF42A5F5),
    },
    {
      'name': 'Nainital District Hospital',
      'x': 0.60,
      'y': 0.62,
      'beds': '380',
      'type': 'District Hospital',
      'color': const Color(0xFF42A5F5),
    },
    {
      'name': 'Almora CHC',
      'x': 0.68,
      'y': 0.54,
      'beds': '90',
      'type': 'CHC',
      'color': const Color(0xFF26A69A),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'State Health GIS Heatmap — Facility Mapping',
                    style: AppTextStyles.labelLarge,
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Uttarakhand — 13 Districts · 1,847 Connected Facilities',
                    style: TextStyle(
                      fontSize: 10.5,
                      color: AppColors.secondaryText,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _buildLegendDot('Medical College', const Color(0xFFEF5350)),
                  const SizedBox(width: 8),
                  _buildLegendDot('District Hospital', const Color(0xFF42A5F5)),
                  const SizedBox(width: 8),
                  _buildLegendDot('CHC / PHC', const Color(0xFF26A69A)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 380,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.border.withValues(alpha: 0.3),
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final w = constraints.maxWidth;
                final h = constraints.maxHeight;

                return Stack(
                  children: [
                    // Grid background
                    Positioned.fill(
                      child: CustomPaint(painter: _MapGridPainter()),
                    ),
                    const Center(
                      child: Opacity(
                        opacity: 0.03,
                        child: Text(
                          'UTTARAKHAND HEALTH GEOGRAPHY',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                    // Facility Marker Dots
                    ..._hospitals.map((d) {
                      final dx = (d['x'] as double) * w;
                      final dy = (d['y'] as double) * h;
                      final col = d['color'] as Color;

                      return Positioned(
                        left: dx - 10,
                        top: dy - 10,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedFacilityInfo =
                                  '${d['name']}\nType: ${d['type']} · Capacity: ${d['beds']} Beds';
                            });
                          },
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: col,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white70,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: col.withValues(alpha: 0.5),
                                  blurRadius: 6,
                                  spreadRadius: 1.5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    // Info overlay box
                    if (_selectedFacilityInfo != null)
                      Positioned(
                        bottom: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _selectedFacilityInfo!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppTextStyles.fontFamily,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => setState(
                                  () => _selectedFacilityInfo = null,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white70,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendDot(String label, Color col) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: col, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 9.5,
            color: AppColors.secondaryText,
            fontFamily: AppTextStyles.fontFamily,
          ),
        ),
      ],
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..strokeWidth = 1.0;

    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
