import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class HospAdmDisChart extends StatelessWidget {
  const HospAdmDisChart({super.key});

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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daily Admissions vs Discharges',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Net occupancy change flow (Last 12 Days sample)',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.square, size: 10, color: AppColors.primaryLight),
                  SizedBox(width: 4),
                  Text(
                    'Admit',
                    style: TextStyle(color: Colors.white70, fontSize: 9),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.square, size: 10, color: AppColors.success),
                  SizedBox(width: 4),
                  Text(
                    'Discharge',
                    style: TextStyle(color: Colors.white70, fontSize: 9),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: CustomPaint(painter: _DoubleBarPainter()),
            ),
          ),
        ],
      ),
    );
  }
}

class _DoubleBarPainter extends CustomPainter {
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

    final admData = [
      3200,
      3400,
      3100,
      3600,
      3800,
      3500,
      3900,
      4100,
      3700,
      3900,
      4200,
      3847,
    ];
    final disData = [
      3000,
      3200,
      3050,
      3400,
      3700,
      3450,
      3800,
      3950,
      3600,
      3800,
      4000,
      3612,
    ];
    final labels = [
      'May 22',
      'May 23',
      'May 24',
      'May 25',
      'May 26',
      'May 27',
      'May 28',
      'May 29',
      'May 30',
      'May 31',
      'Jun 01',
      'Jun 02',
    ];

    const maxVal = 5000;
    final barGroupWidth = size.width / admData.length;
    final barWidth = barGroupWidth * 0.3;

    final paintAdm = Paint()..color = AppColors.primaryLight;
    final paintDis = Paint()..color = AppColors.success;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (var i = 0; i < admData.length; i++) {
      final admHeight = (admData[i] / maxVal) * size.height;
      final disHeight = (disData[i] / maxVal) * size.height;

      final groupX = i * barGroupWidth;
      final x1 = groupX + (barGroupWidth * 0.2);
      final x2 = x1 + barWidth + 2;

      // Draw Admissions bar
      canvas
        ..drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x1, size.height - admHeight, barWidth, admHeight),
            const Radius.circular(2),
          ),
          paintAdm,
        )
        // Draw Discharges bar
        ..drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x2, size.height - disHeight, barWidth, disHeight),
            const Radius.circular(2),
          ),
          paintDis,
        );

      // Print short labels for alternating columns to prevent overlap
      if (i % 2 == 0) {
        textPainter
          ..text = TextSpan(
            text: labels[i],
            style: const TextStyle(color: AppColors.secondaryText, fontSize: 8),
          )
          ..layout()
          ..paint(
            canvas,
            Offset(
              groupX + (barGroupWidth - textPainter.width) / 2,
              size.height - 12,
            ),
          );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
