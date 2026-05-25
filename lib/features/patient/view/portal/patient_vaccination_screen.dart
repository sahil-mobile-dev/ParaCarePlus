import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/vaccination/family_vaccination_heatmap.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/vaccination/immunization_record_table.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/vaccination/upcoming_vaccinations.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/vaccination/vaccination_charts.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/vaccination/vaccination_kpi_grid.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientVaccinationScreen extends ConsumerWidget {
  const PatientVaccinationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayStr = DateFormat('dd MMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientVaccination,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: AppColors.primaryText),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.vaccines_rounded,
              color: AppColors.primaryLight,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Vaccination & Immunization',
              style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
            ),
          ],
        ),
        actions: const [
          // Patient Switched Name Badge
        ],
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primaryLight.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person_outline_rounded,
                        color: AppColors.primaryLight,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Ramesh Kumar',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.primaryLight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Today's Date Badge
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Text(
                    todayStr,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Book Vaccine Button
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Opening vaccination booking…'),
                        backgroundColor: AppColors.surface,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    size: 12,
                    color: AppColors.success,
                  ),
                  label: const Text(
                    'Book Vaccine',
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.success.withValues(alpha: 0.15),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: AppColors.success.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            // KPI Grid Summary
            const VaccinationKpiGrid(),
            const SizedBox(height: AppSpacing.lg),

            // Upcoming & Overdue List
            const UpcomingVaccinations(),
            const SizedBox(height: AppSpacing.lg),

            // Complete Immunization Record Table
            const ImmunizationRecordTable(),
            const SizedBox(height: AppSpacing.lg),

            // Coverage and Status Charts
            const VaccinationCharts(),
            const SizedBox(height: AppSpacing.lg),

            // Family Vaccination Heatmap
            const FamilyVaccinationHeatmap(),
          ],
        ),
      ),
    );
  }
}
