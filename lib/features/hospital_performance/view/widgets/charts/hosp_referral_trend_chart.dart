import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class HospReferralTrendChart extends StatelessWidget {
  const HospReferralTrendChart({super.key});

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
                    'Referral Trend — Inter-hospital Flow',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Referrals sent, received and accepted (Last 6 Months)',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 8,
                children: [
                  _buildLegendItem('Sent', AppColors.primaryLight),
                  _buildLegendItem('Recv', AppColors.success),
                  _buildLegendItem('Acc', AppColors.secondaryAccent),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: CustomPaint(painter: _ReferralChartPainter()),
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
        Text(name, style: const TextStyle(color: Colors.white70, fontSize: 9)),
      ],
    );
  }
}

class _ReferralChartPainter extends CustomPainter {
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

    final sent = [420, 450, 480, 520, 580, 600];
    final recv = [380, 410, 440, 480, 520, 560];
    final accepted = [320, 350, 370, 400, 440, 480];
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];

    const maxVal = 700;
    final stepX = size.width / (sent.length - 1);

    _drawLine(canvas, size, sent, maxVal, stepX, AppColors.primaryLight, false);
    _drawLine(canvas, size, recv, maxVal, stepX, AppColors.success, false);
    _drawLine(
      canvas,
      size,
      accepted,
      maxVal,
      stepX,
      AppColors.secondaryAccent,
      true,
    );

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (var i = 0; i < months.length; i++) {
      final x = i * stepX;
      textPainter
        ..text = TextSpan(
          text: months[i],
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 8.5,
            fontWeight: FontWeight.bold,
          ),
        )
        ..layout()
        ..paint(canvas, Offset(x - (textPainter.width / 2), size.height - 12));
    }
  }

  void _drawLine(
    Canvas canvas,
    Size size,
    List<int> data,
    int maxVal,
    double stepX,
    Color color,
    bool dashed,
  ) {
    final paintLine = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final path = Path();

    for (var i = 0; i < data.length; i++) {
      final val = data[i];
      final y = size.height - ((val / maxVal) * size.height);
      final x = i * stepX;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      // Draw point dots
      final paintDot = Paint()..color = color;
      canvas.drawCircle(Offset(x, y), 3, paintDot);
    }

    if (dashed) {
      // Draw simple dashed line path
      final paintDash = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;

      canvas.drawPath(path, paintDash);
    } else {
      canvas.drawPath(path, paintLine);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
