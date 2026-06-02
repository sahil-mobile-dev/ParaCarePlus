import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class OpdSpecialtyWeekdayHeatmap extends StatelessWidget {
  const OpdSpecialtyWeekdayHeatmap({super.key});

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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Specialty Utilisation Rate (Specialty × Day of Week)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '% of capacity used per specialty per weekday (Last 4 Weeks Avg)',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: CustomPaint(painter: _SpecialtyWeekdayPainter()),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecialtyWeekdayPainter extends CustomPainter {
  Color _getCellColor(int val) {
    // Value range 0% to 100%
    // Gradient: dark blue/navy -> cyan/light blue -> yellow -> red
    final factor = (val / 100.0).clamp(0.0, 1.0);
    if (factor < 0.3) {
      return Color.lerp(
        const Color(0xFF071221),
        const Color(0xFF162D4A),
        factor / 0.3,
      )!;
    } else if (factor < 0.6) {
      return Color.lerp(
        const Color(0xFF162D4A),
        AppColors.primaryLight,
        (factor - 0.3) / 0.3,
      )!;
    } else if (factor < 0.85) {
      return Color.lerp(
        AppColors.primaryLight,
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
    final specs = [
      'Gen Med',
      'Ortho',
      'Gynae',
      'Paed',
      'Cardio',
      'ENT',
      'Ophthal',
      'Derma',
      'Neuro',
      'Surgery',
      'Psych',
      'Dental',
    ];
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    const leftMargin = 60.0;
    const bottomMargin = 20.0;

    final cellWidth = (size.width - leftMargin) / days.length;
    final cellHeight = (size.height - bottomMargin) / specs.length;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final random = Random(123);

    for (var s = 0; s < specs.length; s++) {
      // Y Label
      textPainter
        ..text = TextSpan(
          text: specs[s],
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
            s * cellHeight + (cellHeight - textPainter.height) / 2,
          ),
        );

      for (var d = 0; d < days.length; d++) {
        // Sunday usually lower except emergency, cardiology/gynae higher on mid-week/Mon
        var val = d == 6 ? random.nextInt(25) + 30 : random.nextInt(43) + 55;
        if (s == 4 && d <= 1) val += 15; // Cardiology Mon/Tue
        if (s == 2 && d >= 1 && d <= 3) val += 10; // Gynae mid-week
        val = val.clamp(0, 100);

        final cellRect = Rect.fromLTWH(
          leftMargin + (d * cellWidth),
          s * cellHeight,
          cellWidth - 1,
          cellHeight - 1,
        );

        final paint = Paint()..color = _getCellColor(val);
        canvas.drawRect(cellRect, paint);
      }
    }

    // X Labels
    for (var d = 0; d < days.length; d++) {
      textPainter
        ..text = TextSpan(
          text: days[d],
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
            leftMargin + (d * cellWidth) + (cellWidth - textPainter.width) / 2,
            size.height - bottomMargin + 4,
          ),
        );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
