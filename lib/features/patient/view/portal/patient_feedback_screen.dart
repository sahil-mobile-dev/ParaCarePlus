import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/feedback/feedback_charts.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/feedback/feedback_form.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/feedback/feedback_kpis.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/feedback/feedback_side_panel.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientFeedbackScreen extends ConsumerWidget {
  const PatientFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientFeedback,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.rate_review_outlined,
              color: AppColors.secondaryAccent,
              size: 18,
            ),
            SizedBox(width: 8),
            Text(
              'Reviews & Care Feedback',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [const SizedBox(width: 16)],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _AppBarBtn(
                    label: 'Feedback History',
                    icon: Icons.history_rounded,
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  _AppBarBtn(
                    label: 'Export',
                    icon: Icons.download_rounded,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Feedback history exported'),
                          backgroundColor: AppColors.surface,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: AppRadius.md),
              // KPI row
              const FeedbackKpis(),
              const SizedBox(height: AppSpacing.md),
              const FeedbackForm(),

              // Main 2-column layout
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2,
                child: const FeedbackSidePanel(),
              ),
              const SizedBox(height: AppSpacing.md),

              // Bottom charts row
              const FeedbackCharts(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBarBtn extends StatelessWidget {
  const _AppBarBtn({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: AppColors.secondaryText),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
