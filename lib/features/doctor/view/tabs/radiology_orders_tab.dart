import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/doctor/view_model/doctor_dashboard_view_model.dart';

class RadiologyOrdersTab extends ConsumerStatefulWidget {
  const RadiologyOrdersTab({super.key});

  @override
  ConsumerState<RadiologyOrdersTab> createState() => _RadiologyOrdersTabState();
}

class _RadiologyOrdersTabState extends ConsumerState<RadiologyOrdersTab> {
  bool _showDicomViewer = false;
  double _zoomLevel = 1;
  double _contrastLevel = 1;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(doctorDashboardViewModelProvider);
    final notifier = ref.read(doctorDashboardViewModelProvider.notifier);

    final isWide = MediaQuery.of(context).size.width > 950;
    // Filter purely radiology reports (starting with RAD)
    final radReports = state.labReports
        .where((r) => r.id.startsWith('RAD'))
        .toList();

    var currentReport = state.selectedReportToReview;
    if ((currentReport == null || !currentReport.id.startsWith('RAD')) &&
        radReports.isNotEmpty) {
      currentReport = radReports[0];
    }

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(radReports.length),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Left side - RIS queue
                      Expanded(
                        flex: 10,
                        child: _buildReportsQueue(radReports, currentReport, notifier),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      // Right side - Clinical verification desk & DICOM mockup
                      Expanded(
                        flex: 12,
                        child: _buildRadiologyWorkspace(currentReport, notifier),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: _buildReportsQueue(radReports, currentReport, notifier),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Expanded(
                        child: _buildRadiologyWorkspace(currentReport, notifier),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(int totalCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.settings_remote_outlined, color: AppColors.primaryLight, size: 28),
            SizedBox(width: 10),
            Text('Radiology Orders & Diagnostics (RIS)', style: AppTextStyles.titleMedium),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Review imaging diagnostics, modalities, and expert RIS reports. $totalCount active cases under tracking.',
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondaryText),
        ),
      ],
    );
  }

  Widget _buildReportsQueue(
    List<LabReport> reports,
    LabReport? currentReport,
    DoctorDashboardViewModel notifier,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RADIOLOGY WORKLIST (${reports.length})',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: reports.isEmpty
                ? _buildEmptyQueueState()
                : ListView.separated(
                    itemCount: reports.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, i) {
                      final r = reports[i];
                      final isSelected = currentReport?.id == r.id;
                      final isCT = r.testName.contains('CT');
                      final isEcho = r.testName.contains('Echo') || r.testName.contains('USG');

                      var modalityColor = Colors.teal;
                      var modalityText = 'X-RAY';
                      if (isCT) {
                        modalityColor = Colors.orange;
                        modalityText = 'CT SCAN';
                      } else if (isEcho) {
                        modalityColor = Colors.purple;
                        modalityText = 'ULTRASOUND';
                      }

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.surface
                              : AppColors.background.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.border,
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          onTap: () {
                            setState(() => _showDicomViewer = false);
                            notifier.selectReportToReview(r);
                          },
                          leading: CircleAvatar(
                            backgroundColor: isSelected
                                ? AppColors.primary
                                : modalityColor.withValues(alpha: 0.15),
                            child: Icon(
                              Icons.settings_remote_outlined,
                              color: isSelected ? Colors.white : modalityColor,
                              size: 18,
                            ),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  r.patientName,
                                  style: AppTextStyles.labelMedium.copyWith(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: modalityColor.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: modalityColor, width: 0.5),
                                ),
                                child: Text(
                                  modalityText,
                                  style: TextStyle(
                                    color: modalityColor,
                                    fontSize: 7.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                r.testName,
                                style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadiologyWorkspace(LabReport? report, DoctorDashboardViewModel notifier) {
    if (report == null) return _buildEmptyVerificationState();

    if (_showDicomViewer) {
      return _buildDicomViewerPanel(report);
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.surface,
                child: Icon(
                  Icons.settings_remote_outlined,
                  color: AppColors.primaryLight,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(report.patientName, style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text(
                      'RIS Study UID: ${report.id} · Performed: ${report.orderedDate}',
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondaryText),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.border, height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildSectionHeader('Radiology Scan modality'),
                const SizedBox(height: 6),
                Text(
                  report.testName,
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryText, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildSectionHeader('Radiologist Findings & Transcription'),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.assignment_outlined, color: AppColors.primaryLight, size: 18),
                          SizedBox(width: 8),
                          Text('RIS Transcription Note', style: AppTextStyles.labelSmall),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        report.resultSummary,
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 13,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildSectionHeader('ABDM PACS Compliance'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.cloud_done_rounded, color: AppColors.success, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'PACS imaging study locked with secure clinical token.',
                      style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.border, height: 20),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  icon: const Icon(Icons.refresh_rounded, size: 18, color: Colors.orange),
                  label: const Text('Re-scan Study', style: TextStyle(color: Colors.orange)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Re-scan investigation ordered for Patient ${report.patientName}.'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.picture_in_picture_alt_rounded, size: 18),
                  label: const Text('Launch DICOM Viewer'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    setState(() => _showDicomViewer = true);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDicomViewerPanel(LabReport report) {
    const mockImagePath = r'C:\Users\SHREE232\.gemini\antigravity-ide\brain\3fdf6894-4697-478d-8ae2-0f5cdde5ef93\radiology_dicom_mock_1779737475948.png';
    final hasFile = File(mockImagePath).existsSync();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFF070E17),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.grid_goldenratio_rounded, color: AppColors.primaryLight, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'PACS/DICOM Diagnostic Desk — ${report.patientName}',
                  style: AppTextStyles.labelMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded, color: Colors.white70),
                onPressed: () => setState(() => _showDicomViewer = false),
                tooltip: 'Exit DICOM Viewer',
              ),
            ],
          ),
          const Divider(color: Colors.white24, height: 10),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: hasFile
                      ? ColorFiltered(
                          colorFilter: ColorFilter.matrix([
                            _contrastLevel, 0, 0, 0, 0,
                            0, _contrastLevel, 0, 0, 0,
                            0, 0, _contrastLevel, 0, 0,
                            0, 0, 0, 1, 0,
                          ]),
                          child: Transform.scale(
                            scale: _zoomLevel,
                            child: Image.file(
                              File(mockImagePath),
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.broken_image_outlined, color: Colors.white24, size: 48),
                              const SizedBox(height: 12),
                              Text('No Imaging File Loaded', style: AppTextStyles.bodyMedium.copyWith(color: Colors.white38)),
                            ],
                          ),
                        ),
                ),
                // Calibration overlay mock
                Positioned(
                  left: 15,
                  bottom: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ZOOM: ${(_zoomLevel * 100).toInt()}%', style: const TextStyle(color: Colors.green, fontSize: 10, fontFamily: 'monospace')),
                      Text('CONTRAST: ${(_contrastLevel * 100).toInt()}%', style: const TextStyle(color: Colors.green, fontSize: 10, fontFamily: 'monospace')),
                      const Text('PACS ID: ABDM-CT-9824', style: TextStyle(color: Colors.green, fontSize: 10, fontFamily: 'monospace')),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDicomTool(Icons.zoom_in_rounded, 'Zoom In', () {
                setState(() => _zoomLevel = (_zoomLevel + 0.15).clamp(1.0, 3.0));
              }),
              _buildDicomTool(Icons.zoom_out_rounded, 'Zoom Out', () {
                setState(() => _zoomLevel = (_zoomLevel - 0.15).clamp(1.0, 3.0));
              }),
              _buildDicomTool(Icons.exposure_rounded, 'High Contrast', () {
                setState(() => _contrastLevel = (_contrastLevel + 0.2).clamp(1.0, 2.5));
              }),
              _buildDicomTool(Icons.restart_alt_rounded, 'Reset Controls', () {
                setState(() {
                  _zoomLevel = 1.0;
                  _contrastLevel = 1.0;
                });
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDicomTool(IconData icon, String label, VoidCallback onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, color: AppColors.primaryLight, size: 22),
          onPressed: onTap,
          style: IconButton.styleFrom(
            backgroundColor: const Color(0xFF132A46),
            padding: const EdgeInsets.all(8),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 9.5)),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: AppTextStyles.labelSmall.copyWith(
        color: AppColors.secondaryText,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildEmptyQueueState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.verified_rounded, size: 48, color: AppColors.success),
          SizedBox(height: 12),
          Text(
            'Imaging Studies Complete',
            style: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'All radiology reports are verified.',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyVerificationState() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings_remote_outlined, size: 48, color: AppColors.secondaryText),
            SizedBox(height: 12),
            Text(
              'Select Imaging Result',
              style: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Choose a report from worklist to display findings.',
              style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
