import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class HospBedOccupancyTrendChart extends StatelessWidget {
  const HospBedOccupancyTrendChart({super.key});

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
              Container(
                width: MediaQuery.sizeOf(context).width * 0.55,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Overall Bed Occupancy % — State-wide Daily Trend',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'General · ICU · HDU · Maternity · Paediatric ward occupancy lines (30 Days)',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  _buildLegendItem('Gen', AppColors.primaryLight),
                  _buildLegendItem('ICU', AppColors.error),
                  _buildLegendItem('HDU', AppColors.secondaryAccent),
                  _buildLegendItem('Mat', Colors.pinkAccent),
                  _buildLegendItem('Paed', AppColors.success),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: CustomPaint(painter: _LineChartPainter()),
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

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintGrid = Paint()
      ..color = AppColors.border.withValues(alpha: 0.3)
      ..strokeWidth = 1;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Draw horizontal grid lines
    const gridLines = 5;
    final stepY = size.height / (gridLines - 1);
    for (var i = 0; i < gridLines; i++) {
      final y = i * stepY;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paintGrid);

      final val = 100 - (i * 15);
      textPainter
        ..text = TextSpan(
          text: '$val%',
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 8.5),
        )
        ..layout()
        ..paint(canvas, Offset(2, y - 12));
    }

    // Static data points for 30 days
    final genData = [
      72,
      74,
      73,
      76,
      75,
      78,
      80,
      79,
      82,
      81,
      84,
      83,
      85,
      82,
      80,
      78,
      77,
      79,
      81,
      83,
      82,
      80,
      79,
      81,
      84,
      85,
      83,
      82,
      84,
      85,
    ];
    final icuData = [
      87,
      88,
      89,
      87,
      86,
      88,
      90,
      89,
      91,
      92,
      90,
      89,
      88,
      87,
      86,
      88,
      90,
      91,
      92,
      90,
      89,
      88,
      87,
      89,
      91,
      92,
      90,
      91,
      92,
      93,
    ];
    final hduData = [
      80,
      81,
      79,
      82,
      83,
      80,
      78,
      80,
      82,
      84,
      83,
      82,
      81,
      80,
      79,
      81,
      83,
      82,
      80,
      81,
      83,
      84,
      82,
      81,
      83,
      82,
      80,
      81,
      83,
      84,
    ];
    final matData = [
      68,
      69,
      67,
      70,
      71,
      68,
      66,
      68,
      70,
      72,
      71,
      70,
      69,
      68,
      67,
      69,
      71,
      70,
      68,
      69,
      71,
      72,
      70,
      69,
      71,
      70,
      68,
      69,
      71,
      72,
    ];
    final paedData = [
      62,
      63,
      61,
      64,
      65,
      62,
      60,
      62,
      64,
      66,
      65,
      64,
      63,
      62,
      61,
      63,
      65,
      64,
      62,
      63,
      65,
      66,
      64,
      63,
      65,
      64,
      62,
      63,
      65,
      66,
    ];

    _drawLine(canvas, size, genData, AppColors.primaryLight);
    _drawLine(canvas, size, icuData, AppColors.error);
    _drawLine(canvas, size, hduData, AppColors.secondaryAccent);
    _drawLine(canvas, size, matData, Colors.pinkAccent);
    _drawLine(canvas, size, paedData, AppColors.success);
  }

  void _drawLine(Canvas canvas, Size size, List<int> data, Color color) {
    final paintLine = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final stepX = size.width / (data.length - 1);

    for (var i = 0; i < data.length; i++) {
      // Map percentage (40% to 100%) to Y coordinates
      final val = data[i];
      final normalized = (val - 40) / 60; // 0.0 to 1.0
      final y = size.height - (normalized * size.height);
      final x = i * stepX;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
