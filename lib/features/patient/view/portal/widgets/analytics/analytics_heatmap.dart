import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AnalyticsHeatmap extends StatelessWidget {
  const AnalyticsHeatmap({super.key});

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
                Icons.calendar_month_rounded,
                color: AppColors.primaryLight,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Vitals Recording Activity — 2026 Calendar Heatmap',
                style: AppTextStyles.labelLarge.copyWith(fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 110,
            width: double.infinity,
            child: CustomPaint(size: Size.infinite, painter: _HeatmapPainter()),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Less',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 8),
              ),
              const SizedBox(width: 4),
              _buildColorBox(const Color(0xFF112240)),
              _buildColorBox(const Color(0xFF0D9488).withValues(alpha: 0.5)),
              _buildColorBox(const Color(0xFF0D9488)),
              _buildColorBox(AppColors.success.withValues(alpha: 0.7)),
              _buildColorBox(AppColors.success),
              const SizedBox(width: 4),
              const Text(
                'More',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorBox(Color color) {
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _HeatmapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double boxSize = math.min(10, (size.width - 40) / 53);
    final spacing = boxSize * 0.2;
    final gridWidth = 53 * (boxSize + spacing);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Days labels (Mon, Wed, Fri) on the left
    final dayLabels = ['Mon', 'Wed', 'Fri'];
    final labelPositions = [1, 3, 5];
    for (var i = 0; i < dayLabels.length; i++) {
      textPainter
        ..text = TextSpan(
          text: dayLabels[i],
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 7),
        )
        ..layout()
        ..paint(
          canvas,
          Offset(0, labelPositions[i] * (boxSize + spacing) + 4),
        );
    }

    // Generate simulated seed-based records for 53 weeks x 7 days
    final random = math.Random(2026); // Stable seed
    const startX = 32;

    for (var week = 0; week < 53; week++) {
      for (var day = 0; day < 7; day++) {
        final x = startX + week * (boxSize + spacing);
        final y = day * (boxSize + spacing) + 12;

        final readingCount = random.nextInt(6); // 0 to 5 readings
        var boxColor = const Color(0xFF112240);
        if (readingCount == 1) {
          boxColor = const Color(0xFF0D9488).withValues(alpha: 0.5);
        } else if (readingCount == 2) {
          boxColor = const Color(0xFF0D9488);
        } else if (readingCount == 3) {
          boxColor = AppColors.success.withValues(alpha: 0.6);
        } else if (readingCount >= 4) {
          boxColor = AppColors.success;
        }

        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x, y, boxSize, boxSize),
            const Radius.circular(1.5),
          ),
          Paint()..color = boxColor,
        );
      }
    }

    // Draw Months labels at the top
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
    for (var i = 0; i < months.length; i++) {
      final monthX = startX + (i * (gridWidth / 12));
      textPainter
        ..text = TextSpan(
          text: months[i],
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 8),
        )
        ..layout()
        ..paint(canvas, Offset(monthX, 0));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
