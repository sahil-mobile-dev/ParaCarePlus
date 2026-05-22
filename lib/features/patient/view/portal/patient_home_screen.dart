import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/home/home_actionable_banners.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/home/home_ai_insights.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/home/home_disease_risk.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/home/home_insurance_card.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/home/home_journey_timeline.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/home/home_medication_schedule.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/home/home_recent_lab.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/home/home_upcoming_appointments.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/home/home_vitals_trend.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/home/home_wellness_lifestyle.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_abha_strip.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_alert_ticker.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_health_hero.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_home_header.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_kpi_grid.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_quick_actions.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientHomeScreen extends ConsumerWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientHome,
      ),
      appBar: PatientHomeHeader(
        onShowQR: () => PatientAbhaStrip.showAbhaQrDialog(context),
      ),
      body: Column(
        children: [
          const PatientAlertTicker(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const PatientHealthHero(),
                  const SizedBox(height: AppSpacing.md),
                  const HomeActionableBanners(),
                  const SizedBox(height: AppSpacing.lg),
                  _buildSectionHeader(
                    context,
                    'My Health at a Glance',
                    RouteNames.patientHealthAnalytics,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const PatientKpiGrid(),
                  const SizedBox(height: AppSpacing.lg),
                  const Text('QUICK ACTIONS', style: AppTextStyles.labelSmall),
                  const SizedBox(height: AppSpacing.md),
                  const PatientQuickActions(),
                  const SizedBox(height: AppSpacing.lg),
                  const PatientAbhaStrip(),
                  const SizedBox(height: AppSpacing.lg),
                  _buildGridTwoColumnSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    String routeName,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.grid_view_rounded,
              color: AppColors.primaryLight,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: AppTextStyles.labelMedium.copyWith(color: Colors.white),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => context.pushNamed(routeName),
          child: const Text(
            'Full Analytics →',
            style: TextStyle(
              color: AppColors.primaryLight,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGridTwoColumnSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = AppSpacing.lg;
        if (constraints.maxWidth > 800) {
          // Double column for tablet/web
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    HomeVitalsTrend(),
                    SizedBox(height: spacing),
                    HomeUpcomingAppointments(),
                    SizedBox(height: spacing),
                    HomeRecentLab(),
                    SizedBox(height: spacing),
                    HomeJourneyTimeline(),
                  ],
                ),
              ),
              SizedBox(width: spacing),
              Expanded(
                child: Column(
                  children: [
                    HomeAiInsights(),
                    SizedBox(height: spacing),
                    HomeMedicationSchedule(),
                    SizedBox(height: spacing),
                    HomeDiseaseRisk(),
                    SizedBox(height: spacing),
                    HomeWellnessLifestyle(),
                    SizedBox(height: spacing),
                    HomeInsuranceCard(),
                  ],
                ),
              ),
            ],
          );
        } else {
          // Single column for mobile
          return const Column(
            children: [
              HomeVitalsTrend(),
              SizedBox(height: spacing),
              HomeAiInsights(),
              SizedBox(height: spacing),
              HomeUpcomingAppointments(),
              SizedBox(height: spacing),
              HomeMedicationSchedule(),
              SizedBox(height: spacing),
              HomeRecentLab(),
              SizedBox(height: spacing),
              HomeDiseaseRisk(),
              SizedBox(height: spacing),
              HomeWellnessLifestyle(),
              SizedBox(height: spacing),
              HomeInsuranceCard(),
              SizedBox(height: spacing),
              HomeJourneyTimeline(),
            ],
          );
        }
      },
    );
  }
}
