import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class OpdRushHourHeatmap extends StatelessWidget {
  const OpdRushHourHeatmap({super.key});

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
                    'OPD Rush Hour Pattern (Facility × Hour of Day)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Average footfall per hour across top 8 facilities · Darker = more congested',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.3),
                  ),
                ),
                child: const Text(
                  'Peak: 9–12 AM',
                  style: TextStyle(
                    color: AppColors.error,
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: CustomPaint(painter: _HeatmapPainter()),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeatmapPainter extends CustomPainter {
  Color _getCellColor(int val) {
    // Value range 0 to 300
    // Gradient: dark blue/navy -> orange -> red
    final factor = (val / 300.0).clamp(0.0, 1.0);
    if (factor < 0.3) {
      return Color.lerp(
        const Color(0xFF071221),
        const Color(0xFF162D4A),
        factor / 0.3,
      )!;
    } else if (factor < 0.7) {
      return Color.lerp(
        const Color(0xFF162D4A),
        AppColors.secondaryAccent,
        (factor - 0.3) / 0.4,
      )!;
    } else {
      return Color.lerp(
        AppColors.secondaryAccent,
        AppColors.error,
        (factor - 0.7) / 0.3,
      )!;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final facilities = [
      'AIIMS',
      'Doon',
      'Haldwani',
      'Haridwar',
      'Srinagar',
      'Almora',
      'Rudrapur',
      'Pauri',
    ];
    final hrs = [
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
    ];

    const leftMargin = 60.0;
    const bottomMargin = 20.0;

    final cellWidth = (size.width - leftMargin) / hrs.length;
    final cellHeight = (size.height - bottomMargin) / facilities.length;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Draw grid cells with values based on simulated peak profile
    final peakProfile = [30, 80, 160, 220, 260, 240, 180, 140, 120, 140, 80];
    final random = Random(42);

    for (var f = 0; f < facilities.length; f++) {
      // Draw facility Y labels
      textPainter
        ..text = TextSpan(
          text: facilities[f],
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 8.5,
            fontWeight: FontWeight.bold,
          ),
        )
        ..layout()
        ..paint(
          canvas,
          Offset(
            leftMargin - textPainter.width - 8,
            f * cellHeight + (cellHeight - textPainter.height) / 2,
          ),
        );

      for (var h = 0; h < hrs.length; h++) {
        var val = peakProfile[h] + random.nextInt(50) - 20;
        if (f == 1) val = (val * 1.3).round(); // Doon Hospital peaks higher
        if (f == 3) val = (val * 1.2).round(); // Haridwar DH peaks higher
        val = val.clamp(0, 300);

        final cellRect = Rect.fromLTWH(
          leftMargin + (h * cellWidth),
          f * cellHeight,
          cellWidth - 1,
          cellHeight - 1,
        );

        final paint = Paint()..color = _getCellColor(val);
        canvas.drawRect(cellRect, paint);
      }
    }

    // Draw hour X labels at the bottom
    for (var h = 0; h < hrs.length; h += 2) {
      textPainter
        ..text = TextSpan(
          text: hrs[h],
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 8),
        )
        ..layout()
        ..paint(
          canvas,
          Offset(
            leftMargin + (h * cellWidth) + (cellWidth - textPainter.width) / 2,
            size.height - bottomMargin + 4,
          ),
        );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
