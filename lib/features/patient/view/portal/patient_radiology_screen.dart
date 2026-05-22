import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientRadiologyScreen extends ConsumerWidget {
  const PatientRadiologyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientRadiology,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('Radiology Locker'),
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
            _buildXrayViewer(),
            const SizedBox(height: AppSpacing.md),
            _buildDicomDetails(),
            const SizedBox(height: AppSpacing.md),
            _buildAiAnalysisPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildXrayViewer() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'PACS Chest X-Ray — PA View',
                style: AppTextStyles.labelLarge,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                ),
                child: const Text(
                  'COMPLETED',
                  style: TextStyle(
                    color: AppColors.success,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Interactive X-Ray image simulator using custom painting (high-res chest silhouette)
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(color: AppColors.border),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.sm),
              child: CustomPaint(
                size: Size.infinite,
                painter: _ChestXraySimulatorPainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDicomDetails() {
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
          Text('DICOM METADATA Locker', style: AppTextStyles.labelSmall),
          SizedBox(height: AppSpacing.md),
          _DicomRow(label: 'Modality', value: 'CR (Computed Radiography)'),
          _DicomRow(label: 'Manufacturer', value: 'GE Healthcare PACS v3'),
          _DicomRow(label: 'Body Part', value: 'Chest PA'),
          _DicomRow(label: 'Dose', value: '0.02 mSv (Low Exposure)'),
          _DicomRow(label: 'Acquisition Date', value: '01 May 2026 · 10:15 AM'),
        ],
      ),
    );
  }

  Widget _buildAiAnalysisPanel() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: AppColors.primaryLight.withValues(alpha: 0.2),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.smart_toy_rounded, color: AppColors.primaryLight),
              SizedBox(width: 8),
              Text(
                'AI Automated Report Analysis',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Lungs are clear bilaterally. No focal consolidations, pleural effusion or pneumothorax identified. Cardiomediastinal contour is within normal limits. Bony thorax is intact.',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 12,
              height: 1.4,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'AI Diagnostic Confidence: 99.4%',
            style: TextStyle(
              color: AppColors.success,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _DicomRow extends StatelessWidget {
  const _DicomRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodySmall),
          Text(
            value,
            style: AppTextStyles.labelMedium.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _ChestXraySimulatorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final lungPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    // Draw Spine
    final spinePath = Path()
      ..moveTo(size.width / 2, 10)
      ..lineTo(size.width / 2, size.height - 10);
    canvas.drawPath(spinePath, paint);

    // Draw Rib cages
    for (var i = 0; i < 8; i++) {
      final y = 40.0 + (i * 20.0);
      final leftRib = Path()
        ..moveTo(size.width / 2, y)
        ..quadraticBezierTo(
          size.width * 0.1,
          y + 10,
          size.width * 0.15,
          y + 15,
        );
      canvas.drawPath(leftRib, paint);

      final rightRib = Path()
        ..moveTo(size.width / 2, y)
        ..quadraticBezierTo(
          size.width * 0.9,
          y + 10,
          size.width * 0.85,
          y + 15,
        );
      canvas.drawPath(rightRib, paint);
    }

    // Draw Lung structures
    final leftLung = Rect.fromLTWH(
      size.width * 0.2,
      40,
      size.width * 0.22,
      size.height - 80,
    );
    final rightLung = Rect.fromLTWH(
      size.width * 0.58,
      40,
      size.width * 0.22,
      size.height - 80,
    );
    canvas
      ..drawOval(leftLung, lungPaint)
      ..drawOval(rightLung, lungPaint);

    // Heart silhouette
    final heartPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;
    final heartPath = Path()
      ..moveTo(size.width / 2 - 10, size.height / 2 + 10)
      ..quadraticBezierTo(
        size.width * 0.35,
        size.height * 0.65,
        size.width / 2,
        size.height * 0.7,
      )
      ..quadraticBezierTo(
        size.width * 0.6,
        size.height * 0.6,
        size.width / 2 - 10,
        size.height / 2 + 10,
      );
    canvas.drawPath(heartPath, heartPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
