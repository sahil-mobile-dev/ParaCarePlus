import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/prescription/active_prescription_cards.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/prescription/drug_interaction_checker.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/prescription/prescription_charts.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/prescription/prescription_kpi_grid.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/prescription/refill_reminders.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/prescription/today_medication_schedule.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientPrescriptionScreen extends ConsumerWidget {
  const PatientPrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formattedDate = DateFormat('dd MMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientPrescription,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('My Prescriptions'),
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
            const PrescriptionKpiGrid(),
            const SizedBox(height: AppSpacing.lg),

            // Today's Medication Schedule Checklist
            const TodayMedicationSchedule(),
            const SizedBox(height: AppSpacing.lg),

            // Active Prescriptions Section
            _buildSectionTitle(
              Icons.description_rounded,
              'Active Prescriptions',
            ),
            const SizedBox(height: AppSpacing.sm),
            const ActivePrescriptionCards(),
            const SizedBox(height: AppSpacing.lg),

            // Drug Interaction Checker Warning Panel
            const DrugInteractionChecker(),
            const SizedBox(height: AppSpacing.lg),

            // Refill Reminders
            _buildSectionTitle(
              Icons.notifications_active_rounded,
              'Refill Reminders',
            ),
            const SizedBox(height: AppSpacing.sm),
            const RefillReminders(),
            const SizedBox(height: AppSpacing.lg),

            // Medication Charts & Analytics
            const PrescriptionCharts(),
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
                Icons.medication_liquid_rounded,
                color: Color(0xFF00B4D8),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Prescriptions & Medications',
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
                  backgroundColor: AppColors.success.withValues(alpha: 0.15),
                  foregroundColor: AppColors.success,
                  side: BorderSide(
                    color: AppColors.success.withValues(alpha: 0.3),
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
                    const SnackBar(
                      content: Text('Opening pharmacy order refill form...'),
                    ),
                  );
                },
                icon: const Icon(Icons.local_pharmacy_rounded, size: 12),
                label: const Text(
                  'Order Refill',
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
