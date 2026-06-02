import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class OpdHourlyLoadChart extends StatelessWidget {
  const OpdHourlyLoadChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
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
                    'OPD Footfall by Hour',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Today vs 7-Day Average vs Peak Capacity (1.8K)',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  _buildLegendItem('Today', AppColors.primaryLight),
                  const SizedBox(width: 8),
                  _buildLegendItem('7-Day Avg', AppColors.success),
                  const SizedBox(width: 8),
                  _buildLegendItem('Capacity', AppColors.error),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: CustomPaint(painter: _HourlyLoadPainter()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String name, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          name,
          style: const TextStyle(color: Colors.white70, fontSize: 9.5),
        ),
      ],
    );
  }
}

class _HourlyLoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintGrid = Paint()
      ..color = AppColors.border.withValues(alpha: 0.3)
      ..strokeWidth = 1;

    // Draw horizontal grid lines
    const gridLines = 4;
    final stepY = size.height / (gridLines - 1);
    for (var i = 0; i < gridLines; i++) {
      final y = i * stepY;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paintGrid);
    }

    final hours = [
      '08:00',
      '09:00',
      '10:00',
      '11:00',
      '12:00',
      '13:00',
      '14:00',
      '15:00',
      '16:00',
      '17:00',
      '18:00',
      '19:00',
      '20:00',
    ];
    final todayLoad = [
      180,
      520,
      980,
      1420,
      1680,
      1540,
      1120,
      840,
      680,
      760,
      420,
      280,
      140,
    ];
    final avgLoad = [
      160,
      480,
      920,
      1360,
      1580,
      1480,
      1080,
      800,
      640,
      720,
      380,
      250,
      120,
    ];

    const maxVal = 2000;
    final stepX = size.width / (hours.length - 1);

    // Draw Today line with fill
    _drawArea(
      canvas,
      size,
      todayLoad,
      maxVal,
      stepX,
      AppColors.primaryLight.withValues(alpha: 0.15),
    );
    _drawLine(
      canvas,
      size,
      todayLoad,
      maxVal,
      stepX,
      AppColors.primaryLight,
      false,
    );

    // Draw Avg Line
    _drawLine(canvas, size, avgLoad, maxVal, stepX, AppColors.success, true);

    // Draw Peak Capacity Line (1800)
    final peakY = size.height - ((1800 / maxVal) * size.height);
    final paintPeak = Paint()
      ..color = AppColors.error.withValues(alpha: 0.6)
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(0, peakY), Offset(size.width, peakY), paintPeak);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // X Labels
    for (var i = 0; i < hours.length; i += 2) {
      final x = i * stepX;
      textPainter
        ..text = TextSpan(
          text: hours[i],
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 8),
        )
        ..layout()
        ..paint(canvas, Offset(x - (textPainter.width / 2), size.height - 10));
    }
  }

  void _drawLine(
    Canvas canvas,
    Size size,
    List<int> data,
    int maxVal,
    double stepX,
    Color color,
    bool dashed,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    for (var i = 0; i < data.length; i++) {
      final y = size.height - ((data[i] / maxVal) * size.height);
      final x = i * stepX;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  void _drawArea(
    Canvas canvas,
    Size size,
    List<int> data,
    int maxVal,
    double stepX,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()..moveTo(0, size.height);
    for (var i = 0; i < data.length; i++) {
      final y = size.height - ((data[i] / maxVal) * size.height);
      final x = i * stepX;
      path.lineTo(x, y);
    }
    path
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
