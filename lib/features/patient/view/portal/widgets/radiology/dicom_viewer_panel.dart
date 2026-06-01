import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

final activeScanIndexProvider = StateProvider<int>((ref) => 0);
final activeToolProvider = StateProvider<String>((ref) => 'W/L');
final imageInvertedProvider = StateProvider<bool>((ref) => false);

class ScanData {
  const ScanData({
    required this.title,
    required this.date,
    required this.subtitle,
    required this.modality,
    required this.bodyPart,
    required this.radiologist,
    required this.institution,
    required this.accessionNo,
    required this.dob,
    required this.ref,
    required this.technicalData,
    required this.wwWl,
    required this.notes,
    required this.aiFindings,
  });
  final String title;
  final String date;
  final String subtitle;
  final String modality;
  final String bodyPart;
  final String radiologist;
  final String institution;
  final String accessionNo;
  final String dob;
  final String ref;
  final String technicalData;
  final String wwWl;
  final String notes;
  final List<Map<String, dynamic>> aiFindings;
}

class DicomViewerPanel extends ConsumerWidget {
  const DicomViewerPanel({super.key});

  static final List<ScanData> scans = [
    const ScanData(
      title: 'Chest PA View',
      date: '28 Apr 2026',
      subtitle: 'Chest PA — 28 Apr 2026',
      modality: 'X-Ray (CR)',
      bodyPart: 'Chest PA',
      radiologist: 'Dr. Kavita Mehta',
      institution: 'AIIMS Rishikesh',
      accessionNo: 'RAD-2026-0421',
      dob: '12/03/1978',
      ref: 'RAD-2026-0421',
      technicalData: 'KVp: 110 | mAs: 4',
      wwWl: 'WW: 350 | WL: 40',
      notes:
          'Mild cardiomegaly noted. Follow-up recommended in 3 months or sooner if symptomatic. No active lung pathology. Bony skeleton intact. No rib fractures.',
      aiFindings: [
        {
          'title': 'Lungs',
          'desc':
              'Both lung fields are clear. No consolidation, pleural effusion, or pneumothorax detected. Cardiothoracic ratio within normal limits (0.46).',
          'isWarning': false,
        },
        {
          'title': 'Mild Cardiomegaly',
          'desc':
              'Slight increase in cardiac silhouette (CT ratio 0.51). Suggest echocardiogram for confirmation. May correlate with hypertensive disease.',
          'isWarning': true,
        },
      ],
    ),
    const ScanData(
      title: 'Chest Lat View',
      date: '28 Apr 2026',
      subtitle: 'Chest Lateral — 28 Apr 2026',
      modality: 'X-Ray (CR)',
      bodyPart: 'Chest Lat',
      radiologist: 'Dr. Kavita Mehta',
      institution: 'AIIMS Rishikesh',
      accessionNo: 'RAD-2026-0422',
      dob: '12/03/1978',
      ref: 'RAD-2026-0422',
      technicalData: 'KVp: 115 | mAs: 5',
      wwWl: 'WW: 400 | WL: 50',
      notes:
          'Lateral view confirms minimal retrosternal space narrowing. Lung bases clear. No pleural fluid.',
      aiFindings: [
        {
          'title': 'Lungs',
          'desc': 'Lungs clear. Retrocardiac space preserved.',
          'isWarning': false,
        },
      ],
    ),
    const ScanData(
      title: 'Knee AP View',
      date: '15 Jan 2026',
      subtitle: 'Knee AP — 15 Jan 2026',
      modality: 'X-Ray (CR)',
      bodyPart: 'Right Knee AP',
      radiologist: 'Dr. Suresh Gupta',
      institution: 'Doon Hospital',
      accessionNo: 'RAD-2026-0089',
      dob: '12/03/1978',
      ref: 'RAD-2026-0089',
      technicalData: 'KVp: 60 | mAs: 8',
      wwWl: 'WW: 800 | WL: 120',
      notes:
          'Post-arthroscopy changes seen. Joint space preserved. No new effusion. Hardware intact. Bony alignment maintained.',
      aiFindings: [
        {
          'title': 'Joint Space',
          'desc':
              'Preservation of medial and lateral joint spaces. No acute fracture.',
          'isWarning': false,
        },
      ],
    ),
    const ScanData(
      title: 'USG Abd View',
      date: '10 Mar 2026',
      subtitle: 'USG Abdomen — 10 Mar 2026',
      modality: 'Ultrasound (USG)',
      bodyPart: 'Abdomen & Pelvis',
      radiologist: 'Dr. Priya Kapoor',
      institution: 'Himalayan Hospital',
      accessionNo: 'RAD-2026-0318',
      dob: '12/03/1978',
      ref: 'RAD-2026-0318',
      technicalData: 'Freq: 3.5 MHz | Gain: 65 dB',
      wwWl: 'DR: 75 dB',
      notes:
          'Liver mildly enlarged (15.2 cm). Mild fatty infiltration Grade I. Gall bladder, pancreas, spleen, both kidneys — normal. No free fluid.',
      aiFindings: [
        {
          'title': 'Hepatomegaly',
          'desc':
              'Liver measures 15.2 cm. Mild fatty changes. Other solid organs normal.',
          'isWarning': true,
        },
      ],
    ),
    const ScanData(
      title: 'ECG Wave View',
      date: '13 May 2026',
      subtitle: 'ECG — 13 May 2026',
      modality: 'ECG',
      bodyPart: 'Heart Rhythm',
      radiologist: 'Dr. Rajesh Kumar',
      institution: 'AIIMS Rishikesh',
      accessionNo: 'ECG-2026-9921',
      dob: '12/03/1978',
      ref: 'ECG-2026-9921',
      technicalData: 'Speed: 25 mm/s | Gain: 10 mm/mV',
      wwWl: 'Filters: 0.05-150 Hz',
      notes:
          'Normal sinus rhythm. Heart rate 72 bpm. PR interval 160ms. No significant ST-T wave abnormalities.',
      aiFindings: [
        {
          'title': 'Sinus Rhythm',
          'desc': 'Regular rate and rhythm. No acute ischemia signs.',
          'isWarning': false,
        },
      ],
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = ref.watch(activeScanIndexProvider);
    final scan = scans[activeIndex];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF050D14),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _Toolbar(),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 900) {
                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(width: 160, child: _ThumbnailsSidebar()),
                        Container(width: 1, color: AppColors.border),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1.2,
                            child: _CanvasArea(scan: scan),
                          ),
                        ),
                        Container(width: 1, color: AppColors.border),
                        SizedBox(width: 260, child: _DetailsPanel(scan: scan)),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _ThumbnailsRow(),
                      Container(height: 1, color: AppColors.border),
                      AspectRatio(
                        aspectRatio: 1.1,
                        child: _CanvasArea(scan: scan),
                      ),
                      Container(height: 1, color: AppColors.border),
                      _DetailsPanel(scan: scan),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Toolbar extends ConsumerWidget {
  const _Toolbar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTool = ref.watch(activeToolProvider);
    final inverted = ref.watch(imageInvertedProvider);

    Widget buildButton(
      String label,
      IconData icon, {
      bool isToggle = false,
      bool isToggled = false,
    }) {
      final isActive = isToggle ? isToggled : activeTool == label;
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (isToggle) {
              ref.read(imageInvertedProvider.notifier).state = !inverted;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    inverted ? 'Inversion disabled' : 'Inversion enabled',
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            } else if (label == 'Export') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Downloading DICOM file...'),
                  duration: Duration(seconds: 1),
                ),
              );
            } else {
              ref.read(activeToolProvider.notifier).state = label;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Tool switched to $label'),
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          },
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF00B4D8).withValues(alpha: 0.2)
                  : Colors.transparent,
              border: Border.all(
                color: isActive
                    ? const Color(0xFF00B4D8).withValues(alpha: 0.5)
                    : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 13,
                  color: isActive
                      ? const Color(0xFF00B4D8)
                      : AppColors.secondaryText,
                ),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: isActive
                        ? const Color(0xFF00B4D8)
                        : AppColors.secondaryText,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      color: const Color(0xFF081A2D),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.broken_image_outlined,
                color: Color(0xFF00B4D8),
                size: 14,
              ),
              const SizedBox(width: 6),
              Text(
                'PACS Active Viewer',
                style: AppTextStyles.labelMedium.copyWith(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          buildButton('W/L', Icons.tune),
          buildButton('Zoom', Icons.zoom_in),
          buildButton('Pan', Icons.pan_tool_rounded),
          buildButton('Measure', Icons.square_foot),
          buildButton('Annotate', Icons.draw),
          buildButton(
            'Invert',
            Icons.hdr_strong,
            isToggle: true,
            isToggled: inverted,
          ),
          buildButton('Export', Icons.download),
        ],
      ),
    );
  }
}

