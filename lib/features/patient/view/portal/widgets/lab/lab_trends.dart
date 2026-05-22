import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class LabTrends extends StatelessWidget {
  const LabTrends({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        var crossAxisCount = 1;
        if (width > 900) {
          crossAxisCount = 2;
        }

        return GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.6,
          ),
          children: [
            _buildTrendCard(
              title: 'Blood Glucose Trend (12 Months)',
              icon: Icons.opacity_rounded,
              child: const CustomGlucoseTrendChart(),
            ),
            _buildTrendCard(
              title: 'Cholesterol Trend (12 Months)',
              icon: Icons.biotech_rounded,
              child: const CustomCholesterolTrendChart(),
            ),
            _buildTrendCard(
              title: 'HbA1c Trend History',
              icon: Icons.trending_up_rounded,
              child: const CustomHbA1cTrendChart(),
            ),
            _buildTrendCard(
              title: 'CBC Key Parameters',
              icon: Icons.bar_chart_rounded,
              child: const CustomCbcTrendChart(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTrendCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
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
              Icon(icon, color: AppColors.primaryLight, size: 16),
              const SizedBox(width: 8),
              Text(title, style: AppTextStyles.labelLarge),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// 1. GLUCOSE TREND
class CustomGlucoseTrendChart extends StatelessWidget {
  const CustomGlucoseTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.infinite, painter: _GlucosePainter());
  }
}

class _GlucosePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final months = [
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
    final fasting = [
      118.0,
      122.0,
      128.0,
      132.0,
      130.0,
      136.0,
      138.0,
      140.0,
      138.0,
      142.0,
      140.0,
      142.0,
    ];
    final pp = [
      168.0,
      172.0,
      175.0,
      180.0,
      178.0,
      182.0,
      184.0,
      186.0,
      183.0,
      188.0,
      185.0,
      186.0,
    ];

    final len = fasting.length;
    final segmentWidth = size.width / (len - 1);

    const minVal = 100;
    const maxVal = 200;

    // Background horizontal lines
    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.5)
      ..strokeWidth = 0.5;
    for (var i = 0; i <= 3; i++) {
      final y = size.height * (i / 3);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw fasting glucose area & line
    final fastingPath = Path();
    final fastingArea = Path();
    for (var i = 0; i < len; i++) {
      final y =
          size.height -
          ((fasting[i] - minVal) / (maxVal - minVal)) * size.height;
      final x = i * segmentWidth;
      if (i == 0) {
        fastingPath.moveTo(x, y);
        fastingArea
          ..moveTo(x, size.height)
          ..lineTo(x, y);
      } else {
        fastingPath.lineTo(x, y);
        fastingArea.lineTo(x, y);
      }
      if (i == len - 1) {
        fastingArea
          ..lineTo(x, size.height)
          ..close();
      }
    }
    canvas
      ..drawPath(
        fastingArea,
        Paint()
          ..color = AppColors.secondaryAccent.withValues(alpha: 0.1)
          ..style = PaintingStyle.fill,
      )
      ..drawPath(
        fastingPath,
        Paint()
          ..color = AppColors.secondaryAccent
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke,
      );

    // Draw Post-Prandial line
    final ppPath = Path();
    for (var i = 0; i < len; i++) {
      final y =
          size.height - ((pp[i] - minVal) / (maxVal - minVal)) * size.height;
      final x = i * segmentWidth;
      if (i == 0) {
        ppPath.moveTo(x, y);
      } else {
        ppPath.lineTo(x, y);
      }
    }
    canvas.drawPath(
      ppPath,
      Paint()
        ..color = AppColors.error
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );

    // Draw text labels
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    for (var i = 0; i < len; i += 3) {
      final x = i * segmentWidth;
      textPainter
        ..text = TextSpan(
          text: months[i],
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 8),
        )
        ..layout()
        ..paint(
          canvas,
          Offset(x - textPainter.width / 2, size.height - 10),
        );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 2. CHOLESTEROL TREND
class CustomCholesterolTrendChart extends StatelessWidget {
  const CustomCholesterolTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.infinite, painter: _CholesterolPainter());
  }
}

class _CholesterolPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final total = [
      194.0,
      198.0,
      202.0,
      206.0,
      208.0,
      210.0,
      212.0,
      214.0,
      212.0,
      216.0,
      214.0,
      218.0,
    ];
    final ldl = [
      122.0,
      124.0,
      128.0,
      130.0,
      130.0,
      132.0,
      134.0,
      135.0,
      133.0,
      136.0,
      135.0,
      138.0,
    ];

    final len = total.length;
    final segmentWidth = size.width / (len - 1);

    const minVal = 80;
    const maxVal = 260;

    // Draw total cholesterol area & line
    final totalPath = Path();
    final totalArea = Path();
    for (var i = 0; i < len; i++) {
      final y =
          size.height - ((total[i] - minVal) / (maxVal - minVal)) * size.height;
      final x = i * segmentWidth;
      if (i == 0) {
        totalPath.moveTo(x, y);
        totalArea
          ..moveTo(x, size.height)
          ..lineTo(x, y);
      } else {
        totalPath.lineTo(x, y);
        totalArea.lineTo(x, y);
      }
      if (i == len - 1) {
        totalArea
          ..lineTo(x, size.height)
          ..close();
      }
    }
    canvas
      ..drawPath(
        totalArea,
        Paint()
          ..color = AppColors.error.withValues(alpha: 0.1)
          ..style = PaintingStyle.fill,
      )
      ..drawPath(
        totalPath,
        Paint()
          ..color = AppColors.error
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke,
      );

    // Draw LDL line
    final ldlPath = Path();
    for (var i = 0; i < len; i++) {
      final y =
          size.height - ((ldl[i] - minVal) / (maxVal - minVal)) * size.height;
      final x = i * segmentWidth;
      if (i == 0) {
        ldlPath.moveTo(x, y);
      } else {
        ldlPath.lineTo(x, y);
      }
    }
    canvas.drawPath(
      ldlPath,
      Paint()
        ..color = AppColors.secondaryAccent
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 3. HBA1C TREND
class CustomHbA1cTrendChart extends StatelessWidget {
  const CustomHbA1cTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.infinite, painter: _HbA1cPainter());
  }
}

class _HbA1cPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final values = [5.8, 5.9, 6.0, 6.2];
    final labels = ['Sep 2025', 'Dec 2025', 'Mar 2026', 'May 2026'];
    final colors = [
      AppColors.success,
      AppColors.secondaryAccent,
      AppColors.secondaryAccent,
      AppColors.error,
    ];

    final len = values.length;
    final barWidth = size.width / (len * 2);

    for (var i = 0; i < len; i++) {
      final x = i * (size.width / len) + barWidth / 2;
      // Map HbA1c (5.0 to 7.0) to coordinates
      final h = ((values[i] - 5.0) / 2.0) * size.height;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, size.height - h - 14, barWidth, h),
          const Radius.circular(4),
        ),
        Paint()..color = colors[i],
      );

      // Draw values text on top of bars
      final tp1 = TextPainter(
        text: TextSpan(
          text: '${values[i]}%',
          style: const TextStyle(
            color: AppColors.primaryText,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp1.paint(
        canvas,
        Offset(x + barWidth / 2 - tp1.width / 2, size.height - h - 26),
      );

      // Draw months labels
      final tp2 = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 8),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp2.paint(
        canvas,
        Offset(x + barWidth / 2 - tp2.width / 2, size.height - 10),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 4. CBC TREND
class CustomCbcTrendChart extends StatelessWidget {
  const CustomCbcTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.infinite, painter: _CbcPainter());
  }
}

class _CbcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final months = [
      'Mar 2025',
      'Jun 2025',
      'Sep 2025',
      'Dec 2025',
      'Mar 2026',
      'May 2026',
    ];
    final hb = [13.2, 13.5, 13.6, 13.7, 13.9, 13.8];
    final wbc = [6.8, 7.0, 7.1, 7.0, 7.3, 7.2];

    final len = months.length;
    final barWidth = size.width / (len * 3);

    for (var i = 0; i < len; i++) {
      final x = i * (size.width / len) + barWidth / 2;

      // Draw Hb bar (map 12 to 16)
      final hbH = ((hb[i] - 12.0) / 4.0) * size.height;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, size.height - hbH - 12, barWidth, hbH),
          const Radius.circular(2),
        ),
        Paint()..color = AppColors.error,
      );

      // Draw WBC bar (map 5 to 10)
      final wbcH = ((wbc[i] - 5.0) / 5.0) * size.height;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x + barWidth, size.height - wbcH - 12, barWidth, wbcH),
          const Radius.circular(2),
        ),
        Paint()..color = AppColors.primaryLight,
      );

      // Draw months labels
      final textPainter = TextPainter(textDirection: TextDirection.ltr);
      textPainter
        ..text = TextSpan(
          text: months[i].split(' ')[0], // just month name
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 8),
        )
        ..layout()
        ..paint(
          canvas,
          Offset(x + barWidth - textPainter.width / 2, size.height - 10),
        );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
