import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class MchGisMaps extends StatefulWidget {
  const MchGisMaps({super.key});

  @override
  State<MchGisMaps> createState() => _MchGisMapsState();
}

class _MchGisMapsState extends State<MchGisMaps> {
  String _selectedDistrict = 'Dehradun';
  double _instDel = 96.0;
  int _sam = 284;
  bool _nrc = true;

  final List<Map<String, dynamic>> _districtGeo = const [
    {
      'n': 'Dehradun',
      'x': 0.25,
      'y': 0.35,
      'instDel': 96.0,
      'sam': 284,
      'nrc': true,
    },
    {
      'n': 'Haridwar',
      'x': 0.30,
      'y': 0.55,
      'instDel': 94.0,
      'sam': 524,
      'nrc': true,
    },
    {
      'n': 'Rishikesh',
      'x': 0.38,
      'y': 0.42,
      'instDel': 97.0,
      'sam': 184,
      'nrc': false,
    },
    {
      'n': 'Uttarkashi',
      'x': 0.32,
      'y': 0.18,
      'instDel': 72.0,
      'sam': 198,
      'nrc': false,
    },
    {
      'n': 'Chamoli',
      'x': 0.55,
      'y': 0.32,
      'instDel': 68.0,
      'sam': 184,
      'nrc': false,
    },
    {
      'n': 'Almora',
      'x': 0.65,
      'y': 0.58,
      'instDel': 82.0,
      'sam': 284,
      'nrc': false,
    },
    {
      'n': 'Pithoragarh',
      'x': 0.82,
      'y': 0.48,
      'instDel': 74.0,
      'sam': 248,
      'nrc': false,
    },
    {
      'n': 'Nainital',
      'x': 0.62,
      'y': 0.70,
      'instDel': 88.0,
      'sam': 316,
      'nrc': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        final mapContent = [
          // Map Canvas
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
                  Positioned.fill(
                    child: CustomPaint(painter: _StateOutlinePainter()),
                  ),
                  // Markers
                  ..._districtGeo.map((d) {
                    final isSelected = d['n'] == _selectedDistrict;
                    final instDelVal = d['instDel'] as double;
                    Color markerColor = AppColors.success;
                    if (instDelVal < 85.0) {
                      markerColor = AppColors.error;
                    } else if (instDelVal < 95.0) {
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
                            _selectedDistrict = d['n'] as String;
                            _instDel = d['instDel'] as double;
                            _sam = d['sam'] as int;
                            _nrc = d['nrc'] as bool;
                          });
                        },
                        child: Tooltip(
                          message:
                              '${d['n']} (${d['instDel']}% Institutional Deliveries)',
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
                            child: d['nrc'] as bool
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
                  // Map Legends
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
                          _buildLegendRow(
                            '≥95% Delivery Coverage',
                            AppColors.success,
                          ),
                          const SizedBox(height: 4),
                          _buildLegendRow(
                            '85–95% Coverage',
                            AppColors.secondaryAccent,
                          ),
                          const SizedBox(height: 4),
                          _buildLegendRow('<85% Coverage', AppColors.error),
                          const SizedBox(height: 4),
                          _buildLegendRow(
                            'NRC Center Active (Star)',
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
          // Details Sidebar
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
                  const Text(
                    'SELECTED DISTRICT DETAILS',
                    style: TextStyle(
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
                  _buildDetailRow('Inst. Delivery Coverage', '$_instDel%'),
                  _buildDetailRow('SAM Burden', '$_sam children'),
                  _buildDetailRow(
                    'NRC Center Status',
                    _nrc ? 'ACTIVE FACILITY' : 'NO FACILITY',
                    valueColor: _nrc ? AppColors.success : AppColors.error,
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
                  Icon(Icons.map_rounded, color: Color(0xFFF72585), size: 16),
                  SizedBox(width: 8),
                  Text(
                    'MCH GIS — DISTRICT COVERAGE MAPS',
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

class _StateOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF72585).withValues(alpha: 0.05)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = const Color(0xFFF72585).withValues(alpha: 0.15)
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
