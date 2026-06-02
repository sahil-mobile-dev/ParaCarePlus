import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class TatAnalyticsTab extends StatelessWidget {
  const TatAnalyticsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Charts Grid
        LayoutBuilder(
          builder: (context, constraints) {
            final double cardWidth = constraints.maxWidth > 850
                ? (constraints.maxWidth - AppSpacing.md) / 2
                : constraints.maxWidth;

            return Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                // TAT by Department Bar Chart
                Container(
                  width: cardWidth,
                  height: 300,
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
                        '⏱️ AVG TAT BY DEPARTMENT (HOURS)',
                        style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.secondaryText),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Expanded(
                        child: Row(
                          children: [
                            // Y-axis ticks
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('48h', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                                Text('24h', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                                Text('12h', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                                Text('6h', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                                Text('0h', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: CustomPaint(
                                painter: _DeptTatPainter(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text('Haem', style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                          Text('Biochem', style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                          Text('Micro', style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                          Text('Sero', style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                          Text('Endo', style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                        ],
                      ),
                    ],
                  ),
                ),
                // Daily Test Volume Line Chart
                Container(
                  width: cardWidth,
                  height: 300,
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
                        '📊 DAILY TEST VOLUME (COMPLETED)',
                        style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.secondaryText),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Expanded(
                        child: Row(
                          children: [
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('200', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                                Text('150', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                                Text('100', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                                Text('50', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                                Text('0', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: CustomPaint(
                                painter: _DailyVolumePainter(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text('Mon', style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                          Text('Tue', style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                          Text('Wed', style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                          Text('Thu', style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                          Text('Fri', style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                          Text('Sat', style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                          Text('Sun', style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        // Analyzer Performance Table
        Container(
          width: double.infinity,
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
                  '🔬 ANALYZER INSTRUMENTS PERFORMANCE',
                  style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.secondaryText),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(AppColors.border.withValues(alpha: 0.15)),
                    columns: const [
                      DataColumn(label: Text('Analyzer Instrument', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Uptime %', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Samples Today', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Error Rate', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Calibration', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: [
                      _buildPerfRow('Sysmex XN-550 (Hematology)', '99.2%', '82', '0.4%', 'Daily Calibrated ✅', 'online'),
                      _buildPerfRow('Roche Cobas c311 (Chemistry)', '98.5%', '125', '0.8%', 'Daily Calibrated ✅', 'online'),
                      _buildPerfRow('BioMerieux VITEK2 (Microbiology)', '95.0%', '8', '1.2%', 'Weekly Calibrated ✅', 'online'),
                      _buildPerfRow('Bio-Rad D-100 (HbA1c)', '72.0%', '0', '—', 'Overdue ⚠️', 'maintenance'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  DataRow _buildPerfRow(
    String name,
    String uptime,
    String samples,
    String error,
    String calib,
    String status,
  ) {
    final isOnline = status == 'online';
    return DataRow(
      cells: [
        DataCell(Text(name, style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(uptime)),
        DataCell(Text(samples)),
        DataCell(Text(error)),
        DataCell(Text(calib)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: (isOnline ? AppColors.success : AppColors.secondaryAccent).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              isOnline ? 'ONLINE' : 'MAINTENANCE',
              style: TextStyle(
                color: isOnline ? AppColors.success : AppColors.secondaryAccent,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DeptTatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.15)
      ..strokeWidth = 1.0;

    // Draw horizontal grid lines
    for (int i = 0; i < 5; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Heights representing values [2.5, 4.8, 48.0, 6.0, 8.0] out of 48 max
    final values = [2.5, 4.8, 48.0, 6.0, 8.0];
    final colors = [
      const Color(0xFF1565C0),
      const Color(0xFF00897B),
      AppColors.error,
      const Color(0xFF7B1FA2),
      const Color(0xFFF57C00),
    ];

    final double barWidth = size.width / 11;
    final double spacing = size.width / 5.5;

    for (int i = 0; i < values.length; i++) {
      final val = values[i];
      final double barHeight = size.height * (val / 48.0);
      final double x = spacing * i + spacing / 3;
      final double y = size.height - barHeight;

      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, barWidth, barHeight),
          const Radius.circular(4),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DailyVolumePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.15)
      ..strokeWidth = 1.0;

    for (int i = 0; i < 5; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Values: [142, 168, 135, 195, 156, 148, 160] out of 200 max
    final data = [142.0, 168.0, 135.0, 195.0, 156.0, 148.0, 160.0];

    final paintLine = Paint()
      ..color = const Color(0xFF1565C0)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paintFill = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [const Color(0xFF1565C0).withValues(alpha: 0.3), Colors.transparent],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();
    final stepX = size.width / 6.5;

    for (int i = 0; i < data.length; i++) {
      final val = data[i];
      final y = size.height * (1.0 - val / 200.0);
      final x = stepX * i + stepX / 2.5;

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }

      if (i == data.length - 1) {
        fillPath.lineTo(x, size.height);
      }
    }

    canvas.drawPath(fillPath, paintFill);
    canvas.drawPath(path, paintLine);

    // Draw dots
    final paintDot = Paint()..style = PaintingStyle.fill;
    for (int i = 0; i < data.length; i++) {
      final val = data[i];
      final y = size.height * (1.0 - val / 200.0);
      final x = stepX * i + stepX / 2.5;

      paintDot.color = const Color(0xFF1565C0);
      canvas.drawCircle(Offset(x, y), 4.5, paintDot);
      paintDot.color = Colors.white;
      canvas.drawCircle(Offset(x, y), 2.0, paintDot);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
