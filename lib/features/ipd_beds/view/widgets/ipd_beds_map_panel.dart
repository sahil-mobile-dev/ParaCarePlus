import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class IpdBedsMapPanel extends StatefulWidget {
  const IpdBedsMapPanel({super.key});

  @override
  State<IpdBedsMapPanel> createState() => _IpdBedsMapPanelState();
}

class _IpdBedsMapPanelState extends State<IpdBedsMapPanel> {
  String _selectedDistrict = 'Dehradun';
  int _bedCount = 750;
  double _occupancy = 88.4;
  bool _icuCritical = true;

  final List<Map<String, dynamic>> _districts = const [
    {
      'name': 'Dehradun',
      'x': 0.25,
      'y': 0.35,
      'beds': 750,
      'occ': 88.4,
      'icu': true,
    },
    {
      'name': 'Haridwar',
      'x': 0.30,
      'y': 0.55,
      'beds': 450,
      'occ': 91.2,
      'icu': true,
    },
    {
      'name': 'Rishikesh',
      'x': 0.38,
      'y': 0.42,
      'beds': 300,
      'occ': 64.6,
      'icu': false,
    },
    {
      'name': 'Uttarkashi',
      'x': 0.32,
      'y': 0.18,
      'beds': 120,
      'occ': 72.0,
      'icu': false,
    },
    {
      'name': 'Chamoli',
      'x': 0.55,
      'y': 0.32,
      'beds': 80,
      'occ': 48.6,
      'icu': false,
    },
    {
      'name': 'Almora',
      'x': 0.65,
      'y': 0.58,
      'beds': 350,
      'occ': 72.8,
      'icu': false,
    },
    {
      'name': 'Pithoragarh',
      'x': 0.82,
      'y': 0.48,
      'beds': 150,
      'occ': 82.0,
      'icu': false,
    },
    {
      'name': 'Nainital',
      'x': 0.62,
      'y': 0.70,
      'beds': 280,
      'occ': 78.5,
      'icu': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        final mapContent = [
          // Simulated Map
          Expanded(
            flex: isWide ? 3 : 0,
            child: Container(
              height: 320,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.border.withValues(alpha: 0.3),
                ),
              ),
              child: Stack(
                children: [
                  // Vector state background simulation
                  Positioned.fill(
                    child: CustomPaint(painter: _StateMapOutlinePainter()),
                  ),
                  // Interactive nodes
                  ..._districts.map((d) {
                    final isSelected = d['name'] == _selectedDistrict;
                    final occ = d['occ'] as double;
                    Color markerColor = AppColors.success;
                    if (occ >= 90.0) {
                      markerColor = AppColors.error;
                    } else if (occ >= 75.0) {
                      markerColor = AppColors.secondaryAccent;
                    }

                    return Positioned(
                      left:
                          constraints.maxWidth *
                              (isWide ? 0.6 : 1.0) *
                              (d['x'] as double) +
                          20,
                      top: 300 * (d['y'] as double),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDistrict = d['name'] as String;
                            _bedCount = d['beds'] as int;
                            _occupancy = d['occ'] as double;
                            _icuCritical = d['icu'] as bool;
                          });
                        },
                        child: Tooltip(
                          message: '${d['name']} (${d['occ']}%)',
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: isSelected ? 24 : 14,
                            height: isSelected ? 24 : 14,
                            decoration: BoxDecoration(
                              color: markerColor.withValues(alpha: 0.8),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white70,
                                width: isSelected ? 2.5 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: markerColor.withValues(alpha: 0.4),
                                  blurRadius: isSelected ? 12 : 6,
                                  spreadRadius: isSelected ? 4 : 1,
                                ),
                              ],
                            ),
                            child: d['icu'] as bool
                                ? const Center(
                                    child: Icon(
                                      Icons.star,
                                      size: 8,
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      ),
                    );
                  }),
                  // Legend overlays
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.surface.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.border.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLegendRow('≥25% Free Beds', AppColors.success),
                          const SizedBox(height: 4),
                          _buildLegendRow(
                            '10-25% Free Beds',
                            AppColors.secondaryAccent,
                          ),
                          const SizedBox(height: 4),
                          _buildLegendRow('<10% Free Beds', AppColors.error),
                          const SizedBox(height: 4),
                          _buildLegendRow(
                            'ICU Critical Capacity (Star)',
                            const Color(0xFFC77DFF),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isWide) const SizedBox(width: 14) else const SizedBox(height: 14),
          // Sidebar Details
          Expanded(
            flex: isWide ? 1 : 0,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(
                  color: AppColors.border.withValues(alpha: 0.4),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SELECTED NODE DETAILS',
                    style: const TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: AppColors.secondaryText,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _selectedDistrict,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 16, color: AppColors.border),
                  _buildDetailRow('Total IPD Beds', _bedCount.toString()),
                  _buildDetailRow('Bed Occupancy %', '$_occupancy%'),
                  _buildDetailRow(
                    'ICU Priority Alert',
                    _icuCritical ? 'CRITICAL WATCH' : 'STABLE BUFFER',
                    valueColor: _icuCritical
                        ? AppColors.error
                        : AppColors.success,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.route_rounded,
                        size: 14,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Analyze Transfer Networks',
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ];

        return Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.map_rounded,
                    color: AppColors.primaryLight,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'GIS — STATEWIDE BED & ICU DISTRIBUTION MAP',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: AppColors.secondaryText,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: mapContent,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: mapContent,
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLegendRow(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 9.5,
            fontFamily: AppTextStyles.fontFamily,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 11,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _StateMapOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.15)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.3)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width * 0.15, size.height * 0.40)
      ..lineTo(size.width * 0.35, size.height * 0.20)
      ..lineTo(size.width * 0.50, size.height * 0.25)
      ..lineTo(size.width * 0.65, size.height * 0.15)
      ..lineTo(size.width * 0.85, size.height * 0.35)
      ..lineTo(size.width * 0.90, size.height * 0.55)
      ..lineTo(size.width * 0.75, size.height * 0.75)
      ..lineTo(size.width * 0.60, size.height * 0.80)
      ..lineTo(size.width * 0.45, size.height * 0.70)
      ..lineTo(size.width * 0.30, size.height * 0.65)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
