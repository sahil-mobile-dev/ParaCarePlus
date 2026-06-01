import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/radiology/dicom_viewer_panel.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/radiology/radiology_ai_panel.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/radiology/radiology_charts.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/radiology/radiology_history_grid.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/radiology/radiology_kpi_grid.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientRadiologyScreen extends ConsumerWidget {
  const PatientRadiologyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formattedDate = DateFormat('dd MMM yyyy').format(DateTime.now());

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
            // Page Header Section
            _buildPageHeader(context, formattedDate),
            const SizedBox(height: AppSpacing.md),

            // KPI Grid
            const RadiologyKpiGrid(),
            const SizedBox(height: AppSpacing.lg),

            // DICOM Viewer Section
            _buildSectionTitle(
              Icons.display_settings_rounded,
              'DICOM Viewer — Chest X-Ray (28 Apr 2026)',
            ),
            const SizedBox(height: AppSpacing.sm),
            const DicomViewerPanel(),
            const SizedBox(height: AppSpacing.lg),

            // AI Diagnostics Panel
            const RadiologyAiPanel(),
            const SizedBox(height: AppSpacing.lg),

            // History Grid Section
            _buildSectionTitle(Icons.history_rounded, 'Imaging History'),
            const SizedBox(height: AppSpacing.sm),
            const RadiologyHistoryGrid(),
            const SizedBox(height: AppSpacing.lg),

            // Comparative Charts
            const RadiologyCharts(),
          ],
        ),
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context, String dateStr) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final children = [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.document_scanner_outlined,
                color: Color(0xFF00B4D8),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Radiology & Imaging',
                style: AppTextStyles.titleMedium.copyWith(fontSize: 18),
              ),
            ],
          ),
          if (isMobile) const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _buildBadge(Icons.person_rounded, 'Ramesh Kumar'),
              _buildBadge(Icons.calendar_month_rounded, dateStr),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFFC77DFF,
                  ).withValues(alpha: 0.15),
                  foregroundColor: const Color(0xFFC77DFF),
                  side: BorderSide(
                    color: const Color(0xFFC77DFF).withValues(alpha: 0.3),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening DICOM upload...')),
                  );
                },
                icon: const Icon(Icons.upload_file_rounded, size: 12),
                label: const Text(
                  'Upload DICOM',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ];

        return isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: children,
              );
      },
    );
  }

  Widget _buildBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF00B4D8).withValues(alpha: 0.15),
        border: Border.all(
          color: const Color(0xFF00B4D8).withValues(alpha: 0.3),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF00B4D8), size: 11),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF00B4D8),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF00B4D8), size: 14),
        const SizedBox(width: 6),
        Text(
          title,
          style: AppTextStyles.labelMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
