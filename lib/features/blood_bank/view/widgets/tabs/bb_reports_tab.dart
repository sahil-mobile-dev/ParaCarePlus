import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class BbReportsTab extends StatelessWidget {
  const BbReportsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Charts Row 1
        LayoutBuilder(
          builder: (context, constraints) {
            final double cardWidth = constraints.maxWidth > 850
                ? (constraints.maxWidth - AppSpacing.md) / 2
                : constraints.maxWidth;

            return Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                // Monthly Collected & Issued
                Container(
                  width: cardWidth,
                  height: 280,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '📊 MONTHLY COLLECTION vs DISPATCH (BAGS)',
                        style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.secondaryText),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Expanded(
                        child: CustomPaint(
                          painter: _BbMonthlyPainter(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _legendDot('Collected', const Color(0xFF880E4F)),
                          const SizedBox(width: 12),
                          _legendDot('Issued', const Color(0xFFC62828)),
                        ],
                      ),
                    ],
                  ),
                ),
                // Blood Group Distribution
                Container(
                  width: cardWidth,
                  height: 280,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '🍩 BLOOD GROUP VOLUME DISTRIBUTION',
                        style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.secondaryText),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Expanded(
                        child: CustomPaint(
                          painter: _BbDistributionPainter(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _legendDot('O+', const Color(0xFFC62828)),
                          const SizedBox(width: 8),
                          _legendDot('B+', const Color(0xFF880E4F)),
                          const SizedBox(width: 8),
                          _legendDot('A+', const Color(0xFFE65100)),
                          const SizedBox(width: 8),
                          _legendDot('AB+', const Color(0xFF1565C0)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: AppSpacing.md),
        // Row 2: Summary Table & Daily Trend
        LayoutBuilder(
          builder: (context, constraints) {
            final double cardWidth = constraints.maxWidth > 850
                ? (constraints.maxWidth - AppSpacing.md) / 2
                : constraints.maxWidth;

            final leftSide = Container(
              width: cardWidth,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Text(
                      '📋 Group-wise Stock Summary Matrix',
                      style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Table(
                    border: TableBorder.all(color: AppColors.border.withValues(alpha: 0.25), width: 0.5),
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(color: AppColors.background),
                        children: [
                          _buildCell('Blood Group', isHeader: true),
                          _buildCell('Total Collected', isHeader: true),
                          _buildCell('Available Now', isHeader: true),
                          _buildCell('Issued', isHeader: true),
                          _buildCell('Expired', isHeader: true),
                        ],
                      ),
                      _buildRow('A+', '65', '52', '12', '1'),
                      _buildRow('A-', '10', '8', '2', '0'),
                      _buildRow('B+', '80', '68', '11', '1'),
                      _buildRow('B-', '6', '5', '1', '0'),
                      _buildRow('O+', '92', '78', '13', '1'),
                      _buildRow('O-', '14', '12', '2', '0'),
                      _buildRow('AB+', '38', '34', '4', '0'),
                      _buildRow('AB-', '8', '7', '1', '0'),
                    ],
                  ),
                ],
              ),
            );

            final rightSide = Container(
              width: cardWidth,
              height: 312,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📈 DAILY DONATIONS vs ISSUES TREND',
                    style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.secondaryText),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Expanded(
                    child: CustomPaint(
                      painter: _BbTrendPainter(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _legendDot('Donations', const Color(0xFF880E4F)),
                      const SizedBox(width: 12),
                      _legendDot('Issues Issued', const Color(0xFFC62828)),
                    ],
                  ),
                ],
              ),
            );

            return Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                leftSide,
                rightSide,
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _legendDot(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
      ],
    );
  }

  Widget _buildCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 10 : 12,
          color: isHeader ? AppColors.secondaryText : AppColors.primaryText,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  TableRow _buildRow(String g, String c, String a, String i, String e) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(g, style: const TextStyle(color: Color(0xFFC62828), fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        ),
        _buildCell(c),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(a, style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        ),
        _buildCell(i),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(e, style: TextStyle(color: e == '0' ? AppColors.secondaryText : AppColors.error), textAlign: TextAlign.center),
        ),
      ],
    );
  }
}

