import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class OpdConsultationTrendChart extends StatelessWidget {
  const OpdConsultationTrendChart({super.key});

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
                    'Doctor Consultation Trend — Last 30 Days',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Daily consultation count by department (Top 5 Specialties)',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Wrap(
                spacing: 8,
                children: [
                  _buildLegendItem('Med', AppColors.primaryLight),
                  _buildLegendItem('Ortho', AppColors.success),
                  _buildLegendItem('Gynae', Colors.purpleAccent),
                  _buildLegendItem('Paed', AppColors.secondaryAccent),
                  _buildLegendItem('Cardio', AppColors.error),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: CustomPaint(painter: _ConsultationTrendPainter()),
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

class _ConsultationTrendPainter extends CustomPainter {
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

    // Static data points for 15 intervals to represent 30 days cleanly
    final medData = [
      9500,
      9700,
      9600,
      10100,
      10500,
      10200,
      10800,
      11200,
      10700,
      10900,
      11400,
      11800,
      11500,
      12000,
      12500,
    ];
    final orthoData = [
      7000,
      7200,
      7100,
      7500,
      7800,
      7600,
      8000,
      8200,
      7900,
      8100,
      8400,
      8700,
      8500,
      8900,
      9200,
    ];
    final gynaeData = [
      6300,
      6500,
      6400,
      6800,
      7100,
      6900,
      7200,
      7400,
      7100,
      7300,
      7600,
      7900,
      7700,
      8100,
      8300,
    ];
    final paedData = [
      5800,
      6000,
      5900,
      6200,
      6400,
      6200,
      6500,
      6700,
      6400,
      6600,
      6900,
      7100,
      6900,
      7200,
      7400,
    ];
    final cardioData = [
      4200,
      4400,
      4300,
      4600,
      4800,
      4600,
      4900,
      5100,
      4800,
      5000,
      5300,
      5500,
      5300,
      5600,
      5800,
    ];

    const maxVal = 14000;
    final stepX = size.width / (medData.length - 1);

    _drawLine(canvas, size, medData, maxVal, stepX, AppColors.primaryLight);
    _drawLine(canvas, size, orthoData, maxVal, stepX, AppColors.success);
    _drawLine(canvas, size, gynaeData, maxVal, stepX, Colors.purpleAccent);
    _drawLine(canvas, size, paedData, maxVal, stepX, AppColors.secondaryAccent);
    _drawLine(canvas, size, cardioData, maxVal, stepX, AppColors.error);
  }

  void _drawLine(
    Canvas canvas,
    Size size,
    List<int> data,
    int maxVal,
    double stepX,
    Color color,
  ) {
    final paintLine = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

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
    canvas.drawPath(path, paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
