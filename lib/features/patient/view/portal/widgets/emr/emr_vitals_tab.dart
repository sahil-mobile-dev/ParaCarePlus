import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class EMRVitalsTab extends StatelessWidget {
  const EMRVitalsTab({super.key});

  static const List<Map<String, dynamic>> _vitals = [
    {
      'date': '12 May 2026',
      'bp': '122/78 mmHg',
      'hr': '72 bpm',
      'sugar': '98 mg/dL',
      'temp': '98.4 °F',
      'spo2': '99%',
      'status': 'Normal',
      'color': AppColors.success,
    },
    {
      'date': '02 Apr 2026',
      'bp': '132/84 mmHg',
      'hr': '78 bpm',
      'sugar': '104 mg/dL',
      'temp': '98.6 °F',
      'spo2': '98%',
      'status': 'Elevated BP',
      'color': AppColors.secondaryAccent,
    },
    {
      'date': '18 Feb 2026',
      'bp': '128/80 mmHg',
      'hr': '75 bpm',
      'sugar': '112 mg/dL',
      'temp': '98.2 °F',
      'spo2': '98%',
      'status': 'Borderline Sugar',
      'color': AppColors.secondaryAccent,
    },
    {
      'date': '14 Nov 2025',
      'bp': '172/104 mmHg',
      'hr': '94 bpm',
      'sugar': '138 mg/dL',
      'temp': '99.1 °F',
      'spo2': '96%',
      'status': 'CRITICAL BP',
      'color': AppColors.error,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Custom Painter sleek health trend line chart
        Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SYSTOLIC BLOOD PRESSURE TRENDS',
                        style: AppTextStyles.labelSmall,
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Last 4 Clinical Readings',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Max: 172',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.error,
                        fontSize: 8.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Line Chart Canvas
              SizedBox(
                height: 100,
                width: double.infinity,
                child: CustomPaint(painter: _SystolicTrendPainter()),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nov 2025 (IPD)',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 8,
                    ),
                  ),
                  Text(
                    'Feb 2026 (OPD)',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 8,
                    ),
                  ),
                  Text(
                    'Apr 2026 (OPD)',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 8,
                    ),
                  ),
                  Text(
                    'May 2026 (Latest)',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('HISTORICAL VITALS LOG', style: AppTextStyles.labelSmall),
            Icon(
              Icons.trending_up_rounded,
              color: AppColors.primaryLight,
              size: 16,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _vitals.length,
          itemBuilder: (context, index) {
            final vital = _vitals[index];
            final color = vital['color'] as Color;

            return Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        vital['date'] as String,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          vital['status'] as String,
                          style: TextStyle(
                            color: color,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildVitalItem(
                        'BP',
                        vital['bp'] as String,
                        Icons.favorite_rounded,
                        AppColors.error,
                      ),
                      _buildVitalItem(
                        'Pulse',
                        vital['hr'] as String,
                        Icons.bolt_rounded,
                        AppColors.secondaryAccent,
                      ),
                      _buildVitalItem(
                        'Sugar',
                        vital['sugar'] as String,
                        Icons.water_drop_rounded,
                        AppColors.primaryLight,
                      ),
                      _buildVitalItem(
                        'SpO2',
                        vital['spo2'] as String,
                        Icons.cloud_rounded,
                        AppColors.success,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildVitalItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 10),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 9,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _SystolicTrendPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryLight
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = AppColors.primaryLight.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    final dotPaint = Paint()
      ..color = AppColors.secondaryAccent
      ..style = PaintingStyle.fill;

    // Normal baseline (120 mmHg)
    final basePaint = Paint()
      ..color = AppColors.border
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw baseline
    final yBase = size.height * 0.7;
    canvas.drawLine(Offset(0, yBase), Offset(size.width, yBase), basePaint);

    // Map 4 points: (Nov 2025: 172), (Feb 2026: 128), (Apr 2026: 132), (May 2026: 122)
    // Map values to y range 10 to 90
    // Max BP: 180, Min BP: 100
    double getMappedY(double bp) {
      final ratio = (bp - 100) / (180 - 100);
      return size.height - (ratio * size.height * 0.8) - 10;
    }

    const x1 = 10.0;
    final y1 = getMappedY(172);

    final x2 = size.width * 0.33;
    final y2 = getMappedY(128);

    final x3 = size.width * 0.66;
    final y3 = getMappedY(132);

    final x4 = size.width - 10;
    final y4 = getMappedY(122);

    // Path for line
    final path = Path()
      ..moveTo(x1, y1)
      ..lineTo(x2, y2)
      ..lineTo(x3, y3)
      ..lineTo(x4, y4);

    // Path for gradient/fill
    final fillPath = Path()
      ..moveTo(x1, size.height)
      ..lineTo(x1, y1)
      ..lineTo(x2, y2)
      ..lineTo(x3, y3)
      ..lineTo(x4, y4)
      ..lineTo(x4, size.height)
      ..close();

    canvas
      ..drawPath(fillPath, fillPaint)
      ..drawPath(path, paint);

    // Draw points and values
    void drawPoint(double x, double y, String val) {
      canvas.drawCircle(Offset(x, y), 3.5, dotPaint);

      final textSpan = TextSpan(
        text: val,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8.5,
          fontWeight: FontWeight.bold,
        ),
      );
      TextPainter(text: textSpan, textDirection: TextDirection.ltr)
        ..layout()
        ..paint(canvas, Offset(x - 8, y - 14));
    }

    drawPoint(x1, y1, '172');
    drawPoint(x2, y2, '128');
    drawPoint(x3, y3, '132');
    drawPoint(x4, y4, '122');
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
