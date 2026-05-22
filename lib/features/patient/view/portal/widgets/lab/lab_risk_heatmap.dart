import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class LabRiskHeatmap extends StatelessWidget {
  const LabRiskHeatmap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.grid_on_rounded,
                color: AppColors.primaryLight,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Lab Parameter Risk Heatmap',
                style: AppTextStyles.labelLarge.copyWith(fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 230,
            width: double.infinity,
            child: CustomPaint(
              size: Size.infinite,
              painter: _RiskHeatmapPainter(),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendDot(AppColors.success, 'Normal'),
              const SizedBox(width: 16),
              _buildLegendDot(AppColors.secondaryAccent, 'Borderline'),
              const SizedBox(width: 16),
              _buildLegendDot(AppColors.error, 'Abnormal'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _RiskHeatmapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final params = [
      'Glucose',
      'HbA1c',
      'LDL',
      'Total Chol',
      'Triglycer.',
      'Creatinine',
      'Uric Acid',
      'Hb',
      'WBC',
      'TSH',
    ];
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    const startX = 64;
    const cellSpacing = 3;

    final cellWidth = (size.width - startX) / months.length - cellSpacing;
    final cellHeight = (size.height - 20) / params.length - cellSpacing;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Simulated risk value array (10 rows x 12 months)
    // 0 = Normal (success), 1 = Borderline (warning), 2 = Abnormal (error)
    final riskVal = [
      [1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2], // Glucose
      [0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 2], // HbA1c
      [0, 0, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2], // LDL
      [0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 2, 2], // Total Chol
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], // Triglycerides
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], // Creatinine
      [0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1], // Uric Acid
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], // Hb
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], // WBC
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], // TSH
    ];

    // 1. Draw parameter labels on the left & draw row grid cells
    for (var r = 0; r < params.length; r++) {
      // Row Label
      textPainter
        ..text = TextSpan(
          text: params[r],
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        )
        ..layout()
        ..paint(
          canvas,
          Offset(
            startX - textPainter.width - 8,
            r * (cellHeight + cellSpacing) +
                (cellHeight / 2 - textPainter.height / 2),
          ),
        );

      // Grid Cells in Row
      for (var c = 0; c < months.length; c++) {
        final x = startX + c * (cellWidth + cellSpacing);
        final y = r * (cellHeight + cellSpacing);

        final val = riskVal[r][c];
        var cellColor = AppColors.success;
        if (val == 1) {
          cellColor = AppColors.secondaryAccent;
        } else if (val == 2) {
          cellColor = AppColors.error;
        }

        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x, y, cellWidth, cellHeight),
            const Radius.circular(2.5),
          ),
          Paint()..color = cellColor,
        );
      }
    }

    // 2. Draw Month Labels at the bottom
    final labelY = params.length * (cellHeight + cellSpacing) + 4;
    for (var c = 0; c < months.length; c++) {
      final x = startX + c * (cellWidth + cellSpacing) + (cellWidth / 2);
      textPainter
        ..text = TextSpan(
          text: months[c],
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 8),
        )
        ..layout()
        ..paint(canvas, Offset(x - textPainter.width / 2, labelY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
