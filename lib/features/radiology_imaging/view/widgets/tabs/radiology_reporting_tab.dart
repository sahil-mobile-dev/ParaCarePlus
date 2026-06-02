import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

import 'package:paracareplus/features/radiology_imaging/view_model/radiology_imaging_view_model.dart';

class RadiologyReportingTab extends ConsumerStatefulWidget {
  const RadiologyReportingTab({super.key});

  @override
  ConsumerState<RadiologyReportingTab> createState() => _RadiologyReportingTabState();
}

class _RadiologyReportingTabState extends ConsumerState<RadiologyReportingTab> {
  final _findingsController = TextEditingController(
    text: 'Lungs: Bilateral lower lobe consolidation with air bronchograms noted. No pleural effusion. Mediastinum: No significant lymphadenopathy. Heart: Normal size.',
  );
  final _impressionController = TextEditingController(
    text: 'Bilateral lower lobe pneumonia. No features of pulmonary embolism. Correlate clinically.',
  );
  int _selectedThumbnail = 0;

  @override
  void dispose() {
    _findingsController.dispose();
    _impressionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        final reportingContent = [
          // Left: DICOM Viewer
          Expanded(
            flex: isWide ? 1 : 0,
            child: Column(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.medical_services_rounded, size: 64, color: Colors.white24),
                        const SizedBox(height: 10),
                        const Text(
                          'DICOM VIEWER',
                          style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Active Image Series: Frame $_selectedThumbnail',
                          style: const TextStyle(color: AppColors.secondaryText, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Thumbnails strip
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(5, (index) {
                      final isSelected = index == _selectedThumbnail;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedThumbnail = index),
                        child: Container(
                          width: 60,
                          height: 60,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: isSelected ? AppColors.primaryLight : AppColors.border,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: const Icon(Icons.photo_rounded, color: Colors.white24, size: 24),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          if (isWide) const SizedBox(width: 14) else const SizedBox(height: 14),
          // Right: Report form
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
                  const Text('Report Findings', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    controller: _findingsController,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    decoration: const InputDecoration(
                      labelText: 'Findings',
                      labelStyle: TextStyle(color: AppColors.secondaryText),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.border)),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    controller: _impressionController,
                    maxLines: 3,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    decoration: const InputDecoration(
                      labelText: 'Impression / Diagnosis',
                      labelStyle: TextStyle(color: AppColors.secondaryText),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.border)),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
                        onPressed: () {
                          ref.read(radiologyImagingProvider.notifier).finalizeReport('RAD-001');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Report finalized and signed successfully.')),
                          );
                        },
                        icon: const Icon(Icons.check, size: 14, color: Colors.white),
                        label: const Text('Finalize Report', style: TextStyle(fontSize: 11, color: Colors.white)),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Save Draft', style: TextStyle(color: AppColors.secondaryText, fontSize: 11)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ];

        return isWide
            ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: reportingContent)
            : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: reportingContent);
      },
    );
  }
}
