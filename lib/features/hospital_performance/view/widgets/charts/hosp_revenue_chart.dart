import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class HospRevenueChart extends StatelessWidget {
  const HospRevenueChart({super.key});

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
                    'Revenue vs Expenditure vs AB Claims',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Monthly financial performance trend (₹ Crores)',
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
                  _buildLegendItem('Rev', AppColors.success),
                  _buildLegendItem('Exp', AppColors.error),
                  _buildLegendItem('AB Claims', AppColors.primaryLight),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: CustomPaint(painter: _RevenueChartPainter()),
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

class _RevenueChartPainter extends CustomPainter {
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

    // Represent last 6 months data for better spacing
    final rev = [42, 45, 48, 52, 58, 62];
    final exp = [38, 39, 41, 44, 48, 52];
    final abClaims = [18, 20, 22, 24, 26, 28];
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];

    const maxVal = 70;
    final groupWidth = size.width / rev.length;
    final barWidth = groupWidth * 0.22;

    final paintRev = Paint()..color = AppColors.success;
    final paintExp = Paint()..color = AppColors.error;
    final paintClaims = Paint()..color = AppColors.primaryLight;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (var i = 0; i < rev.length; i++) {
      final rHeight = (rev[i] / maxVal) * size.height;
      final eHeight = (exp[i] / maxVal) * size.height;
      final cHeight = (abClaims[i] / maxVal) * size.height;

      final groupX = i * groupWidth;
      final x1 = groupX + (groupWidth * 0.15);
      final x2 = x1 + barWidth + 2;
      final x3 = x2 + barWidth + 2;

      // Draw Revenue bar
      canvas
        ..drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x1, size.height - rHeight, barWidth, rHeight),
            const Radius.circular(2),
          ),
          paintRev,
        )
        // Draw Expenditure bar
        ..drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x2, size.height - eHeight, barWidth, eHeight),
            const Radius.circular(2),
          ),
          paintExp,
        )
        // Draw Ayushman Claims bar
        ..drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x3, size.height - cHeight, barWidth, cHeight),
            const Radius.circular(2),
          ),
          paintClaims,
        );

      // Label
      textPainter
        ..text = TextSpan(
          text: months[i],
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 9,
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