class _BbMonthlyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.15)
      ..strokeWidth = 1.0;

    for (int i = 0; i < 5; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Collected: [180, 195, 210, 188, 225, 148] out of 250 max
    // Issued: [165, 178, 198, 174, 208, 132]
    final collected = [180.0, 195.0, 210.0, 188.0, 225.0, 148.0];
    final issued = [165.0, 178.0, 198.0, 174.0, 208.0, 132.0];

    final double groupSpacing = size.width / 6.0;
    final double barWidth = groupSpacing / 3.2;

    final paintColl = Paint()..color = const Color(0xFF880E4F);
    final paintIss = Paint()..color = const Color(0xFFC62828);

    for (int i = 0; i < 6; i++) {
      final double xStart = groupSpacing * i + groupSpacing / 6;

      // Draw Collected
      final double hC = size.height * (collected[i] / 250.0);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(xStart, size.height - hC, barWidth, hC),
          const Radius.circular(2),
        ),
        paintColl,
      );

      // Draw Issued
      final double hI = size.height * (issued[i] / 250.0);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(xStart + barWidth + 3, size.height - hI, barWidth, hI),
          const Radius.circular(2),
        ),
        paintIss,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BbDistributionPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Render a nice row of stacked horizontal progress lines to show volume ratio in a minimal premium style
    final items = [
      {'label': 'O+', 'val': 78, 'color': const Color(0xFFC62828)},
      {'label': 'B+', 'val': 68, 'color': const Color(0xFF880E4F)},
      {'label': 'A+', 'val': 52, 'color': const Color(0xFFE65100)},
      {'label': 'AB+', 'val': 34, 'color': const Color(0xFF1565C0)},
    ];

    final double rowHeight = size.height / 4.5;

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final double y = rowHeight * i + 8;
      
      // Label text
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${item['label']}: ${item['val']} units',
          style: const TextStyle(color: AppColors.primaryText, fontSize: 10.5, fontWeight: FontWeight.bold),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      
      textPainter.paint(canvas, Offset(0, y));

      // Bar background
      final barPaintBg = Paint()..color = AppColors.border.withValues(alpha: 0.1);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, y + 16, size.width, 6),
          const Radius.circular(3),
        ),
        barPaintBg,
      );

      // Bar fill
      final double fillWidth = size.width * ((item['val'] as int) / 90.0);
      final barPaintFill = Paint()..color = item['color'] as Color;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, y + 16, fillWidth, 6),
          const Radius.circular(3),
        ),
        barPaintFill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BbTrendPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.15)
      ..strokeWidth = 1.0;

    for (int i = 0; i < 5; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final donations = [8.0, 12.0, 10.0, 14.0, 11.0, 9.0, 12.0];
    final issues = [10.0, 14.0, 12.0, 11.0, 13.0, 10.0, 9.0];

    final double stepX = size.width / 6.5;

    _drawLine(canvas, size, donations, const Color(0xFF880E4F), stepX);
    _drawLine(canvas, size, issues, const Color(0xFFC62828), stepX);
  }

  void _drawLine(Canvas canvas, Size size, List<double> data, Color color, double stepX) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();

    for (int i = 0; i < data.length; i++) {
      final y = size.height * (1.0 - data[i] / 20.0);
      final x = stepX * i + stepX / 2.5;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);

    // Draw markers
    final paintDot = Paint()..style = PaintingStyle.fill;
    for (int i = 0; i < data.length; i++) {
      final y = size.height * (1.0 - data[i] / 20.0);
      final x = stepX * i + stepX / 2.5;

      paintDot.color = color;
      canvas.drawCircle(Offset(x, y), 3.5, paintDot);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
