import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientHealthAnalyticsScreen extends ConsumerWidget {
  const PatientHealthAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientHealthAnalytics,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('Health Analytics'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: AppColors.primaryText),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMetricsSelector(),
            const SizedBox(height: AppSpacing.md),
            _buildChartCard(
              title: 'BP & Blood Sugar Trends (30 Days)',
              child: const CustomVitalsLineChart(),
            ),
            const SizedBox(height: AppSpacing.md),
            _buildRiskGrid(),
            const SizedBox(height: AppSpacing.md),
            _buildActivityRadarMock(),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsSelector() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ANALYTICS SUMMARY', style: AppTextStyles.labelSmall),
          SizedBox(height: 8),
          Text(
            'Your systolic blood pressure has elevated by 4% this month, trending concurrently with a rise in carbohydrate levels in your diet logs.',
            style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard({required String title, required Widget child}) {
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
          Text(title, style: AppTextStyles.labelLarge),
          const SizedBox(height: AppSpacing.md),
          SizedBox(height: 180, child: child),
          const SizedBox(height: AppSpacing.sm),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendItem(color: AppColors.error, label: 'Systolic BP'),
              SizedBox(width: 12),
              _LegendItem(color: AppColors.secondaryAccent, label: 'Sugar'),
              SizedBox(width: 12),
              _LegendItem(color: AppColors.primaryLight, label: 'Heart Rate'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRiskGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('HEALTH RISK PREDICTION', style: AppTextStyles.labelSmall),
        const SizedBox(height: AppSpacing.sm),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.sm,
          crossAxisSpacing: AppSpacing.sm,
          childAspectRatio: 1.6,
          children: [
            _buildRiskCard('Cardiovascular', 0.42, AppColors.error),
            _buildRiskCard('Type-2 Diabetes', 0.38, AppColors.secondaryAccent),
            _buildRiskCard('Kidney Disease', 0.18, AppColors.primaryLight),
            _buildRiskCard('Retinopathy', 0.22, AppColors.success),
          ],
        ),
      ],
    );
  }

  Widget _buildRiskCard(String name, double percentage, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: AppTextStyles.labelMedium.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: percentage,
                  color: color,
                  backgroundColor: AppColors.border,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${(percentage * 100).round()}%',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityRadarMock() {
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
          const Text(
            'METABOLIC PROFILE INDEX',
            style: AppTextStyles.labelLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildIndexItem('Physical Act.', '60%', AppColors.success),
              _buildIndexItem('Sleep Index', '55%', AppColors.primaryLight),
              _buildIndexItem('Nutritional', '45%', AppColors.secondaryAccent),
              _buildIndexItem('Medication', '88%', AppColors.success),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIndexItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }
}

class CustomVitalsLineChart extends StatelessWidget {
  const CustomVitalsLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.infinite, painter: _LineChartPainter());
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final axisPaint = Paint()
      ..color = AppColors.secondaryText.withValues(alpha: 0.3)
      ..strokeWidth = 0.5;

    // Draw background grid lines
    const gridLines = 5;
    for (var i = 0; i <= gridLines; i++) {
      final y = size.height * (i / gridLines);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), axisPaint);
    }

    // Draw Systolic BP line
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

    final bpPoints = [120.0, 122.0, 128.0, 125.0, 128.0, 132.0, 128.0];
    final sugarPoints = [110.0, 130.0, 142.0, 135.0, 140.0, 145.0, 142.0];

    final segmentWidth = size.width / (bpPoints.length - 1);

    for (var i = 0; i < bpPoints.length; i++) {
      // Map BP (100 to 160) to coordinates (size.height to 0)
      final bpY = size.height - ((bpPoints[i] - 100) / 60) * size.height;
      final sugarY = size.height - ((sugarPoints[i] - 80) / 100) * size.height;

      final x = i * segmentWidth;

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