class _ThumbnailsSidebar extends ConsumerWidget {
  const _ThumbnailsSidebar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = ref.watch(activeScanIndexProvider);

    return Container(
      color: const Color(0xFF060E1A),
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: DicomViewerPanel.scans.length,
        separatorBuilder: (c, i) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          final scan = DicomViewerPanel.scans[index];
          final isActive = index == activeIndex;
          return _buildThumbItem(ref, index, scan, isActive);
        },
      ),
    );
  }
}

class _ThumbnailsRow extends ConsumerWidget {
  const _ThumbnailsRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = ref.watch(activeScanIndexProvider);

    return Container(
      color: const Color(0xFF060E1A),
      height: 90,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: DicomViewerPanel.scans.length,
        separatorBuilder: (c, i) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final scan = DicomViewerPanel.scans[index];
          final isActive = index == activeIndex;
          return SizedBox(
            width: 110,
            child: _buildThumbItem(ref, index, scan, isActive),
          );
        },
      ),
    );
  }
}

Widget _buildThumbItem(WidgetRef ref, int index, ScanData scan, bool isActive) {
  var icon = Icons.image_rounded;
  var iconColor = Colors.white24;

  if (scan.title.contains('Chest')) {
    icon = Icons.align_vertical_center_rounded;
    iconColor = const Color(0xFF00B4D8).withValues(alpha: 0.4);
  } else if (scan.title.contains('Knee')) {
    icon = Icons.airline_seat_legroom_extra_rounded;
    iconColor = const Color(0xFFC77DFF).withValues(alpha: 0.4);
  } else if (scan.title.contains('USG')) {
    icon = Icons.radio_button_checked_rounded;
    iconColor = const Color(0xFF22C55E).withValues(alpha: 0.4);
  } else if (scan.title.contains('ECG')) {
    icon = Icons.monitor_heart_rounded;
    iconColor = const Color(0xFFEF4444).withValues(alpha: 0.4);
  }

  return InkWell(
    onTap: () {
      ref.read(activeScanIndexProvider.notifier).state = index;
    },
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F2137),
        border: Border.all(
          color: isActive ? const Color(0xFF00B4D8) : AppColors.border,
          width: isActive ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Colors.black45,
              alignment: Alignment.center,
              child: Icon(icon, size: 28, color: iconColor),
            ),
          ),
          Container(
            color: const Color(0xFF081A2D),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
            child: Text(
              scan.title,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}

class _CanvasArea extends ConsumerWidget {
  const _CanvasArea({required this.scan});
  final ScanData scan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inverted = ref.watch(imageInvertedProvider);
    final activeTool = ref.watch(activeToolProvider);
    final activeIndex = ref.watch(activeScanIndexProvider);

    Widget buildPainter() {
      switch (activeIndex) {
        case 0:
          return CustomPaint(
            size: Size.infinite,
            painter: _ChestPAXrayPainter(),
          );
        case 1:
          return CustomPaint(
            size: Size.infinite,
            painter: _ChestLateralXrayPainter(),
          );
        case 2:
          return CustomPaint(size: Size.infinite, painter: _KneeXrayPainter());
        case 3:
          return CustomPaint(size: Size.infinite, painter: _UsgPainter());
        case 4:
          return CustomPaint(size: Size.infinite, painter: _EcgPainter());
        default:
          return const Center(child: Text('No Image Available'));
      }
    }

    return ColoredBox(
      color: Colors.black,
      child: Stack(
        children: [
          // Simulated scan display with color filtering for inversion
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: inverted
                  ? const ColorFilter.matrix([
                      -1,
                      0,
                      0,
                      0,
                      255,
                      0,
                      -1,
                      0,
                      0,
                      255,
                      0,
                      0,
                      -1,
                      0,
                      255,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ])
                  : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    radius: 0.8,
                    colors: [Color(0xFF0F2C4C), Color(0xFF040A10)],
                  ),
                ),
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: buildPainter(),
              ),
            ),
          ),
          // Technical text overlays
          Positioned(
            top: 10,
            left: 10,
            child: Text(
              'Patient: RAMESH KUMAR\nDOB: ${scan.dob}\nStudy: ${scan.bodyPart.toUpperCase()}\nDate: ${scan.date}\nRef: ${scan.accessionNo}\n${scan.technicalData}',
              style: const TextStyle(
                color: Color(0xFF00C897),
                fontSize: 9,
                fontFamily: 'monospace',
                height: 1.4,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Text(
              '${scan.wwWl}\nZoom: 100%\nSlice: 1/1\nTool: $activeTool',
              style: const TextStyle(
                color: Color(0xFF00C897),
                fontSize: 9,
                fontFamily: 'monospace',
                height: 1.4,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsPanel extends StatelessWidget {
  const _DetailsPanel({required this.scan});
  final ScanData scan;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0B1928),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'STUDY DETAILS',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildRow('Modality', scan.modality),
          _buildRow('Body Part', scan.bodyPart),
          _buildRow('Date', scan.date),
          _buildRow('Radiologist', scan.radiologist),
          _buildRow('Institution', scan.institution),
          _buildRow('Accession No.', scan.accessionNo),
          const SizedBox(height: AppSpacing.md),
          Container(height: 1, color: AppColors.border),
          const SizedBox(height: AppSpacing.md),
          Text(
            'AI FINDINGS',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ...scan.aiFindings.map(_buildFindingBox),
          const SizedBox(height: AppSpacing.md),
          Container(height: 1, color: AppColors.border),
          const SizedBox(height: AppSpacing.md),
          Text(
            'RADIOLOGIST NOTES',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            scan.notes,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 10,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 10,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFindingBox(Map<String, dynamic> finding) {
    final isWarn = finding['isWarning'] as bool;
    final title = finding['title'] as String;
    final desc = finding['desc'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isWarn
            ? AppColors.secondaryAccent.withValues(alpha: 0.05)
            : const Color(0xFF00B4D8).withValues(alpha: 0.05),
        border: Border.all(
          color: isWarn
              ? AppColors.secondaryAccent.withValues(alpha: 0.2)
              : const Color(0xFF00B4D8).withValues(alpha: 0.15),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isWarn
                  ? AppColors.secondaryAccent
                  : const Color(0xFF00B4D8),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            desc,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 9,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// SCAN CUSTOM PAINTERS

class _ChestPAXrayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final lungPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..style = PaintingStyle.fill;

    // Draw Spine
    final spinePath = Path()
      ..moveTo(size.width / 2, 10)
      ..lineTo(size.width / 2, size.height - 10);
    canvas.drawPath(spinePath, paint);

    // Ribs
    for (var i = 0; i < 9; i++) {
      final y = 30.0 + (i * 22.0);
      final leftRib = Path()
        ..moveTo(size.width / 2, y)
        ..quadraticBezierTo(
          size.width * 0.1,
          y + 10,
          size.width * 0.15,
          y + 20,
        );
      canvas.drawPath(leftRib, paint);

      final rightRib = Path()
        ..moveTo(size.width / 2, y)
        ..quadraticBezierTo(
          size.width * 0.9,
          y + 10,
          size.width * 0.85,
          y + 20,
        );
      canvas.drawPath(rightRib, paint);
    }

    // Lungs
    final leftLung = Rect.fromLTWH(
      size.width * 0.18,
      30,
      size.width * 0.24,
      size.height - 70,
    );
    final rightLung = Rect.fromLTWH(
      size.width * 0.58,
      30,
      size.width * 0.24,
      size.height - 70,
    );
    canvas
      ..drawOval(leftLung, lungPaint)
      ..drawOval(rightLung, lungPaint);

    // Heart
    final heartPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;
    final heartPath = Path()
      ..moveTo(size.width / 2 - 8, size.height / 2)
      ..quadraticBezierTo(
        size.width * 0.33,
        size.height * 0.64,
        size.width / 2,
        size.height * 0.72,
      )
      ..quadraticBezierTo(
        size.width * 0.58,
        size.height * 0.58,
        size.width / 2 - 8,
        size.height / 2,
      );
    canvas.drawPath(heartPath, heartPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ChestLateralXrayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final shapePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    // Lateral Spine (curved line on the left side)
    final spinePath = Path()
      ..moveTo(size.width * 0.25, 20)
      ..quadraticBezierTo(
        size.width * 0.2,
        size.height * 0.5,
        size.width * 0.3,
        size.height - 20,
      );
    canvas.drawPath(spinePath, paint);

    // Sternum (bone on the right side)
    final sternumPath = Path()
      ..moveTo(size.width * 0.75, 40)
      ..quadraticBezierTo(
        size.width * 0.8,
        size.height * 0.4,
        size.width * 0.75,
        size.height * 0.65,
      );
    canvas.drawPath(sternumPath, paint);

    // Lung silhouette profile
    final lungPath = Path()
      ..moveTo(size.width * 0.35, 30)
      ..quadraticBezierTo(
        size.width * 0.8,
        10,
        size.width * 0.72,
        size.height * 0.5,
      )
      ..quadraticBezierTo(
        size.width * 0.8,
        size.height - 40,
        size.width * 0.45,
        size.height - 35,
      )
      ..close();
    canvas
      ..drawPath(lungPath, shapePaint)
      ..drawPath(lungPath, paint);

    // Heart silhouette profile
    final heartPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;
    final heartPath = Path()
      ..moveTo(size.width * 0.45, size.height * 0.45)
      ..quadraticBezierTo(
        size.width * 0.68,
        size.height * 0.52,
        size.width * 0.62,
        size.height * 0.68,
      )
      ..quadraticBezierTo(
        size.width * 0.4,
        size.height * 0.65,
        size.width * 0.45,
        size.height * 0.45,
      );
    canvas.drawPath(heartPath, heartPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _KneeXrayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final bonePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Femur (Upper Bone)
    final femurPath = Path()
      ..moveTo(w * 0.38, 10)
      ..lineTo(w * 0.38, h * 0.38)
      ..quadraticBezierTo(w * 0.34, h * 0.45, w * 0.32, h * 0.46)
      ..lineTo(w * 0.46, h * 0.46)
      ..quadraticBezierTo(w * 0.5, h * 0.44, w * 0.5, h * 0.4)
      ..lineTo(w * 0.5, h * 0.46)
      ..lineTo(w * 0.64, h * 0.46)
      ..quadraticBezierTo(w * 0.64, h * 0.44, w * 0.62, h * 0.38)
      ..lineTo(w * 0.62, 10)
      ..close();
    canvas
      ..drawPath(femurPath, bonePaint)
      ..drawPath(femurPath, paint);

    // Tibia (Lower Bone)
    final tibiaPath = Path()
      ..moveTo(w * 0.32, h * 0.54)
      ..quadraticBezierTo(w * 0.4, h * 0.54, w * 0.44, h * 0.56)
      ..lineTo(w * 0.54, h * 0.56)
      ..quadraticBezierTo(w * 0.58, h * 0.54, w * 0.64, h * 0.54)
      ..lineTo(w * 0.6, h * 0.65)
      ..lineTo(w * 0.6, h - 10)
      ..lineTo(w * 0.4, h - 10)
      ..lineTo(w * 0.4, h * 0.65)
      ..close();
    canvas
      ..drawPath(tibiaPath, bonePaint)
      ..drawPath(tibiaPath, paint);

    // Fibula (Thinner side bone)
    final fibulaPath = Path()
      ..moveTo(w * 0.66, h * 0.58)
      ..lineTo(w * 0.72, h * 0.58)
      ..lineTo(w * 0.68, h - 10)
      ..lineTo(w * 0.64, h - 10)
      ..close();
    canvas
      ..drawPath(fibulaPath, bonePaint)
      ..drawPath(fibulaPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _UsgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final wavePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final shapePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Transducer Sector Wedge outline
    final wedgePath = Path()
      ..moveTo(w / 2, 20)
      ..lineTo(w * 0.15, h - 20)
      ..arcToPoint(Offset(w * 0.85, h - 20), radius: Radius.circular(h))
      ..close();
    canvas
      ..drawPath(wedgePath, shapePaint)
      ..drawPath(wedgePath, paint);

    // Arc wave lines
    for (var i = 1; i <= 6; i++) {
      final fraction = i / 6.0;
      final radius = (h - 40) * fraction;
      canvas.drawCircle(Offset(w / 2, 20), radius, paint);
    }

    // Draw fuzzy organic shapes representing liver / abdominal structures
    final liverOutline = Path()
      ..moveTo(w * 0.35, h * 0.45)
      ..quadraticBezierTo(w * 0.5, h * 0.35, w * 0.7, h * 0.48)
      ..quadraticBezierTo(w * 0.75, h * 0.62, w * 0.58, h * 0.75)
      ..quadraticBezierTo(w * 0.4, h * 0.72, w * 0.35, h * 0.45)
      ..close();
    canvas.drawPath(liverOutline, wavePaint);

    final innerOutline = Path()
      ..moveTo(w * 0.4, h * 0.55)
      ..quadraticBezierTo(w * 0.48, h * 0.48, w * 0.58, h * 0.58)
      ..quadraticBezierTo(w * 0.55, h * 0.68, w * 0.42, h * 0.62)
      ..close();
    canvas.drawPath(innerOutline, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _EcgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Draw Grid Lines (standard ECG paper grid)
    final gridPaint = Paint()
      ..color = const Color(0xFFEF4444).withValues(alpha: 0.08)
      ..strokeWidth = 0.5;

    final majorGridPaint = Paint()
      ..color = const Color(0xFFEF4444).withValues(alpha: 0.18)
      ..strokeWidth = 1.0;

    const step = 8.0;
    for (var x = 0.0; x < w; x += step) {
      final isMajor = (x / step).round() % 5 == 0;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, h),
        isMajor ? majorGridPaint : gridPaint,
      );
    }
    for (var y = 0.0; y < h; y += step) {
      final isMajor = (y / step).round() % 5 == 0;
      canvas.drawLine(
        Offset(0, y),
        Offset(w, y),
        isMajor ? majorGridPaint : gridPaint,
      );
    }

    // Draw green ECG trace lines (P-Q-R-S-T heartbeat wave)
    final ecgPaint = Paint()
      ..color = const Color(0xFF22C55E)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final tracePath = Path()..moveTo(0, h / 2);

    const period = 90.0;
    for (var x = 0.0; x < w; x += 1.0) {
      final t = x % period;
      var dy = 0.0;

      if (t > 15 && t <= 25) {
        // P Wave
        final radians = (t - 15) / 10.0 * 3.14159;
        dy = -Math.sin(radians) * 6.0;
      } else if (t > 28 && t <= 32) {
        // Q Wave
        dy = (t - 28) / 4.0 * 8.0;
      } else if (t > 32 && t <= 36) {
        // R Wave (Tall Spike)
        dy = -48.0 + (t - 32) / 4.0 * 48.0;
      } else if (t > 36 && t <= 40) {
        // S Wave
        dy = (t - 36) / 4.0 * 12.0;
      } else if (t > 40 && t <= 44) {
        // Return to baseline
        dy = 12.0 - (t - 40) / 4.0 * 12.0;
      } else if (t > 52 && t <= 68) {
        // T Wave
        final radians = (t - 52) / 16.0 * 3.14159;
        dy = -Math.sin(radians) * 12.0;
      }

      tracePath.lineTo(x, h / 2 + dy);
    }
    canvas.drawPath(tracePath, ecgPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Math.sin helper for Dart compilation
class Math {
  static double sin(double radians) =>
      double.tryParse(
        (radians -
                (radians * radians * radians / 6) +
                (radians * radians * radians * radians * radians / 120))
            .toStringAsFixed(6),
      ) ??
      0.0;
}
