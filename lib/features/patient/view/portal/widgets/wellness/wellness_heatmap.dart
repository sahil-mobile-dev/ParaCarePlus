import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class WellnessHeatmap extends StatelessWidget {
  const WellnessHeatmap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            children: [
              Icon(
                Icons.grid_on_rounded,
                color: AppColors.success,
                size: 18,
              ),
              SizedBox(width: 8),
              Text(
                'LIFESTYLE RISK FACTOR HEATMAP — WEEKLY',
                style: AppTextStyles.labelMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const SizedBox(
            height: 240,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: SizedBox(
                width: 600,
                child: CustomPaint(
                  painter: _HeatmapPainter(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendKey('✓ Good', AppColors.success),
              const SizedBox(width: 16),
              _buildLegendKey('~ Moderate', AppColors.secondaryAccent),
              const SizedBox(width: 16),
              _buildLegendKey('✗ Poor', AppColors.error),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendKey(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            border: Border.all(color: color, width: 1.5),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.primaryText,
            fontSize: 10.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _HeatmapPainter extends CustomPainter {
  const _HeatmapPainter();

  static const List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  static const List<String> riskFactors = [
    'Physical Activity',
    'Diet Quality',
    'Sleep',
    'Hydration',
    'Stress Level',
    'Screen Time',
    'Alcohol',
  ];

  // 0=good, 1=moderate, 2=poor
  static const List<List<int>> lifestyleData = [
    [1, 1, 2, 2, 2, 1, 1], // Activity
    [0, 1, 1, 0, 1, 0, 0], // Diet
    [2, 1, 2, 1, 2, 0, 0], // Sleep
    [2, 2, 2, 2, 2, 1, 1], // Hydration
    [1, 1, 1, 2, 2, 0, 0], // Stress
    [1, 0, 1, 1, 2, 2, 1], // Screen Time
    [0, 0, 0, 0, 0, 1, 0], // Alcohol
  ];

  @override
  void paint(Canvas canvas, Size size) {
    const leftLabelWidth = 120.0;
    const bottomLabelHeight = 24.0;
    final gridWidth = size.width - leftLabelWidth;
    final gridHeight = size.height - bottomLabelHeight;

    final cellWidth = gridWidth / weekdays.length;
    final cellHeight = gridHeight / riskFactors.length;

    // Paints
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Draw Y-Axis (Risk Factors Labels)
    for (var i = 0; i < riskFactors.length; i++) {
      textPainter
        ..text = TextSpan(
          text: riskFactors[i],
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 10.5,
            fontWeight: FontWeight.w500,
          ),
        )
        ..layout()
        ..paint(
          canvas,
          Offset(
            10,
            i * cellHeight + (cellHeight - textPainter.height) / 2,
          ),
        );
    }

    // Draw Heatmap Cells
    for (var row = 0; row < riskFactors.length; row++) {
      for (var col = 0; col < weekdays.length; col++) {
        final val = lifestyleData[row][col];
        Color color;
        String symbol;

        if (val == 0) {
          color = AppColors.success;
          symbol = '✓';
        } else if (val == 1) {
          color = AppColors.secondaryAccent;
          symbol = '~';
        } else {
          color = AppColors.error;
          symbol = '✗';
        }

        final cellRect = Rect.fromLTWH(
          leftLabelWidth + col * cellWidth + 2,
          row * cellHeight + 2,
          cellWidth - 4,
          cellHeight - 4,
        );

        final fillPaint = Paint()
          ..color = color.withValues(alpha: 0.15)
          ..style = PaintingStyle.fill;

        final borderPaint = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;

        final rrect = RRect.fromRectAndRadius(cellRect, const Radius.circular(4));

        canvas
          ..drawRRect(rrect, fillPaint)
          ..drawRRect(rrect, borderPaint);

        // Draw symbol inside cell
        textPainter
          ..text = TextSpan(
            text: symbol,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          )
          ..layout()
          ..paint(
            canvas,
            Offset(
              cellRect.left + (cellRect.width - textPainter.width) / 2,
              cellRect.top + (cellRect.height - textPainter.height) / 2,
            ),
          );
      }
    }

    // Draw X-Axis (Weekdays Labels)
    for (var col = 0; col < weekdays.length; col++) {
      textPainter
        ..text = TextSpan(
          text: weekdays[col],
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
          ),
        )
        ..layout()
        ..paint(
          canvas,
          Offset(
            leftLabelWidth + col * cellWidth + (cellWidth - textPainter.width) / 2,
            size.height - bottomLabelHeight + 6,
          ),
        );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
