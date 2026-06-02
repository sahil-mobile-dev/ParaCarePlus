import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/radiology_imaging/view_model/radiology_imaging_view_model.dart';

class RadiologyAnalyticsTab extends ConsumerWidget {
  const RadiologyAnalyticsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(radiologyImagingProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        final analyticsContent = [
          // Left: Monthly Summary
          Expanded(
            flex: isWide ? 1 : 0,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.assessment_rounded, color: AppColors.primaryLight, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'MONTHLY OPERATIONS SUMMARY',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: AppColors.secondaryText,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowHeight: 34,
                      dataRowMinHeight: 34,
                      dataRowMaxHeight: 40,
                      horizontalMargin: 8,
                      columnSpacing: 16,
                      columns: const [
                        DataColumn(label: Text('Modality', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Orders', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Completed', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Avg TAT', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Revenue', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                      ],
                      rows: state.analytics.map((row) {
                        return DataRow(
                          cells: [
                            DataCell(Text(row.modality, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))),
                            DataCell(Text(row.orders.toString(), style: const TextStyle(color: Colors.white70, fontSize: 11))),
                            DataCell(Text(row.completed.toString(), style: const TextStyle(color: Colors.white70, fontSize: 11))),
                            DataCell(Text(row.avgTat, style: const TextStyle(color: AppColors.secondaryAccent, fontSize: 11, fontWeight: FontWeight.bold))),
                            DataCell(Text(row.revenue, style: const TextStyle(color: AppColors.success, fontSize: 11, fontWeight: FontWeight.bold))),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isWide) const SizedBox(width: 14) else const SizedBox(height: 14),
          // Right: Bar chart (exams today)
          Expanded(
            flex: isWide ? 1 : 0,
            child: Container(
              height: 240,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DAILY EXAMS BY MODALITY',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: AppColors.secondaryText,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Expanded(
                    child: CustomPaint(
                      size: const Size(double.infinity, 160),
                      painter: _DailyExamsPainter(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ];

        return isWide
            ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: analyticsContent)
            : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: analyticsContent);
      },
    );
  }
}

class _DailyExamsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.15)
      ..strokeWidth = 1.0;

    for (var i = 0; i < 5; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Labels: ['X-Ray', 'CT Scan', 'MRI', 'USG']
    final counts = [18.0, 8.0, 5.0, 14.0];

    final numBars = counts.length;
    final barSpacing = size.width / numBars;
    final barWidth = barSpacing * 0.4;

    final barPaint = Paint()..color = AppColors.primaryLight;

    for (var i = 0; i < numBars; i++) {
      final val = counts[i];
      final height = size.height * (val / 20); // max scale 20
      final x = i * barSpacing + (barSpacing - barWidth) / 2;

      final rect = Rect.fromLTWH(x, size.height - height, barWidth, height);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(2)), barPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
