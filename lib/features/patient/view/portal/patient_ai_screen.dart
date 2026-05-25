import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/ai/ai_charts.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/ai/ai_chat_workspace.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/ai/ai_esanjeevani.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/ai/ai_feature_suite.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/ai/ai_insights.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/ai/ai_kpis.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/ai/ai_predictive_risks.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientAiScreen extends ConsumerWidget {
  const PatientAiScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientAI,
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
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CLINICAL AI ASSISTANT',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1.1,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'ABDM-Certified Medical Model v2.4',
              style: TextStyle(
                color: AppColors.secondaryText,
                fontSize: 9,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 12, bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.15),
              border: Border.all(
                color: AppColors.success.withValues(alpha: 0.4),
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'HIPAA SECURE',
                  style: TextStyle(
                    color: AppColors.success,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top KPIs Strip
              AiKpis(),
              const SizedBox(height: AppSpacing.lg),

              // AI Feature Suite Grid
              AiFeatureSuite(),
              const SizedBox(height: AppSpacing.lg),

              // MedBot Chat & Analytics Workspace
              AiChatWorkspace(),
              const SizedBox(height: AppSpacing.lg),

              // Predictive Risk Cards
              AiPredictiveRisks(),
              const SizedBox(height: AppSpacing.lg),

              // Personalised AI Health Insights
              AiInsights(),
              const SizedBox(height: AppSpacing.lg),

              // Bottom Analytics Charts
              AiCharts(),
              const SizedBox(height: AppSpacing.lg),

              // eSanjeevani Integration
              AiEsanjeevani(),
            ],
          ),
        ),
      ),
    );
  }
}
