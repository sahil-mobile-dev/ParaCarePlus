import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class HomeVitalsTrend extends ConsumerWidget {
  const HomeVitalsTrend({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildChartCard(
      title: 'Vitals Trend — Last 30 Days',
      icon: Icons.stacked_line_chart_rounded,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTrendMiniCard(
                'Systolic BP',
                '128 mmHg',
                '+4 this week',
                AppColors.error,
                true,
              ),
              _buildTrendMiniCard(
                'Blood Sugar',
                '142 mg/dL',
                '+8 this week',
                AppColors.secondaryAccent,
                true,
              ),
              _buildTrendMiniCard(
                'Heart Rate',
                '76 bpm',
                'Stable',
                Colors.orange,
                false,
              ),
            ],
          ),
          const SizedBox(height: 14),
          const SizedBox(height: 160, child: _CustomLineChartSimulator()),
        ],
      ),
    );
  }

  Widget _buildTrendMiniCard(
    String title,
    String val,
    String trend,
    Color color,
    bool isUp,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.02),
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 8,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              val,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Icon(
                  isUp ? Icons.arrow_upward : Icons.remove,
                  color: isUp ? AppColors.error : AppColors.success,
                  size: 8,
                ),
                const SizedBox(width: 2),
                Text(
                  trend,
                  style: TextStyle(
                    color: isUp ? AppColors.error : AppColors.success,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard({
    required String title,
    required IconData icon,
    required Widget child,
    Color color = AppColors.primaryLight,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
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
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _CustomLineChartSimulator extends StatelessWidget {
  const _CustomLineChartSimulator();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.infinite, painter: _SimulatedChartPainter());
  }
}

class _SimulatedChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final axisPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.5)
      ..strokeWidth = 0.5;

    // Grid lines
    for (var i = 0; i <= 4; i++) {
      final y = size.height * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), axisPaint);
    }

    final bpPaint = Paint()
      ..color = AppColors.error
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final sugarPaint = Paint()
      ..color = AppColors.secondaryAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final bpPath = Path();
    final sugarPath = Path();

    // Map points
    final bpPoints = [
      120,
      122,
      128,
      125,
      128,
      132,
      128,
      124,
      126,
      129,
      128,
      132,
      134,
      130,
      128,
    ];
    final sugarPoints = [
      110,
      130,
      142,
      135,
      140,
      145,
      142,
      138,
      140,
      144,
      142,
      146,
      148,
      143,
      142,
    ];

    final segmentWidth = size.width / (bpPoints.length - 1);

    for (var i = 0; i < bpPoints.length; i++) {
      final x = i * segmentWidth;
      final bpY = size.height - ((bpPoints[i] - 100) / 50) * size.height;
      final sugarY = size.height - ((sugarPoints[i] - 80) / 100) * size.height;

      if (i == 0) {
        bpPath.moveTo(x, bpY);
        sugarPath.moveTo(x, sugarY);
      } else {
        bpPath.lineTo(x, bpY);
        sugarPath.lineTo(x, sugarY);
      }
    }

    canvas
      ..drawPath(bpPath, bpPaint)
      ..drawPath(sugarPath, sugarPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
