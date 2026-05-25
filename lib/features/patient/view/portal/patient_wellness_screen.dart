import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/wellness/wellness_charts.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/wellness/wellness_checkups.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/wellness/wellness_goals.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/wellness/wellness_heatmap.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/wellness/wellness_kpis.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/wellness/wellness_score_hero.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientWellnessScreen extends ConsumerWidget {
  const PatientWellnessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDateStr = DateFormat('dd MMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientWellness,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'WELLNESS & PREVENTIVE HEALTH',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            letterSpacing: 1.1,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.15),
                      border: Border.all(
                        color: AppColors.success.withValues(alpha: 0.3),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.person_rounded,
                          color: AppColors.success,
                          size: 11,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Ramesh Kumar',
                          style: TextStyle(
                            color: AppColors.success,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight.withValues(alpha: 0.15),
                      border: Border.all(
                        color: AppColors.primaryLight.withValues(alpha: 0.3),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      currentDateStr,
                      style: const TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Page Header Area
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.spa_rounded,
                        color: AppColors.success,
                        size: 22,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Wellness & Lifestyle',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // KPI Cards
              const WellnessKpis(),
              const SizedBox(height: AppSpacing.lg),

              // Wellness Score Hero (Ring & Dimensions)
              const WellnessScoreHero(),
              const SizedBox(height: AppSpacing.lg),

              // Daily Wellness Goals
              const WellnessGoals(),
              const SizedBox(height: AppSpacing.lg),

              // Preventive Health Checkups
              const WellnessCheckups(),
              const SizedBox(height: AppSpacing.lg),

              // Lifestyle Risk Factor Heatmap
              const WellnessHeatmap(),
              const SizedBox(height: AppSpacing.lg),

              // Charts
              const WellnessCharts(),
            ],
          ),
        ),
      ),
    );
  }
}
