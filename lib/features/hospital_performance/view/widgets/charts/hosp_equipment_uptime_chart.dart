import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class HospEquipmentUptimeChart extends StatelessWidget {
  const HospEquipmentUptimeChart({super.key});

  @override
  Widget build(BuildContext context) {
    final equipment = [
      {'name': 'CT Scanner', 'val': 84, 'color': AppColors.primaryLight},
      {'name': 'MRI Machine', 'val': 78, 'color': AppColors.error},
      {'name': 'Haemodialysis', 'val': 91, 'color': AppColors.success},
      {'name': 'Ventilators', 'val': 63, 'color': AppColors.secondaryAccent},
      {'name': 'Operation Theatre', 'val': 78, 'color': AppColors.primaryLight},
      {'name': 'Mammography', 'val': 65, 'color': Colors.pinkAccent},
      {'name': 'Endoscopy', 'val': 72, 'color': AppColors.success},
      {'name': 'Echocardiography', 'val': 88, 'color': AppColors.primaryLight},
      {'name': 'X-Ray Digital', 'val': 92, 'color': AppColors.success},
      {'name': 'Ultrasound', 'val': 87, 'color': AppColors.primaryLight},
    ];

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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Critical Equipment Utilisation % — All Facilities',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Utilisation rates vs Target 80% (dotted)',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: Stack(
              children: [
                // Target Line Overlay
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final targetX = constraints.maxWidth * 0.8;
                      return CustomPaint(
                        painter: _TargetLinePainter(targetX: targetX),
                      );
                    },
                  ),
                ),
                // Equipment List
                ListView.separated(
                  itemCount: equipment.length,
                  separatorBuilder: (context, idx) => const SizedBox(height: 6),
                  itemBuilder: (context, idx) {
                    final item = equipment[idx];
                    final name = item['name'] as String;
                    final val = item['val'] as int;
                    final color = item['color'] as Color;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 10.5,
                              ),
                            ),
                            Text(
                              '$val%',
                              style: TextStyle(
                                color: color,
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: SizedBox(
                            height: 6,
                            child: LinearProgressIndicator(
                              value: val / 100.0,
                              backgroundColor: Colors.white.withValues(
                                alpha: 0.05,
                              ),
                              valueColor: AlwaysStoppedAnimation<Color>(color),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TargetLinePainter extends CustomPainter {
  _TargetLinePainter({required this.targetX});
  final double targetX;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.secondaryAccent.withValues(alpha: 0.6)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Draw dashed vertical line at targetX
    const dashHeight = 5;
    const dashSpace = 4;
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(targetX, startY),
        Offset(targetX, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
