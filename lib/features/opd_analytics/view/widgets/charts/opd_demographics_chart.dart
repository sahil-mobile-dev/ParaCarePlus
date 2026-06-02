import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class OpdDemographicsChart extends StatelessWidget {
  const OpdDemographicsChart({super.key});

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
                    'Patient Age & Gender Distribution',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'OPD Patients by Age Group (MTD)',
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
                    'Male',
                    style: TextStyle(color: Colors.white70, fontSize: 9),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.square, size: 10, color: Colors.pinkAccent),
                  SizedBox(width: 4),
                  Text(
                    'Female',
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
              child: CustomPaint(painter: _DemographicsPainter()),
            ),
          ),
        ],
      ),
    );
  }
}

class _DemographicsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerAxisX = size.width / 2;
    final ageGroups = [
      '0–5',
      '6–14',
      '15–24',
      '25–34',
      '35–44',
      '45–54',
      '55–64',
      '65+',
    ];

    final males = [2840, 3120, 4280, 6840, 7120, 6480, 4820, 3640];
    final females = [2640, 3280, 5840, 7120, 7480, 6240, 4120, 3080];

    const maxVal = 8000;
    final stepY = size.height / ageGroups.length;
    final barHeight = stepY * 0.45;

    final paintMale = Paint()..color = AppColors.primaryLight;
    final paintFemale = Paint()..color = Colors.pinkAccent;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Draw center axis line
    canvas.drawLine(
      Offset(centerAxisX, 0),
      Offset(centerAxisX, size.height - 20),
      Paint()..color = AppColors.border.withValues(alpha: 0.5),
    );

    for (var i = 0; i < ageGroups.length; i++) {
      final y = (i * stepY) + (stepY - barHeight) / 2;

      final mWidth = (males[i] / maxVal) * (size.width / 2 - 30);
      final fWidth = (females[i] / maxVal) * (size.width / 2 - 30);

      // Draw Male bar (Right side)
      canvas
        ..drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(centerAxisX + 15, y, mWidth, barHeight),
            const Radius.circular(2),
          ),
          paintMale,
        )
        // Draw Female bar (Left side)
        ..drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(centerAxisX - 15 - fWidth, y, fWidth, barHeight),
            const Radius.circular(2),
          ),
          paintFemale,
        );

      // Draw Age Group text in the center gap
      textPainter
        ..text = TextSpan(
          text: ageGroups[i],
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 8.5,
            fontWeight: FontWeight.bold,
          ),
        )
        ..layout()
        ..paint(
          canvas,
          Offset(
            centerAxisX - (textPainter.width / 2),
            y + (barHeight - textPainter.height) / 2,
          ),
        );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
