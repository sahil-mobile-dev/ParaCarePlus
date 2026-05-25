import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';

class FeedbackCharts extends StatelessWidget {
  const FeedbackCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ChartBox(
          title: 'Satisfaction Trend — 12 Months',
          icon: Icons.show_chart_rounded,
          iconColor: AppColors.secondaryAccent,
          child: SizedBox(
            height: 160,
            child: CustomPaint(
              painter: _SatisfactionTrendPainter(),
              child: Container(),
            ),
          ),
        ),
        const SizedBox(height: 14),
        const _ChartBox(
          title: 'Feedback Theme Word Cloud',
          icon: Icons.label_outline_rounded,
          iconColor: AppColors.primaryLight,
          child: SizedBox(height: 160, child: _WordCloud()),
        ),
        const SizedBox(height: 14),
        _ChartBox(
          title: 'NPS Distribution — All Visits',
          icon: Icons.bar_chart_rounded,
          iconColor: const Color(0xFFC77DFF),
          child: SizedBox(
            height: 160,
            child: CustomPaint(
              painter: _NpsDistributionPainter(),
              child: Container(),
            ),
          ),
        ),
      ],
    );
  }
}

class _ChartBox extends StatelessWidget {
  const _ChartBox({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 14),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

// ── Satisfaction Trend (Line Chart) ──
class _SatisfactionTrendPainter extends CustomPainter {
  static const _data = [
    4.1,
    4.2,
    4.0,
    4.3,
    4.4,
    4.3,
    4.5,
    4.4,
    4.6,
    4.3,
    4.7,
    4.6,
  ];
  static const _labels = [
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    const minV = 3.5;
    const maxV = 5.0;
    final chartH = size.height - 20;
    final chartW = size.width - 30;
    final stepX = chartW / (_data.length - 1);

    // Grid lines
    for (var i = 0; i <= 3; i++) {
      final y = 4.0 + i * (chartH / 3);
      canvas.drawLine(
        Offset(28, y),
        Offset(size.width, y),
        Paint()
          ..color = AppColors.border.withValues(alpha: 0.4)
          ..strokeWidth = 0.5,
      );
    }

    // Fill
    final fillPath = Path();
    fillPath.moveTo(28, size.height - 20);
    for (var i = 0; i < _data.length; i++) {
      final x = 28 + i * stepX;
      final norm = (_data[i] - minV) / (maxV - minV);
      final y = 4 + (1 - norm) * (chartH - 4);
      if (i == 0) {
        fillPath.moveTo(x, y);
      } else {
        final prevX = 28 + (i - 1) * stepX;
        final prevNorm = (_data[i - 1] - minV) / (maxV - minV);
        final prevY = 4 + (1 - prevNorm) * (chartH - 4);
        fillPath.cubicTo(prevX + stepX / 2, prevY, x - stepX / 2, y, x, y);
      }
    }
    fillPath
      ..lineTo(28 + (_data.length - 1) * stepX, size.height - 20)
      ..lineTo(28, size.height - 20)
      ..close();
    canvas.drawPath(
      fillPath,
      Paint()
        ..color = AppColors.secondaryAccent.withValues(alpha: 0.1)
        ..style = PaintingStyle.fill,
    );

    // Line
    final linePath = Path();
    for (var i = 0; i < _data.length; i++) {
      final x = 28 + i * stepX;
      final norm = (_data[i] - minV) / (maxV - minV);
      final y = 4 + (1 - norm) * (chartH - 4);
      if (i == 0) {
        linePath.moveTo(x, y);
      } else {
        final prevX = 28 + (i - 1) * stepX;
        final prevNorm = (_data[i - 1] - minV) / (maxV - minV);
        final prevY = 4 + (1 - prevNorm) * (chartH - 4);
        linePath.cubicTo(prevX + stepX / 2, prevY, x - stepX / 2, y, x, y);
      }
    }
    canvas.drawPath(
      linePath,
      Paint()
        ..color = AppColors.secondaryAccent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Points
    for (var i = 0; i < _data.length; i++) {
      final x = 28 + i * stepX;
      final norm = (_data[i] - minV) / (maxV - minV);
      final y = 4 + (1 - norm) * (chartH - 4);
      canvas
        ..drawCircle(
          Offset(x, y),
          3.5,
          Paint()..color = AppColors.secondaryAccent,
        )
        ..drawCircle(Offset(x, y), 2, Paint()..color = const Color(0xFF0C1F34));
    }

    // X labels (every 2)
    for (var i = 0; i < _labels.length; i += 2) {
      final x = 28 + i * stepX;
      final tp = TextPainter(
        text: TextSpan(
          text: _labels[i],
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 8),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, size.height - 14));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ── NPS Distribution (Bar Chart) ──
class _NpsDistributionPainter extends CustomPainter {
  static const _data = [0, 0, 1, 0, 1, 0, 0, 2, 3, 4, 7];

  static Color _colorForScore(int i) {
    if (i <= 6) return AppColors.error;
    if (i <= 8) return AppColors.secondaryAccent;
    return AppColors.success;
  }

  @override
  void paint(Canvas canvas, Size size) {
    const maxV = 7.0;
    final chartH = size.height - 20;
    final barW = (size.width - 16) / _data.length;

    for (var i = 0; i < _data.length; i++) {
      final x = 8 + i * barW;
      final h = (_data[i] / maxV) * (chartH - 8);
      final color = _colorForScore(i);

      if (h > 0) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x + barW * 0.1, chartH - h, barW * 0.8, h),
            const Radius.circular(3),
          ),
          Paint()..color = color.withValues(alpha: 0.85),
        );
      }

      final tp = TextPainter(
        text: TextSpan(
          text: '$i',
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 8),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x + barW / 2 - tp.width / 2, chartH + 4));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ── Word Cloud ──
class _WordCloud extends StatelessWidget {
  const _WordCloud();

  static const _words = [
    ('Caring doctor', 16, AppColors.success),
    ('Professional', 14, AppColors.primaryLight),
    ('Wait time', 13, AppColors.secondaryAccent),
    ('Clean', 12, AppColors.success),
    ('Digital system', 14, Color(0xFFC77DFF)),
    ('Helpful staff', 13, AppColors.primaryLight),
    ('Detailed', 12, Color(0xFF3A86FF)),
    ('Reassuring', 11, AppColors.success),
    ('Quick lab', 12, Color(0xFF0D9488)),
    ('ABHA', 11, Color(0xFFC77DFF)),
    ('Online reports', 12, AppColors.primaryLight),
    ('Friendly', 14, AppColors.success),
    ('Affordable', 10, Color(0xFF3A86FF)),
    ('Thorough', 13, AppColors.primaryLight),
    ('Long queue', 11, AppColors.error),
    ('Telemedicine', 12, Color(0xFF4361EE)),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 8,
        runSpacing: 6,
        alignment: WrapAlignment.center,
        children: _words.map((w) {
          return Text(
            w.$1,
            style: TextStyle(
              color: w.$3,
              fontSize: w.$2.toDouble(),
              fontWeight: w.$2 > 14 ? FontWeight.w700 : FontWeight.w500,
            ),
          );
        }).toList(),
      ),
    );
  }
}
