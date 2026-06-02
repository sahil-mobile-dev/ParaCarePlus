import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class OpdQueueCongestionChart extends StatelessWidget {
  const OpdQueueCongestionChart({super.key});

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
                    'Queue Congestion Index',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Wait time (min) by facility and session today',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _buildLegendItem('Morning', AppColors.error),
                  const SizedBox(width: 8),
                  _buildLegendItem('Afternoon', AppColors.secondaryAccent),
                  const SizedBox(width: 8),
                  _buildLegendItem('Evening', AppColors.primaryLight),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: CustomPaint(painter: _QueueCongestionPainter()),
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

class _QueueCongestionPainter extends CustomPainter {
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

    final facilities = ['AIIMS', 'Doon', 'Haldwani', 'Haridwar', 'Srinagar'];
    final morning = [22, 48, 18, 38, 24];
    final afternoon = [15, 32, 12, 28, 18];
    final evening = [18, 28, 14, 22, 16];

    const maxVal = 60;
    final groupWidth = size.width / facilities.length;
    final barWidth = groupWidth * 0.2;

    final paintMorn = Paint()..color = AppColors.error;
    final paintAft = Paint()..color = AppColors.secondaryAccent;
    final paintEve = Paint()..color = AppColors.primaryLight;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (var i = 0; i < facilities.length; i++) {
      final mHeight = (morning[i] / maxVal) * size.height;
      final aHeight = (afternoon[i] / maxVal) * size.height;
      final eHeight = (evening[i] / maxVal) * size.height;

      final groupX = i * groupWidth;
      final x1 = groupX + (groupWidth * 0.15);
      final x2 = x1 + barWidth + 2;
      final x3 = x2 + barWidth + 2;

      // Draw Morning bar
      canvas
        ..drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x1, size.height - mHeight, barWidth, mHeight),
            const Radius.circular(2),
          ),
          paintMorn,
        )
        // Draw Afternoon bar
        ..drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x2, size.height - aHeight, barWidth, aHeight),
            const Radius.circular(2),
          ),
          paintAft,
        )
        // Draw Evening bar
        ..drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x3, size.height - eHeight, barWidth, eHeight),
            const Radius.circular(2),
          ),
          paintEve,
        );

      // Label
      textPainter
        ..text = TextSpan(
          text: facilities[i],
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
            groupX + (groupWidth - textPainter.width) / 2,
            size.height - 12,
          ),
        );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
