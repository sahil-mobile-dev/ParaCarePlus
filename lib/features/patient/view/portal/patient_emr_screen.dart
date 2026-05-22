import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emr/emr_allergies_tab.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emr/emr_certificates_tab.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emr/emr_diagnoses_tab.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emr/emr_discharge_tab.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emr/emr_family_tab.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emr/emr_immunisation_tab.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emr/emr_notes_tab.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emr/emr_patient_header.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emr/emr_surgical_tab.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emr/emr_timeline_tab.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emr/emr_visits_tab.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emr/emr_vitals_tab.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientEMRScreen extends ConsumerWidget {
  const PatientEMRScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 11,
      child: Scaffold(
        backgroundColor: AppColors.background,
        drawer: const PatientPortalDrawer(
          activeRouteName: RouteNames.patientEMR,
        ),
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          elevation: 0,
          title: const Text(
            'Electronic Health Records (EMR/EHR)',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: AppColors.primaryText,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.md),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const EMRPatientHeader(),
                      const SizedBox(height: AppSpacing.sm),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const TabBar(
                          isScrollable: true,
                          indicatorColor: Color(0xFF00B4D8),
                          indicatorWeight: 3,
                          labelColor: Colors.white,
                          unselectedLabelColor: AppColors.secondaryText,
                          labelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          dividerHeight: 0,
                          unselectedLabelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          tabs: [
                            Tab(text: '📋 Medical Timeline'),
                            Tab(text: '🏥 Visit Summaries'),
                            Tab(text: '🩺 Diagnoses'),
                            Tab(text: '⚠️ Allergies'),
                            Tab(text: '🔬 Surgerical History'),
                            Tab(text: '👨‍👩‍👧 Family History'),
                            Tab(text: '💉 Immunisation'),
                            Tab(text: '📊 Vitals History'),
                            Tab(text: '📝 Doctor Notes'),
                            Tab(text: '🏠 Discharge Summaries'),
                            Tab(text: '📜 Certificates'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: EMRTimelineTab(),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: EMRVisitsTab(),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: EMRDiagnosesTab(),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: EMRAllergiesTab(),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: EMRSurgicalTab(),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: EMRFamilyTab(),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: EMRImmunisationTab(),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: EMRVitalsTab(),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: EMRNotesTab(),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: EMRDischargeTab(),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: EMRCertificatesTab(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
