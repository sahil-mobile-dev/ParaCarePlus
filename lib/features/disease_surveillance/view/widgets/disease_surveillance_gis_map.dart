import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class DiseaseSurveillanceGisMap extends StatefulWidget {
  const DiseaseSurveillanceGisMap({super.key});

  @override
  State<DiseaseSurveillanceGisMap> createState() =>
      _DiseaseSurveillanceGisMapState();
}

class _DiseaseSurveillanceGisMapState extends State<DiseaseSurveillanceGisMap> {
  String? _selectedDistrictInfo;

  final List<Map<String, dynamic>> _districts = [
    {
      'name': 'Dehradun',
      'x': 0.22,
      'y': 0.32,
      'cases': 312,
      'disease': 'Influenza/ILI',
      'alert': 'MEDIUM',
      'color': const Color(0xFFFFD166),
    },
    {
      'name': 'Haridwar',
      'x': 0.26,
      'y': 0.52,
      'cases': 487,
      'disease': 'Dengue Outbreak',
      'alert': 'CRITICAL',
      'color': AppColors.error,
    },
    {
      'name': 'Nainital',
      'x': 0.65,
      'y': 0.72,
      'cases': 92,
      'disease': 'Typhoid Monitor',
      'alert': 'LOW',
      'color': AppColors.success,
    },
    {
      'name': 'Udham S Nagar',
      'x': 0.62,
      'y': 0.85,
      'cases': 143,
      'disease': 'Malaria (Pf)',
      'alert': 'HIGH',
      'color': AppColors.secondaryAccent,
    },
    {
      'name': 'Almora',
      'x': 0.68,
      'y': 0.58,
      'cases': 84,
      'disease': 'Scrub Typhus',
      'alert': 'HIGH',
      'color': AppColors.secondaryAccent,
    },
    {
      'name': 'Pithoragarh',
      'x': 0.85,
      'y': 0.45,
      'cases': 38,
      'disease': 'Malaria Watch',
      'alert': 'LOW',
      'color': AppColors.success,
    },
    {
      'name': 'Chamoli',
      'x': 0.55,
      'y': 0.28,
      'cases': 34,
      'disease': 'Hepatitis A',
      'alert': 'MEDIUM',
      'color': const Color(0xFFFFD166),
    },
    {
      'name': 'Uttarkashi',
      'x': 0.32,
      'y': 0.14,
      'cases': 42,
      'disease': 'Leptospirosis',
      'alert': 'MEDIUM',
      'color': const Color(0xFFFFD166),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Uttarakhand Disease Surveillance GIS Map',
                      style: AppTextStyles.labelLarge,
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Active Outbreaks, Clusters & Containment Zones',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: AppColors.secondaryText,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  _buildLegendDot('Critical', AppColors.error),
                  const SizedBox(width: 8),
                  _buildLegendDot('High', AppColors.secondaryAccent),
                  const SizedBox(width: 8),
                  _buildLegendDot('Moderate', const Color(0xFFFFD166)),
                  const SizedBox(width: 8),
                  _buildLegendDot('Low', AppColors.success),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 340,
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
                    // Grid mapping lines
                    Positioned.fill(
                      child: CustomPaint(painter: _MapGridPainter()),
                    ),
                    // Background Title
                    Center(
                      child: Opacity(
                        opacity: 0.04,
                        child: Text(
                          'IDSP · IHIP GIS FEED',
                          style: AppTextStyles.titleLarge.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                    // Active Outbreak circle spots
                    ..._districts.map((d) {
                      final dx = (d['x'] as double) * w;
                      final dy = (d['y'] as double) * h;
                      final col = d['color'] as Color;

                      return Positioned(
                        left: dx - 15,
                        top: dy - 15,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDistrictInfo =
                                  '${d['name']} — ${d['disease']}\nActive Cases: ${d['cases']} · Alert: ${d['alert']}';
                            });
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Pulsing containment ring
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: col.withValues(alpha: 0.35),
                                    width: 1.5,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                              // Solid indicator center dot
                              Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: col.withValues(alpha: 0.8),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: col.withValues(alpha: 0.5),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    // District overlay tooltip box
                    if (_selectedDistrictInfo != null)
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
                                _selectedDistrictInfo!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppTextStyles.fontFamily,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedDistrictInfo = null;
                                  });
                                },
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

    // Vertical lines
    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    // Horizontal lines
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
