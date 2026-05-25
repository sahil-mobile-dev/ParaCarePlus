import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class ExpenditureFlowSankeySunburst extends StatelessWidget {
  const ExpenditureFlowSankeySunburst({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth > 900;

        final components = [
          _buildChartCard(
            title: 'Health Expenditure Sankey Flow (FY 2025-26)',
            icon: Icons.account_tree_rounded,
            child: SizedBox(
              height: 320,
              child: CustomPaint(
                painter: SankeyFlowPainter(),
                child: Container(),
              ),
            ),
          ),
          _buildChartCard(
            title: 'Insurance Coverage Sunburst',
            icon: Icons.donut_large_rounded,
            child: SizedBox(
              height: 320,
              child: CustomPaint(
                painter: SunburstChartPainter(),
                child: Container(),
              ),
            ),
          ),
        ];

        if (isLargeScreen) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: components[0]),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: components[1]),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              components[0],
              const SizedBox(height: AppSpacing.md),
              components[1],
            ],
          );
        }
      },
    );
  }

  Widget _buildChartCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF00C897), size: 14),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class SankeyFlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Node details
    // Column positions
    final x1 = w * 0.12;
    final x2 = w * 0.50;
    final x3 = w * 0.88;
    const nodeWidth = 24.0;
    const gap = 12.0;

    // Node values
    const totalVal = 120000.0;

    // Column 1 heights
    final c1Available = h - 40;
    final hTotalSpend = c1Available;
    const yTotalSpend = 20.0;

    // Column 2 heights
    const c2Gaps = 2 * gap;
    final c2Available = h - 40 - c2Gaps;
    final hPmjay = (65000 / totalVal) * c2Available;
    final hCghs = (42000 / totalVal) * c2Available;
    final hOop = (13000 / totalVal) * c2Available;

    const yPmjay = 20.0;
    final yCghs = yPmjay + hPmjay + gap;
    final yOop = yCghs + hCghs + gap;

    // Column 3 heights
    const c3Gaps = 4 * gap;
    final c3Available = h - 40 - c3Gaps;
    final hConsult = (36000 / totalVal) * c3Available;
    final hLabs = (38000 / totalVal) * c3Available;
    final hRad = (15000 / totalVal) * c3Available;
    final hMeds = (23000 / totalVal) * c3Available;
    final hProc = (8000 / totalVal) * c3Available;

    const yConsult = 20.0;
    final yLabs = yConsult + hConsult + gap;
    final yRad = yLabs + hLabs + gap;
    final yMeds = yRad + hRad + gap;
    final yProc = yMeds + hMeds + gap;

    // Keep track of offsets for drawing curves
    const c1OutPmjay = yTotalSpend;
    final c1OutCghs = yTotalSpend + (65000 / totalVal) * hTotalSpend;
    final c1OutOop = c1OutCghs + (42000 / totalVal) * hTotalSpend;

    const pmjayIn = yPmjay;
    final cghsIn = yCghs;
    final oopIn = yOop;

    // Draw Column 1 -> 2 flows
    _drawSankeyLink(
      canvas,
      x1 + nodeWidth,
      c1OutPmjay,
      (65000 / totalVal) * hTotalSpend,
      x2,
      pmjayIn,
      hPmjay,
      const Color(0xFF3A86FF),
    );
    _drawSankeyLink(
      canvas,
      x1 + nodeWidth,
      c1OutCghs,
      (42000 / totalVal) * hTotalSpend,
      x2,
      cghsIn,
      hCghs,
      const Color(0xFF00C897),
    );
    _drawSankeyLink(
      canvas,
      x1 + nodeWidth,
      c1OutOop,
      (13000 / totalVal) * hTotalSpend,
      x2,
      oopIn,
      hOop,
      const Color(0xFFFFD166),
    );

    // Column 2 -> 3 details & offsets
    const pmjayOutConsult = yPmjay;
    final pmjayOutLabs = yPmjay + (22000 / 65000) * hPmjay;
    final pmjayOutRad = pmjayOutLabs + (28000 / 65000) * hPmjay;

    final cghsOutMeds = yCghs;
    final cghsOutConsult = yCghs + (18000 / 42000) * hCghs;
    final cghsOutLabs = cghsOutConsult + (14000 / 42000) * hCghs;

    final oopOutProc = yOop;
    final oopOutMeds = yOop + (8000 / 13000) * hOop;

    const consultInPmjay = yConsult;
    final consultInCghs = yConsult + (22000 / 36000) * hConsult;

    final labsInPmjay = yLabs;
    final labsInCghs = yLabs + (28000 / 38000) * hLabs;

    final radInPmjay = yRad;

    final medsInCghs = yMeds;
    final medsInOop = yMeds + (18000 / 23000) * hMeds;

    final procInOop = yProc;

    // Draw Column 2 -> 3 flows
    // From PMJAY
    _drawSankeyLink(
      canvas,
      x2 + nodeWidth,
      pmjayOutConsult,
      (22000 / 65000) * hPmjay,
      x3,
      consultInPmjay,
      (22000 / 36000) * hConsult,
      const Color(0xFF3A86FF),
    );
    _drawSankeyLink(
      canvas,
      x2 + nodeWidth,
      pmjayOutLabs,
      (28000 / 65000) * hPmjay,
      x3,
      labsInPmjay,
      (28000 / 38000) * hLabs,
      const Color(0xFF3A86FF),
    );
    _drawSankeyLink(
      canvas,
      x2 + nodeWidth,
      pmjayOutRad,
      (15000 / 65000) * hPmjay,
      x3,
      radInPmjay,
      hRad,
      const Color(0xFF3A86FF),
    );

    // From CGHS
    _drawSankeyLink(
      canvas,
      x2 + nodeWidth,
      cghsOutMeds,
      (18000 / 42000) * hCghs,
      x3,
      medsInCghs,
      (18000 / 23000) * hMeds,
      const Color(0xFF00C897),
    );
    _drawSankeyLink(
      canvas,
      x2 + nodeWidth,
      cghsOutConsult,
      (14000 / 42000) * hCghs,
      x3,
      consultInCghs,
      (14000 / 36000) * hConsult,
      const Color(0xFF00C897),
    );
    _drawSankeyLink(
      canvas,
      x2 + nodeWidth,
      cghsOutLabs,
      (10000 / 42000) * hCghs,
      x3,
      labsInCghs,
      (10000 / 38000) * hLabs,
      const Color(0xFF00C897),
    );

    // From OOP
    _drawSankeyLink(
      canvas,
      x2 + nodeWidth,
      oopOutProc,
      (8000 / 13000) * hOop,
      x3,
      procInOop,
      hProc,
      const Color(0xFFFFD166),
    );
    _drawSankeyLink(
      canvas,
      x2 + nodeWidth,
      oopOutMeds,
      (5000 / 13000) * hOop,
      x3,
      medsInOop,
      (5000 / 23000) * hMeds,
      const Color(0xFFFFD166),
    );

    // Draw Column 1 Nodes
    _drawSankeyNode(
      canvas,
      x1,
      yTotalSpend,
      nodeWidth,
      hTotalSpend,
      'Total Spend\n₹1.2L',
      Colors.grey[400]!,
      alignLeft: true,
    );

    // Draw Column 2 Nodes
    _drawSankeyNode(
      canvas,
      x2,
      yPmjay,
      nodeWidth,
      hPmjay,
      'AB-PMJAY',
      const Color(0xFF3A86FF),
    );
    _drawSankeyNode(
      canvas,
      x2,
      yCghs,
      nodeWidth,
      hCghs,
      'CGHS',
      const Color(0xFF00C897),
    );
    _drawSankeyNode(
      canvas,
      x2,
      yOop,
      nodeWidth,
      hOop,
      'OOP',
      const Color(0xFFFFD166),
    );

    // Draw Column 3 Nodes
    _drawSankeyNode(
      canvas,
      x3,
      yConsult,
      nodeWidth,
      hConsult,
      'Consultations',
      const Color(0xFFEF4444),
      alignLeft: false,
    );
    _drawSankeyNode(
      canvas,
      x3,
      yLabs,
      nodeWidth,
      hLabs,
      'Lab Tests',
      const Color(0xFF0D9488),
      alignLeft: false,
    );
    _drawSankeyNode(
      canvas,
      x3,
      yRad,
      nodeWidth,
      hRad,
      'Radiology',
      const Color(0xFFC77DFF),
      alignLeft: false,
    );
    _drawSankeyNode(
      canvas,
      x3,
      yMeds,
      nodeWidth,
      hMeds,
      'Medicines',
      const Color(0xFFFFD166),
      alignLeft: false,
    );
    _drawSankeyNode(
      canvas,
      x3,
      yProc,
      nodeWidth,
      hProc,
      'Procedures',
      const Color(0xFFF77F00),
      alignLeft: false,
    );
  }

  void _drawSankeyNode(
    Canvas canvas,
    double x,
    double y,
    double w,
    double h,
    String label,
    Color color, {
    bool? alignLeft,
  }) {
    // Node rectangle
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, w, h),
        const Radius.circular(4),
      ),
      Paint()..color = color,
    );

    // Label Text
    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8.5,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    double textX;
    if (alignLeft ?? false) {
      textX = x - textPainter.width - 6;
    } else if (alignLeft == false) {
      textX = x + w + 6;
    } else {
      textX = x + (w - textPainter.width) / 2;
    }
    final textY = y + (h - textPainter.height) / 2;

    // Background overlay for readability if centered
    if (alignLeft == null) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            textX - 3,
            textY - 1,
            textPainter.width + 6,
            textPainter.height + 2,
          ),
          const Radius.circular(4),
        ),
        Paint()..color = Colors.black.withValues(alpha: 0.6),
      );
    }

    textPainter.paint(canvas, Offset(textX, textY));
  }

  void _drawSankeyLink(
    Canvas canvas,
    double xSource,
    double ySource,
    double hSource,
    double xTarget,
    double yTarget,
    double hTarget,
    Color color,
  ) {
    final path = Path()
      ..moveTo(xSource, ySource)
      ..cubicTo(
        xSource + (xTarget - xSource) / 2,
        ySource,
        xSource + (xTarget - xSource) / 2,
        yTarget,
        xTarget,
        yTarget,
      )
      ..lineTo(xTarget, yTarget + hTarget)
      ..cubicTo(
        xSource + (xTarget - xSource) / 2,
        yTarget + hTarget,
        xSource + (xTarget - xSource) / 2,
        ySource + hSource,
        xSource,
        ySource + hSource,
      )
      ..close();

    canvas.drawPath(
      path,
      Paint()
        ..color = color.withValues(alpha: 0.3)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SunburstChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Total coverage limit = 1,700k
    const totalVal = 1700000.0;

    // Draw outer segments first so inner segments clip clean
    // Outer segments details:
    // Sector 1: PMJAY (500k, 0 to 105.8 deg)
    // - IPD: 300k
    // - OPD: 150k
    // - Diagnostics: 50k
    _drawSunburstArc(
      canvas,
      center,
      72,
      102,
      0,
      300000 / totalVal,
      const Color(0xFF1E3A8A),
      'IPD (300k)',
    );
    _drawSunburstArc(
      canvas,
      center,
      72,
      102,
      300000 / totalVal,
      450000 / totalVal,
      const Color(0xFF2563EB),
      'OPD (150k)',
    );
    _drawSunburstArc(
      canvas,
      center,
      72,
      102,
      450000 / totalVal,
      500000 / totalVal,
      const Color(0xFF0284C7),
      'Diag (50k)',
    );

    // Sector 2: CGHS (200k, 105.8 to 148.2 deg)
    // - OPD: 100k
    // - Meds: 60k
    // - IPD: 40k
    const cghsStart = 500000 / totalVal;
    _drawSunburstArc(
      canvas,
      center,
      72,
      102,
      cghsStart,
      cghsStart + 100000 / totalVal,
      const Color(0xFF047857),
      'OPD (100k)',
    );
    _drawSunburstArc(
      canvas,
      center,
      72,
      102,
      cghsStart + 100000 / totalVal,
      cghsStart + 160000 / totalVal,
      const Color(0xFF059669),
      'Meds (60k)',
    );
    _drawSunburstArc(
      canvas,
      center,
      72,
      102,
      cghsStart + 160000 / totalVal,
      cghsStart + 200000 / totalVal,
      const Color(0xFF0D9488),
      'IPD (40k)',
    );

    // Sector 3: Star Health (1000k, 148.2 to 360 deg)
    // - Major Surgery: 800k
    // - Critical Care: 200k
    const starStart = 700000 / totalVal;
    _drawSunburstArc(
      canvas,
      center,
      72,
      102,
      starStart,
      starStart + 800000 / totalVal,
      const Color(0xFFB45309),
      'Surgery (800k)',
    );
    _drawSunburstArc(
      canvas,
      center,
      72,
      102,
      starStart + 800000 / totalVal,
      1,
      const Color(0xFFD97706),
      'ICU (200k)',
    );

    // Inner parent rings
    _drawSunburstArc(
      canvas,
      center,
      40,
      68,
      0,
      500000 / totalVal,
      const Color(0xFF3A86FF),
      'AB-PMJAY',
    );
    _drawSunburstArc(
      canvas,
      center,
      40,
      68,
      500000 / totalVal,
      700000 / totalVal,
      const Color(0xFF00C897),
      'CGHS',
    );
    _drawSunburstArc(
      canvas,
      center,
      40,
      68,
      700000 / totalVal,
      1,
      const Color(0xFFFFD166),
      'Star Health',
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 8,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _drawSunburstArc(
    Canvas canvas,
    Offset center,
    double innerRadius,
    double outerRadius,
    double startFraction,
    double endFraction,
    Color color,
    String label, {
    TextStyle? textStyle,
  }) {
    final startAngle = startFraction * 2 * pi - pi / 2;
    final sweepAngle = (endFraction - startFraction) * 2 * pi;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = outerRadius - innerRadius;

    final midRadius = (innerRadius + outerRadius) / 2;

    // Draw arc stroke
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: midRadius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );

    // Separator line
    final separatorPaint = Paint()
      ..color = AppColors.background
      ..strokeWidth = 1.5;

    final xStart = center.dx + innerRadius * cos(startAngle);
    final yStart = center.dy + innerRadius * sin(startAngle);
    final xEnd = center.dx + (outerRadius + 2) * cos(startAngle);
    final yEnd = center.dy + (outerRadius + 2) * sin(startAngle);
    canvas.drawLine(Offset(xStart, yStart), Offset(xEnd, yEnd), separatorPaint);

    // Text Label placed along the center of the arc sweep
    final midAngle = startAngle + sweepAngle / 2;
    final labelRadius = midRadius;
    final textX = center.dx + labelRadius * cos(midAngle);
    final textY = center.dy + labelRadius * sin(midAngle);

    // Skip label printing for very small segments
    if (sweepAngle > 0.08) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: label,
          style:
              textStyle ??
              const TextStyle(
                color: Colors.white,
                fontSize: 7.5,
                fontWeight: FontWeight.bold,
              ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      canvas.save();
      canvas.translate(textX, textY);

      // Rotate label to align outwards or flat
      var rotation = midAngle;
      if (rotation > pi / 2 && rotation < 1.5 * pi) {
        rotation += pi; // Keep text readable upside down
      }
      canvas.rotate(rotation);

      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
