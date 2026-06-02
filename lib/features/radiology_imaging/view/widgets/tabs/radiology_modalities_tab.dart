import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/radiology_imaging/view_model/radiology_imaging_view_model.dart';

class RadiologyModalitiesTab extends ConsumerWidget {
  const RadiologyModalitiesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(radiologyImagingProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Grid of modalities status
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth > 900 ? 5 : (constraints.maxWidth > 600 ? 3 : 2);

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.5,
              ),
              itemCount: state.modalities.length,
              itemBuilder: (context, index) {
                final m = state.modalities[index];
                final utilPct = '${m.util}%';

                var barColor = AppColors.success;
                if (m.util >= 85) {
                  barColor = AppColors.error;
                } else if (m.util >= 70) {
                  barColor = AppColors.secondaryAccent;
                }

                return Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              m.name,
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.settings_remote_rounded, size: 14, color: AppColors.primaryLight),
                        ],
                      ),
                      Text(
                        m.location,
                        style: const TextStyle(color: AppColors.secondaryText, fontSize: 9.5),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: m.util / 100,
                          minHeight: 5,
                          backgroundColor: Colors.white.withValues(alpha: 0.07),
                          valueColor: AlwaysStoppedAnimation<Color>(barColor),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Today: ${m.today}', style: const TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
                          Text(utilPct, style: TextStyle(color: barColor, fontSize: 9.5, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        // Utilisation Trend Chart
        Container(
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
                'MODALITY UTILISATION TREND — TODAY',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: AppColors.secondaryText,
                  fontFamily: AppTextStyles.fontFamily,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 200,
                child: CustomPaint(
                  size: const Size(double.infinity, 200),
                  painter: _UtilisationPainter(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UtilisationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw background grid lines
    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.15)
      ..strokeWidth = 1.0;

    for (var i = 0; i < 5; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw active curves
    final ctUtil = [40, 50, 45, 60, 75, 80, 85, 78, 60, 55, 65, 70];
    final mriUtil = [30, 40, 35, 45, 55, 62, 70, 68, 50, 45, 50, 55];

    _drawPath(canvas, size, ctUtil, const Color(0xFFFFD166));
    _drawPath(canvas, size, mriUtil, const Color(0xFFC77DFF));
  }

  void _drawPath(Canvas canvas, Size size, List<int> data, Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    final stepX = size.width / (data.length - 1);

    for (var i = 0; i < data.length; i++) {
      final val = data[i].toDouble();
      final y = size.height * (1.0 - val / 100);
      final x = i * stepX;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
