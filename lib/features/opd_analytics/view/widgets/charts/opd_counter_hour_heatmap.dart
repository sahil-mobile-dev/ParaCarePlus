import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class OpdCounterHourHeatmap extends StatelessWidget {
  const OpdCounterHourHeatmap({super.key});

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
                    'OPD Registration Counter Throughput (Counter × Hour)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Patients served per counter per hour (Doon Hospital)',
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
                  color: AppColors.success.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.success.withValues(alpha: 0.3),
                  ),
                ),
                child: const Text(
                  'High Output',
                  style: TextStyle(
                    color: AppColors.success,
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
              child: CustomPaint(painter: _CounterHourPainter()),
            ),
          ),
        ],
      ),
    );
  }
}

class _CounterHourPainter extends CustomPainter {
  Color _getCellColor(int val) {
    // Value range 0 to 28
    // Gradient: dark blue/navy -> green -> yellow -> red
    final factor = (val / 28.0).clamp(0.0, 1.0);
    if (factor < 0.3) {
      return Color.lerp(
        const Color(0xFF071221),
        const Color(0xFF162D4A),
        factor / 0.3,
      )!;
    } else if (factor < 0.6) {
      return Color.lerp(
        const Color(0xFF162D4A),
        AppColors.success,
        (factor - 0.3) / 0.3,
      )!;
    } else if (factor < 0.85) {
      return Color.lerp(
        AppColors.success,
        AppColors.secondaryAccent,
        (factor - 0.6) / 0.25,
      )!;
    } else {
      return Color.lerp(
        AppColors.secondaryAccent,
        AppColors.error,
        (factor - 0.85) / 0.15,
      )!;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final counters = [
      'Ctr 1',
      'Ctr 2',
      'Ctr 3',
      'Ctr 4',
      'Ctr 5',
      'Ctr 6',
      'Ctr 7',
      'Ctr 8',
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

    const leftMargin = 50.0;
    const bottomMargin = 20.0;

    final cellWidth = (size.width - leftMargin) / hrs.length;
    final cellHeight = (size.height - bottomMargin) / counters.length;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final random = Random(456);

    for (var c = 0; c < counters.length; c++) {
      // Y Label
      textPainter
        ..text = TextSpan(
          text: counters[c],
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
            c * cellHeight + (cellHeight - textPainter.height) / 2,
          ),
        );

      for (var h = 0; h < hrs.length; h++) {
        var val = random.nextInt(19) + 4;
        // Counters 5-8 often closed/low in afternoon (hi index 4 to 7)
        if (c >= 4 && h >= 4 && h <= 7) val = random.nextInt(4);
        // Peak hours 10-11 AM (hi index 2 to 4)
        if (h >= 2 && h <= 4) val = (val + random.nextInt(7) + 4).clamp(0, 28);

        final cellRect = Rect.fromLTWH(
          leftMargin + (h * cellWidth),
          c * cellHeight,
          cellWidth - 1,
          cellHeight - 1,
        );

        final paint = Paint()..color = _getCellColor(val);
        canvas.drawRect(cellRect, paint);
      }
    }

    // X Labels
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
